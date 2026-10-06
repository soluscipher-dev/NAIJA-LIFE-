# Phase 6 - Jobs and Progression

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/08_JOBS_AND_CAREERS.md
- docs/02_GAME_DESIGN.md
- docs/03_GAME_ECONOMY.md
- docs/07_BANKING_AND_LEDGER.md

## Goal
NPC-employer careers with timed shifts, pay via ledger, skills/XP, performance and promotion.

## In scope
- Seed 4-6 starter careers with levels, pay, shift minutes, requirements
- Apply/accept (NPC auto-accept if requirements met), resign with cooldown
- Shift start/claim endpoints; server timer; double-claim prevention; daily cap from config
- Pay via ledger (MINT -> wallet) idempotent by shift id; taxes hook (no-op now)
- Skills + XP with diminishing returns; level thresholds in config
- Performance and promotion request
- UI: Jobs app (listings, current job, shift timer, claim, promotion)

## Out of scope (do NOT build)
- Player-employer jobs, education requirements

## Acceptance criteria
- Cannot claim early, twice, or exceed daily cap
- Pay equals configured value only
- Promotion rules enforced server-side

## Required tests
- Fake-timer tests for shifts
- Concurrency test for double-claim
- Promotion and cap tests
- E2E: apply -> work -> claim -> see balance

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
