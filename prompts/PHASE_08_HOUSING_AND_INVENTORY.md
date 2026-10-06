# Phase 8 - Housing, Inventory, Shops and Needs

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/10_PROPERTY_SYSTEM.md
- docs/02_GAME_DESIGN.md (needs)
- docs/03_GAME_ECONOMY.md
- docs/07_BANKING_AND_LEDGER.md

## Goal
Rent a home, pay weekly bills, buy and use items, and the needs system.

## In scope
- Seed properties (room, mini-flat, flat), items (food, hygiene, fun), NPC shops + stock
- Rent flow, weekly rent/bill scheduler (idempotent, jittered), reminders, grace, safe eviction to shelter tier
- Shops: buy via ledger (charge to BURN), inventory add; use item applies effects
- Needs lazy-decay calculation on read; mood label
- UI: Home app, Inventory, Shop sheet, Needs panel

## Out of scope (do NOT build)
- Buying property, decoration, player landlords

## Acceptance criteria
- Scheduler is idempotent and safe to re-run
- Eviction never deletes inventory
- Item prices are read server-side only

## Required tests
- Scheduler idempotency and jitter tests
- Purchase concurrency test (stock/balance)
- Needs decay tests with fake timers

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
