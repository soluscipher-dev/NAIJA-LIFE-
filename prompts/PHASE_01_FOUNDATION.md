# Phase 1 - Foundation

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- README.md, AGENTS.md
- docs/00_MASTER_GUIDE.md
- docs/13_DATABASE_ARCHITECTURE.md, db/schema.sql
- docs/14_API_ARCHITECTURE.md, docs/17_UI_UX_DESIGN_SYSTEM.md, design/design-tokens.json
- docs/19_TESTING_STRATEGY.md, docs/20_DEPLOYMENT_AND_INFRASTRUCTURE.md
- docs/decisions/ (all ADRs)

## Goal
Create the monorepo foundation so all later phases plug in cleanly.

## In scope
- pnpm workspace: apps/web (Next.js), apps/admin (Next.js), apps/server (Fastify), packages/shared, packages/db
- TypeScript strict, ESLint, Prettier, Husky + lint-staged
- Docker Compose for Postgres 16 and Redis 7
- Drizzle ORM in packages/db; convert db/schema.sql into versioned migrations (keep the zero-sum and immutability triggers)
- Env validation with Zod (read .env.example), structured logger (pino), central error handler, request ids
- Health endpoints (`GET /health`, `GET /ready` with DB + Redis checks)
- Vitest (unit + integration with real Postgres), Playwright skeleton
- GitHub Actions: lint, typecheck, test, build
- Tailwind configured from design/design-tokens.json; base components (Button, Card, BottomSheet, Input, Toast, Skeleton, ProgressBar)
- Scripts: dev, lint, typecheck, test, build, db:migrate, db:seed

## Out of scope (do NOT build)
- Any game features (auth, map, bank, jobs)
- Deployment to production

## Acceptance criteria
- `pnpm install && docker compose up -d && pnpm db:migrate && pnpm dev` works from a clean clone
- All four checks pass: lint, typecheck, test, build
- A test proves ledger_entries rejects a non-zero-sum transaction and rejects UPDATE/DELETE
- CI workflow green
- README commands verified

## Required tests
- DB migration test (apply from scratch)
- Ledger zero-sum + immutability trigger tests
- Health endpoint integration test
- Component smoke tests

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
