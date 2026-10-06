# Roadmap Checklist

Tick items as completed. Each phase must satisfy its gate (tests, lint, types, build, docs, changelog).

## Phase 1 - Foundation
- [ ] pnpm monorepo (apps/web, apps/admin, apps/server, packages/shared, packages/db)
- [ ] TypeScript strict, ESLint, Prettier, Husky + lint-staged
- [ ] Docker Compose (Postgres, Redis)
- [ ] Drizzle setup + first migration from `db/schema.sql`
- [ ] Env validation (Zod), structured logging, error handler
- [ ] Vitest + Playwright setup, CI workflow
- [ ] Design tokens wired into Tailwind, base components
- [ ] Health endpoint, README commands verified

## Phase 2 - Auth and character
- [ ] Register, verify email, login, logout, reset password
- [ ] Sessions + device list + revoke
- [ ] Rate limiting + lockout
- [ ] Character creation (avatar config)
- [ ] Profile endpoint and page
- [ ] Tests (auth flows, rate limits)

## Phase 3 - World and map
- [ ] Seed starter city, districts, locations
- [ ] Map UI with hotspots + list fallback
- [ ] Travel endpoint + timers
- [ ] Location sheet + actions registry

## Phase 4 - Realtime
- [ ] Socket server, auth, rooms
- [ ] Presence (Redis TTL), location presence
- [ ] Notification events, reconnect cursor
- [ ] Realtime tests

## Phase 5 - Ledger and bank
- [ ] Ledger accounts/transactions/entries + service
- [ ] Idempotency, locking, outbox
- [ ] Wallet/bank UI, deposit/withdraw, transfer, history, receipts
- [ ] Reconcile job + alerts
- [ ] Concurrency and invariant tests

## Phase 6 - Jobs and progression
- [ ] Jobs, levels, shifts, claim, daily caps
- [ ] Skills + XP, performance, promotion
- [ ] Starter careers seeded

## Phase 7 - Phone and social
- [ ] Phone UI + app registry
- [ ] Friends, blocks, reports
- [ ] DM chat, notification center
- [ ] Chat filters + rate limits

## Phase 8 - Housing and inventory
- [ ] Rent and bills scheduler
- [ ] Shops, items, purchase, use effects
- [ ] Needs system (lazy decay)
- [ ] Eviction safety

## Phase 9 - Hustle
- [ ] Gigs, applications, escrow, delivery, confirm, rating
- [ ] Disputes + moderator tools
- [ ] Anti-abuse rules

## Phase 10 - Wishes, quests, onboarding
- [ ] Wishes/goals engine
- [ ] Guided onboarding flow
- [ ] Daily reward (bounded)

## Phase 11 - Admin and moderation
- [ ] Admin app + 2FA + RBAC
- [ ] Dashboard, players, content CRUD, reports, announcements
- [ ] Economy dashboard + parameter editor
- [ ] Audit log

## Phase 12 - Polish and security
- [ ] Security review against doc 15
- [ ] Anti-cheat flags + fraud queue
- [ ] Performance budget met
- [ ] Accessibility pass
- [ ] Kill switches and feature flags

## Phase 13 - Closed beta
- [ ] Load tests (k6)
- [ ] Monitoring and alerts
- [ ] Beta players onboarded, feedback loop
- [ ] Economy tuning

## Phase 14 - Public launch
- [ ] See `LAUNCH_CHECKLIST.md`
