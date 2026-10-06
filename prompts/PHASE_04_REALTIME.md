# Phase 4 - Realtime Layer

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/05_REALTIME_ARCHITECTURE.md
- docs/15_SECURITY_AND_ANTI_CHEAT.md (section 9)
- docs/18_SCALABILITY_ARCHITECTURE.md

## Goal
Authenticated WebSocket layer with scoped rooms, presence, and notifications.

## In scope
- Socket.IO on the Fastify server with Redis adapter
- Socket auth via session cookie or short-lived socket token
- Rooms: user:{id}, loc:{id}; join/leave on travel
- Presence with Redis TTL + heartbeat; location presence list (capped sample + counts)
- Notifications table + `notification.created` events; reconnect cursor replay
- Outbox publisher worker (publish after commit)
- Per-socket/user rate limits (token bucket in Redis)

## Out of scope (do NOT build)
- Chat (Phase 7), money events (Phase 5)

## Acceptance criteria
- Events never leak across rooms
- Reconnect replays missed notifications
- Presence flips offline within grace period
- Rate-limit violations handled

## Required tests
- Socket integration tests: auth reject, scoped delivery, reconnect, presence TTL, rate limit
- Multi-instance test with Redis adapter (2 servers)

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
