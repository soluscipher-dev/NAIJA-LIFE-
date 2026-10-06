# Phase 3 - World and Map

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/06_WORLD_AND_MAP.md
- docs/01_PRODUCT_REQUIREMENTS.md (WLD-*)
- docs/17_UI_UX_DESIGN_SYSTEM.md
- docs/decisions/ADR-0002-tap-map.md

## Goal
A tap-based city map with districts and locations; players travel between locations.

## In scope
- Seed script: starter city (original names), 5-6 districts, 12-15 locations with actions registry
- GET /world/city, GET /locations/:id, POST /locations/:id/travel (server-validated, timed travel)
- Map UI: pannable map with hotspots from map_x/map_y + list-view fallback
- Location bottom sheet showing actions (placeholders for shop/work/etc.)
- player_locations updates; travel cooldown/timer enforced server-side

## Out of scope (do NOT build)
- Realtime presence (Phase 4), shops, jobs

## Acceptance criteria
- Map loads < 300 KB compressed, usable on 360px width
- Travel cannot be spoofed (server timers)
- Locations editable via seed/config, not hardcoded in UI

## Required tests
- Travel validation tests (closed location, mid-activity, invalid id)
- Seed idempotency test
- E2E: open map -> travel -> see location sheet

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
