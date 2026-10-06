# Phase 5 - Ledger and Bank (CRITICAL)

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/07_BANKING_AND_LEDGER.md (read twice)
- docs/03_GAME_ECONOMY.md
- docs/15_SECURITY_AND_ANTI_CHEAT.md (section 5, 6)
- docs/decisions/ADR-0003-ledger.md, ADR-0005, ADR-0006

## Goal
A safe double-entry ledger and the Bank app: wallet, bank, transfers, history, receipts.

## In scope
- Ledger service: `postTransaction` with account locking (ascending id), idempotency, zero-sum check, balance_after, outbox events
- Helpers: transfer, charge, pay, deposit/withdraw (wallet <-> bank)
- System accounts seed (MINT, BURN, TAX, ESCROW, BANK_RESERVE, TREASURY)
- Starter grant on character creation (from MINT, idempotent)
- Endpoints: bank summary, deposit, withdraw, transfer, transactions (cursor), receipts
- Transfer rules: verified email, limits for new accounts, block checks, large-transfer flag
- Nightly reconcile job + alert log
- Bank UI: balance card, transfer flow with confirm sheet, history, receipt view; realtime `wallet.updated` / `transfer.received`
- config_parameters seed for limits and fees

## Out of scope (do NOT build)
- Savings/bonds/interest, taxes, hustle escrow (later phases)

## Acceptance criteria
- No money path bypasses the ledger service
- Concurrent transfers never overspend or deadlock
- Replaying the same Idempotency-Key returns the same result; different payload -> 409
- Reconcile job detects tampered balance in a test

## Required tests
- Property-based zero-sum tests
- 100 concurrent debits test
- Crossing transfers deadlock test
- Idempotency tests
- Authorization tests (cannot transfer from someone else's account)

## Rules reminder
- Server authoritative. Money only via the ledger service. Integers only for money.
- Zod validation + authorization on every route. Rate-limit sensitive endpoints.
- Config over hardcoding. No new dependencies without asking.
- Small commits (conventional commits). Update `CHANGELOG.md` and relevant docs.

## Before coding
Post a plan: files to create/change, data model changes, risks, open questions. Wait for approval if anything is ambiguous.

## When finished, report using this format
1. Implemented  2. NOT implemented  3. Files changed  4. Commands run + results (lint, typecheck, test, build)  5. Known issues / risks / questions
Do not claim completion if any check fails.
