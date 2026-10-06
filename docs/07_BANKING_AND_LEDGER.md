# 07 - Banking and Ledger (CRITICAL)

Version 1.0 | Read before touching any money code. ADR-0003.

## 1. Model
Double-entry ledger. Every transaction has 2+ entries; sum(entries.amount) = 0 within a transaction. Money is `bigint` whole naira.

Tables (see `db/schema.sql`): `ledger_accounts`, `ledger_transactions`, `ledger_entries`.

- `ledger_accounts`: id, owner_type (player, organization, system), owner_id, kind (wallet, bank, savings, bond, escrow, tax, burn, mint, reserve), balance (cached), currency, created_at.
- `ledger_transactions`: id, type, reference, idempotency_key (unique per actor), status (pending, posted, reversed, failed), metadata JSON, created_at, created_by.
- `ledger_entries`: id, transaction_id, account_id, amount (+credit/-debit), balance_after, created_at.

Cached `balance` on accounts is updated in the SAME DB transaction as entries. A nightly reconcile job recomputes balances from entries and alerts on drift.

## 2. Posting rules
1. Start DB transaction (isolation: read committed with explicit row locks).
2. Lock involved accounts in a consistent order (ascending id) with `SELECT ... FOR UPDATE` to prevent deadlocks.
3. Check idempotency key; if exists, return the original result.
4. Validate balance (no negatives unless account kind allows, e.g. mint).
5. Insert transaction + entries; update cached balances.
6. Commit. Emit events AFTER commit (outbox pattern for reliability).

## 3. Transaction types
`starter_grant, job_pay, hustle_escrow_hold, hustle_escrow_release, hustle_refund, transfer, purchase, rent, bill, tax, savings_deposit, savings_withdraw, savings_interest, bond_buy, bond_payout, investment_buy, investment_payout, event_reward, daily_reward, fee, refund, admin_adjustment`.

## 4. Service interface (only way to move money)
```ts
postTransaction({
  type, reference, idempotencyKey, actorId,
  entries: [{ accountId, amount }],   // sums to 0
  metadata?
}): Promise<LedgerTransaction>
```
Higher-level helpers: `transfer()`, `charge()`, `pay()`, `holdEscrow()`, `releaseEscrow()`. No other module updates balances.

## 5. Idempotency
- Client sends `Idempotency-Key` header (UUID) on every money endpoint.
- Unique constraint on (actor_id, idempotency_key).
- Same key + same payload -> same response. Same key + different payload -> 409.

## 6. Transfers
- Validate: sender verified, not restricted, receiver exists and not blocked-both-ways, amount > 0, within limits, balance sufficient.
- Limits: new-account limits (see 03), daily caps by tier, velocity checks.
- Receipt: reference code, timestamp, parties, amount, note (sanitized).

## 7. Wallet vs bank
- Wallet: cash for everyday spend. Bank: safer storage, interest eligible.
- Deposit/withdraw = internal transfers between the player's own accounts (no fee at MVP).

## 8. Escrow (hustle)
- On accept: poster wallet -> escrow account (`hustle_escrow_hold`).
- On both-confirm: escrow -> worker wallet minus platform fee (fee -> BURN).
- On cancel/dispute loss: escrow -> poster (`hustle_refund`).
- Timeouts auto-resolve per rules in 08.

## 9. Savings and bonds
- Savings: weekly interest rate from config, per-account weekly cap, paid from BANK_RESERVE (funded by fees/sinks). If reserve is empty, interest is reduced pro rata.
- Bonds: fixed term, fixed yield, early exit penalty.

## 10. Reversals
Never delete entries. A reversal is a new transaction with opposite entries linked via `metadata.reverses`. Admin adjustments require reason + audit record.

## 11. Reconciliation and monitoring
- Nightly: recompute balances, compare, alert.
- Metrics: txn/min, failures, p95 post time, lock waits, duplicates blocked.
- Alerts: negative balance, drift, spike in transfers, large single transfers (configurable threshold).

## 12. Required tests
- Sum-to-zero invariant property tests.
- Concurrent transfers from same account (no overspend).
- Duplicate idempotency key returns same result.
- Deadlock safety with crossing transfers.
- Escrow lifecycle (all branches).
- Reconcile detects tampering.

## 13. Never do
Floats. Direct `UPDATE accounts SET balance`. Client-provided amounts for rewards. Skipping idempotency. Emitting events before commit.
