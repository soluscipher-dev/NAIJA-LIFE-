# 02 - Game Design Document (GDD)

Version 1.0 | Describes HOW the game plays.

## 1. Fantasy and tone
"Start small, hustle hard, rise." Playful, warm, funny, proudly Nigerian. English with light Pidgin flavor. Never mean-spirited, never graphic.

## 2. Core loops
- **Minutes:** work a shift / hustle -> earn -> eat/rest.
- **Days:** pay bills, level skills, finish wishes, socialize.
- **Weeks+:** upgrade home, invest, start a business, climb ranks, join events.

## 3. Time model
- Server time drives everything (anti-cheat). Needs decay by elapsed server time, not client clock.
- "Game day/week" = real day/week for simplicity. Weekly reset: Monday 00:00 (Africa/Lagos).
- Shifts take real-time minutes (config per job, for example 2-10 minutes) and can be started in the foreground; completion is validated by the server.

## 4. Needs
| Need | Falls by | Restored by |
|---|---|---|
| Hunger | time, activity | food items, restaurants, cooking |
| Energy | work, activity | sleep at home, rest items |
| Fun | time | entertainment, friends, events |
| Social | time | chats, visits, group activity |
| Hygiene | time, activity | shower, salon, items |

Rules: needs are 0-100. Below 20% -> mood penalty and reduced shift rewards (never below 50% of base). Never lock the player out. Decay rates are config; tune so 2-3 check-ins per day is comfortable.

## 5. Mood
Mood = weighted needs + recent feelings (promotion, new home, gift). Shown as a label and emoji. Affects performance gain and some interactions.

## 6. Skills
Cooking, Charisma, Fitness, Coding, Hustle, Music, Dance, Comedy, Photography (launch set). Levels 1-10 at launch. XP from related actions with diminishing returns per day (anti-grind). Skills gate jobs, hustle types, perks and items.

## 7. Careers
Ladder: Intern, Junior, Intermediate, Senior, Lead, Manager, Executive. Each level: pay per shift, hours, required skills. Performance bar fills per completed shift; at 100% plus skill requirement the player may request promotion. See 08_JOBS_AND_CAREERS.

## 8. Hustle
Player-to-player gigs with escrow. See 08 and 07.

## 9. Wishes and goals
Three active short wishes (for example "Make a new friend", "Buy something for the house") with small rewards and a refresh. Lifetime dream (for example "Reach the top of any career") shown as long progress.

## 10. Perks
Passive bonuses (for example hunger decays 25% slower). Earned via achievements or bought with in-game money. Never provide unbounded advantages.

## 11. Housing
Rental ladder: room -> mini flat -> flat -> house -> mansion (later). Weekly rent. Comfort rating improves mood recovery.

## 12. Social play
Friends, private chat, groups, house visits (owner approval, capacity limit), gifts, events.

## 13. Status
Leaderboards, titles, profile badges, luxury items. Status is a core motivation for wealthy players.

## 14. Failure and recovery
No permadeath. If broke: low-pay always-available "survival gigs" exist so no one is hard-locked. Eviction drops the player to a free shared shelter tier, never deletes progress.

## 15. Events
Admin-scheduled: festivals, competitions, career fairs, seasonal sales. Rewards flow through the ledger and are budgeted in the economy plan.

## 16. Tutorial
First 10 minutes per Master Guide 9.1. One new system at a time.

## 17. Balancing rule of thumb
Every faucet must be matched by sinks. Document each new reward in 03_GAME_ECONOMY with its expected weekly volume.
