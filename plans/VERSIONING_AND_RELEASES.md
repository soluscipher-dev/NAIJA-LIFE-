# Versioning and Releases Plan

## App versions (Semantic Versioning)
| Version | Meaning |
|---|---|
| 0.1.x | Foundation (Phase 1-2) |
| 0.2.x | World + realtime (Phase 3-4) |
| 0.3.x | Ledger + bank + jobs (Phase 5-6) |
| 0.4.x | Phone + social + housing (Phase 7-8) |
| 0.5.x | Hustle + onboarding (Phase 9-10) |
| 0.6.x | Admin + moderation (Phase 11) |
| 0.9.x | Closed beta |
| 1.0.0 | Public launch |
| 1.x | V1 improvements (cosmetics, groups, events, seasons) |
| 2.0.0 | V2: businesses, property market, education, investments |
| 3.0.0 | V3: government, forces, more cities |

## Docs versions
Each doc has a `Version` header. Bump when meaning changes. Record in CHANGELOG.

## Release cadence
Beta: weekly. Post-launch: biweekly features, hotfixes as needed. Big economy changes announced in-game 48h ahead.

## Branch and tag rules
`main` protected. Feature branches `feat/phase-N-topic`. Tags `v0.x.y`. Release notes from CHANGELOG.

## Economy change log
Maintain `docs/economy-changes.md` (create at Phase 5) listing every parameter change, date, reason, outcome.
