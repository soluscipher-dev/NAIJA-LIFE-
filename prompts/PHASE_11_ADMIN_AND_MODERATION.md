# Phase 11 - Admin and Moderation

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/16_ADMIN_PLATFORM.md
- docs/15_SECURITY_AND_ANTI_CHEAT.md
- docs/13_DATABASE_ARCHITECTURE.md (admin tables)

## Goal
Separate admin app with RBAC, 2FA, content tools, moderation, and economy dashboard.

## In scope
- Admin auth (separate cookie/domain), mandatory TOTP 2FA, RBAC from roles/permissions tables, seed default roles
- Dashboard, player search/view/suspend/restrict, session revoke
- Content CRUD with draft/publish (jobs, levels, items, shops, locations, events, announcements)
- Moderation queue (reports, gig disputes), actions, notes
- Economy dashboard (supply, faucets/sinks, top movers, flags), parameter editor with before/after and approvals
- Append-only audit log for every write
- Feature flags / kill switches (transfers, hustle, shops, chat, registrations)

## Out of scope (do NOT build)
- Advanced analytics, organization/government tools

## Acceptance criteria
- Every admin write creates an audit record
- RBAC deny-by-default verified
- Admin cannot edit own permissions

## Required tests
- RBAC allow/deny matrix tests, audit tests, 2FA tests, kill-switch tests

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
