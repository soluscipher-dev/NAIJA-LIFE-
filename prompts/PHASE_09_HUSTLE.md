# Phase 9 - Hustle Board

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/08_JOBS_AND_CAREERS.md (section 7)
- docs/07_BANKING_AND_LEDGER.md (escrow)
- docs/11_SOCIAL_SYSTEM.md (scam protection)
- docs/15_SECURITY_AND_ANTI_CHEAT.md

## Goal
Player-to-player gigs with escrow, ratings, disputes and anti-abuse rules.

## In scope
- Gig lifecycle endpoints and states
- Escrow hold on accept, release on confirm (platform fee -> BURN), refund paths
- Auto-confirm timeout job, cancellation rules
- Ratings + hustle rating aggregate on profile
- Dispute creation and moderator-facing data (admin UI comes in Phase 11)
- Price floors/ceilings per category from config, posting limits, repeated-pair and same-device flags -> fraud_flags
- UI: Hustle app (board, my gigs, working, post a gig)

## Out of scope (do NOT build)
- Admin dispute UI, businesses

## Acceptance criteria
- Escrow money always accounted for in every branch
- Cannot accept own gig; cannot double-accept
- Abuse flags created for suspicious patterns

## Required tests
- Full escrow lifecycle tests, timeout tests, concurrency on accept, fraud flag tests

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
