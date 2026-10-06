# Phase 7 - Phone and Social

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/12_PHONE_SYSTEM.md
- docs/11_SOCIAL_SYSTEM.md
- docs/05_REALTIME_ARCHITECTURE.md
- docs/15_SECURITY_AND_ANTI_CHEAT.md

## Goal
The phone UI shell and social features: friends, DMs, blocks, reports, notification center.

## In scope
- Phone UI with data-driven app registry and unlock rules; dock; badges
- Friends: request/accept/remove, search by username
- Direct messages (realtime), message rate limits, length limits, basic word filter lists (English + Pidgin) from config
- Block (enforced across DM, transfer, visit, profile), mute, report flow
- Notification center (read/unread)
- Privacy settings enforcement (dm_from, show_online)

## Out of scope (do NOT build)
- Group chat, images, push notifications

## Acceptance criteria
- Blocked users cannot message, transfer, or see each other's profile details
- Realtime message delivery with scoped rooms
- Reports stored with message context

## Required tests
- Block enforcement matrix tests
- Message rate-limit tests
- Privacy setting tests
- E2E: add friend -> chat

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
