# AGENTS.md - Instructions for AI coding agents

Applies to Codex, Kilo Code, Claude Code, Copilot agents and any other automated contributor.
Human owner: Abel (SolusCipher Technologies).

## 1. Before you write any code
1. Read `README.md`, `docs/00_MASTER_GUIDE.md`, and every doc relevant to your task.
2. Inspect the repository. Find existing implementations. Do not duplicate systems.
3. Read `docs/decisions/` (ADRs). Do not contradict an accepted decision. If you think one is wrong, say so and stop.
4. State your plan (files you will touch) before editing.

## 2. Non-negotiable rules
- **Server authoritative.** Never trust client-provided balances, rewards, permissions, prices or locations.
- **Ledger for money.** Every money movement uses the ledger service (double-entry, atomic, idempotent). Never update a balance field directly outside it.
- **Money type.** Integers only (whole naira, `bigint`). Never floats.
- **Validate input** with Zod at every boundary. Validate permissions on every request.
- **Rate-limit** auth, transfers, chat, hustle posts, and any endpoint that grants rewards.
- **Config over hardcoding.** Jobs, items, prices, rewards, tax rates and events live in data or `config_parameters`.
- **Audit log** every admin action and every money adjustment.
- **No gambling mechanics** and no real-money cash-out.
- **Originality.** Never copy code, art, text, names, maps or UI from any other game.

## 3. Architecture rules
- Modular monolith. One deployable server with strict domain modules (auth, player, world, economy, jobs, hustle, inventory, social, messaging, notifications, admin, ...).
- Modules talk through exported service interfaces, not by reaching into each other's tables.
- Government, companies, police and courts are all **organizations** (generic `organizations` model). Do not build separate parallel systems.
- Do not add frameworks or libraries not listed in `README.md` without asking. Prefer what is already installed.
- Realtime channels are scoped (per user, per location, per group). Never broadcast to everyone.

## 4. Quality bar
Every change must include, where applicable:
- DB migration (forward, and a safe rollback note)
- Service logic + API route
- UI (mobile-first, uses the design tokens)
- Authorization + validation + error handling
- Tests (unit + integration; concurrency tests for money)
- Docs and `CHANGELOG.md` updated

Run before declaring done: `pnpm lint`, `pnpm typecheck`, `pnpm test`, `pnpm build`.

## 5. Honest reporting
End every task with:
1. What you implemented
2. What you did NOT implement
3. Files changed
4. Commands you ran and results (pass/fail)
5. Known issues, risks and open questions
Never say "complete" if tests fail, checks were skipped, or a blocker remains.

## 6. Scope discipline
- Do only the requested phase or task. No drive-by refactors.
- If a requirement is ambiguous, list the ambiguity and the safest option. Ask before destructive changes (dropping tables, rewriting history, changing money logic).
- Never commit secrets. Never edit `.env`.

## 7. Delivery format
Deliver changes as normal repository files and commits. Do not bundle deliverables into zip archives.

## 8. Commit style
Conventional commits: `feat(economy): add idempotent transfer`, `fix(auth): ...`, `docs: ...`, `test: ...`, `chore: ...`.
One logical change per commit.
