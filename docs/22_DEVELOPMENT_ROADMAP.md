# 22 - Development Roadmap

Version 1.0 | Realistic for a solo founder working with AI agents. Durations are rough; quality gates matter more than dates.

## Phase overview
| # | Phase | Outcome | Est. |
|---|---|---|---|
| 0 | Blueprint | These docs | done |
| 1 | Foundation | Monorepo, CI, DB, lint/test, design system base | 1-2 wks |
| 2 | Auth and character | Register/login/verify, sessions, character creation | 2 wks |
| 3 | World and map | City data, tap map, travel, location sheets | 2 wks |
| 4 | Realtime | Socket layer, presence, notifications | 2 wks |
| 5 | Ledger and bank | Ledger service, wallet/bank, transfers, history | 3 wks |
| 6 | Jobs and progression | Shifts, pay, skills, promotion | 2-3 wks |
| 7 | Phone and social | Phone UI, messages, friends, notification center | 3 wks |
| 8 | Housing and inventory | Rent, bills, shops, items, needs | 3 wks |
| 9 | Hustle board | Gigs, escrow, ratings, disputes | 2-3 wks |
| 10 | Wishes, quests, onboarding | Guided first-hour experience | 2 wks |
| 11 | Admin and moderation | Admin app, RBAC, content tools, reports | 3-4 wks |
| 12 | Polish and security | Security review, anti-cheat, performance, a11y | 3 wks |
| 13 | Closed beta | Load test, 50-500 players, balance | 4+ wks |
| 14 | Public launch | Production hardening, support, analytics | - |
| 15 | V2 | Businesses, property market, education, investments, ads, seasons | - |
| 16 | V3 | Government, forces, courts, more cities, vehicles | - |
| 17 | V4+ | Military, national budgets, native apps | - |

## Phase gates
Each phase ends only when: acceptance criteria met, tests pass, CI green, docs/changelog updated, a short playtest done (where UX applies), and no known blocker.

## Dependencies
```
1 -> 2 -> 3 -> 4
          \-> 5 -> 6 -> 8 -> 9
2 -> 7 (needs 4, 5)
all MVP phases -> 11 -> 12 -> 13 -> 14
```

## MVP cut line (if time is short)
Must: 1, 2, 3, 4, 5, 6, 7 (messages, friends), 8 (rent, shops), 11 (basic admin), 12, 13.
Can slip to V1: 9 (hustle) if needed, 10 (quests) lite version only.

## Metrics checkpoints
After beta: onboarding completion, D1/D7, economy health, crash-free rate, report volume, average session length. Decide launch only when thresholds in PRD are met.

## V2 / V3 / V4 themes
See Master Guide sections 8, 9.9, 28 and `23_GOVERNMENT_AND_INSTITUTIONS.md`.

Detailed checklists: `plans/ROADMAP_CHECKLIST.md`.
