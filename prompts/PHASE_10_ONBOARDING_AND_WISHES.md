# Phase 10 - Onboarding, Wishes and Quests

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/02_GAME_DESIGN.md (wishes, tutorial)
- docs/00_MASTER_GUIDE.md (section 9.1)
- docs/12_PHONE_SYSTEM.md (unlock order)

## Goal
Guided first 10 minutes, wishes/goals system, bounded daily reward.

## In scope
- Onboarding state machine and coach marks, app unlock order
- Wishes engine (config-driven goals, progress hooks from existing services, rewards via ledger/XP)
- Daily reward with streak cap, no lockout for returning players
- Help app content (markdown from DB)

## Out of scope (do NOT build)
- Complex quest chains, seasons

## Acceptance criteria
- New player reaches first reward within 5 minutes in a playtest
- Rewards are budgeted and idempotent

## Required tests
- Wish progress tests, daily reward idempotency, onboarding E2E

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
