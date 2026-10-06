# 08 - Jobs, Careers and Hustle

Version 1.0

## 1. Two kinds of work
1. **Career jobs** - configurable ladders, NPC-employer in MVP (paid from MINT), player-employer in V2.
2. **Hustle gigs** - player-to-player tasks with escrow.

## 2. Data model (see db/schema.sql)
`jobs` (career track), `career_levels` (title, pay_per_shift, shift_minutes, required skills, required level), `player_jobs` (current job, level, performance, hired_at), `shifts` (start, end, status, reward).

## 3. Shift flow
1. Player taps "Work" at a valid location. Server checks: employed, location matches, not already on a shift, needs not critical (soft), daily shift cap not reached.
2. Server creates a shift with `ends_at = now + shift_minutes`.
3. Client shows timer. Player may leave the screen; server tracks time.
4. On `claim` after `ends_at`, server validates and posts `job_pay` through the ledger (idempotent by shift id), updates performance, XP, needs.
5. Daily shift cap (config, for example 6/day) and diminishing returns prevent botting.

## 4. Performance and promotion
- Each completed shift adds performance (+ more with high mood and matching skills).
- Missed work days or low needs reduce performance slowly (never to zero instantly).
- At 100% performance AND required skill level -> player can request promotion; instant for NPC employers.
- Promotion grants pay rise, title, mood bonus.
- Demotion/firing only through explicit rules (e.g. 14 days inactive for player-employer jobs), never for NPC jobs.

## 5. Resignation
Cooldown (for example 24h) before taking a new career job. Keep skills and XP.

## 6. Starter careers (MVP)
Retail Assistant, Food Service, Errand/Delivery, Office Admin, Junior Developer, Teaching Assistant. 3-4 levels each. Expand later.

## 7. Hustle gigs
### Lifecycle
`open -> applied -> accepted (escrow held) -> in_progress -> delivered -> confirmed -> paid` or `-> disputed -> resolved`.
- Poster sets title, category, description, fee (within category min/max), deadline.
- Workers apply; poster picks one. Escrow is held at acceptance.
- Worker marks delivered; poster confirms (or auto-confirms after 24h of silence).
- Rating both ways (1-5), builds hustle rating.
- Cancellation rules: before acceptance free; after acceptance small penalty rules to prevent abuse.
### Categories (examples)
Decorate a house, DJ a party, cook for an event, courier, design/graphics, tutoring, errand, photography.
### Anti-abuse
Fee floors/ceilings, posting limits, same-device/IP poster-worker flag, repeated-pair detection, new-account limits, report button on every gig.
### Disputes
Moderator queue shows chat, gig, evidence. Outcomes: pay worker, refund poster, split. Logged in audit.

## 8. Job requirements
Skills, overall level, education (V2), reputation (V2), clean record (government V3).

## 9. Employers in V2
Players with businesses create positions with pay and shifts; payroll comes from the business account. If the account cannot pay, shifts are marked unpaid-owed and the business reputation drops.

## 10. Tests
Shift timing and double-claim prevention, daily caps, promotion rules, escrow branches, dispute resolution, concurrency on claims.
