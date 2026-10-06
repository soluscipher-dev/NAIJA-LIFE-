# 19 - Testing Strategy

Version 1.0 | Money and permissions are tested hardest.

## 1. Pyramid
- **Unit (Vitest):** pure logic - economy math, tax, promotion rules, needs decay, permission checks.
- **Integration (Vitest + real Postgres/Redis in Docker):** services with DB: ledger, transfers, jobs, hustle, shops, auth.
- **API tests:** route-level (auth, validation, rate limits, error shapes).
- **Realtime tests:** Socket.IO client against test server - presence, scoped delivery, reconnect.
- **E2E (Playwright):** register -> verify -> create character -> first shift -> bank -> transfer; mobile viewport.
- **Load (k6):** see 18.
- **Security tests:** authz bypass attempts, injection, rate limit, replay of idempotency keys.

## 2. Must-have test suites
### Ledger
- entries sum to zero (property-based)
- no overspend under 100 concurrent debits
- idempotent replay
- deadlock-free crossing transfers
- reconcile detects drift
### Economy
- tax bands, rent schedule, interest caps, faucet budget per event
### Jobs
- shift timing, double-claim prevention, daily caps, promotion
### Hustle
- escrow lifecycle, disputes, timeouts
### Auth
- registration, verification, lockout, session revoke, password reset single-use
### Social
- block enforcement everywhere, privacy settings, report flow
### Admin
- RBAC allow/deny matrix, audit entries written

## 3. Test data
Factories for users, characters, accounts. Deterministic clock (fake timers) for shifts, rent, decay. Seed scripts for repeatable scenarios.

## 4. CI pipeline (GitHub Actions)
`install -> lint -> typecheck -> unit -> integration (services: postgres, redis) -> build -> e2e (on main/PR label)`. Block merge on failure. Coverage target: 80% on economy/ledger/auth modules (meaningful tests, not vanity).

## 5. Definition of done (tests)
New feature = unit + integration tests; money features also concurrency tests; bug fix = regression test first.

## 6. Manual QA checklists
Mobile devices (low-end Android, iOS Safari), slow 3G throttling, reconnect scenarios, notification flows, accessibility pass.

## 7. Playtests
Each phase: 5+ real players, observe the first 10 minutes, note confusion, fix, repeat.
