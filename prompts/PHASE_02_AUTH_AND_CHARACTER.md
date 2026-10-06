# Phase 2 - Authentication and Character

> Paste this whole file into your coding agent (Kilo Code / Codex / Claude Code).

## Role
You are a senior TypeScript engineer building "Naija Life" (working title), a real-time multiplayer Nigerian life-simulation game (mobile-first PWA). You follow `AGENTS.md` strictly.

## Read first (mandatory)
- AGENTS.md
- docs/01_PRODUCT_REQUIREMENTS.md (ACC-*, CHR-*)
- docs/04_PLAYER_SYSTEM.md
- docs/15_SECURITY_AND_ANTI_CHEAT.md (sections 2, 3, 7, 8)
- docs/14_API_ARCHITECTURE.md

## Goal
Players can register, verify email, log in, manage sessions, and create their character.

## In scope
- Register, verify email, login, logout, forgot/reset password
- argon2id hashing, hashed random session tokens in DB, httpOnly secure cookies, CSRF protection
- Session list + revoke, rotation on login
- Login throttling and per-IP/per-account rate limits
- Email sending abstraction (SMTP; console transport in dev)
- Character creation: display name, avatar config (JSON), one per account
- GET /me, GET /players/:username (public fields only)
- Web pages: register, login, verify, forgot/reset, create-character (mobile-first)
- Initial needs_state and skills rows on character creation

## Out of scope (do NOT build)
- Admin login, 2FA, social login, wallet or ledger accounts (Phase 5)

## Acceptance criteria
- All ACC-1..7 and CHR-1,2,5 behave per PRD
- Tokens single-use, hashed, expiring
- Unverified accounts cannot do money actions (flag in /me)
- No enumeration leaks on login/forgot-password responses

## Required tests
- Auth flow integration tests, lockout test, token reuse test, session revoke test
- Zod validation tests for username/password
- E2E: register -> verify -> create character

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
