# Agent prompts

One prompt per build phase. Use them in order. Each is self-contained: paste into your coding agent, review the plan it proposes, approve, then review its report.

| File | Phase |
|---|---|
| `PHASE_01_FOUNDATION.md` | Phase 1 - Foundation |
| `PHASE_02_AUTH_AND_CHARACTER.md` | Phase 2 - Authentication and Character |
| `PHASE_03_WORLD_AND_MAP.md` | Phase 3 - World and Map |
| `PHASE_04_REALTIME.md` | Phase 4 - Realtime Layer |
| `PHASE_05_LEDGER_AND_BANK.md` | Phase 5 - Ledger and Bank (CRITICAL) |
| `PHASE_06_JOBS_AND_PROGRESSION.md` | Phase 6 - Jobs and Progression |
| `PHASE_07_PHONE_AND_SOCIAL.md` | Phase 7 - Phone and Social |
| `PHASE_08_HOUSING_AND_INVENTORY.md` | Phase 8 - Housing, Inventory, Shops and Needs |
| `PHASE_09_HUSTLE.md` | Phase 9 - Hustle Board |
| `PHASE_10_ONBOARDING_AND_WISHES.md` | Phase 10 - Onboarding, Wishes and Quests |
| `PHASE_11_ADMIN_AND_MODERATION.md` | Phase 11 - Admin and Moderation |

## How to use
1. Make sure the previous phase is merged and CI is green.
2. Paste the next prompt. Ask the agent for its plan first.
3. Review against `docs/21_AI_CODING_AGENT_RULES.md` (review checklist).
4. Run `pnpm lint && pnpm typecheck && pnpm test && pnpm build` yourself.
5. Playtest, update `CHANGELOG.md`, tick `plans/ROADMAP_CHECKLIST.md`, merge.

Tip: ask Claude (or another reviewer) to review each diff for contradictions with ADRs and for money logic outside the ledger.
