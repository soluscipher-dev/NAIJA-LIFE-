# ADR-0007: Stack

**Status:** Accepted  **Date:** 2026-10

## Decision
pnpm workspaces; Next.js + React + TypeScript + Tailwind (web and admin); Node.js + Fastify + Socket.IO (server); PostgreSQL with Drizzle ORM and SQL migrations; Redis (pub-sub, rate limits, presence); Zod; Vitest and Playwright; GitHub Actions.

## Rationale
TypeScript end to end, SQL-first control for ledger transactions (FOR UPDATE locking), good AI-agent familiarity.

## Consequences
- Changing a core library requires a new ADR.
