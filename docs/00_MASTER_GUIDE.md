# NAIJA LIFE (working title) — MASTER GUIDE

**Document type:** Master Project Guide (vision, scope, features A–Z, architecture, roadmap)
**Version:** 1.2.0 (adds Government & Institutions layer; supersedes 1.1.0)
**Date:** October 2026
**Owner:** Abel — SolusCipher Technologies
**Status:** Living document. Update it whenever a decision changes.

> **Working title.** "Naija Life" is a placeholder. Before committing, check trademark, domain and app-store availability. Do not use "Lagos Life" or any name/branding confusingly similar to it.

---

## TABLE OF CONTENTS

1. About the project
2. Vision, mission and pillars
3. Product principles
4. Target players
5. Scope: what is in, what is out
6. Release stages
7. Core game loop
8. Features A–Z
9. Core systems in detail
10. The Phone (main UI)
11. World and map
12. Economy design
13. Admin platform
14. Security and anti-cheat
15. Technical architecture
16. Data model overview
17. Legal, compliance and safety
18. Monetization
19. Analytics
20. Testing strategy
21. Development roadmap
22. Risks and mitigations
23. Open decisions
24. Originality and IP rules
25. AI coding agent rules
26. Definition of done
27. Companion documents
28. Government, forces and institutions

---

## 1. ABOUT THE PROJECT

**What it is.** A persistent, real-time, multiplayer Nigerian life-simulation game. Every player has a character who lives in a shared virtual Nigeria: working, hustling, studying, earning virtual money, paying bills, renting or buying homes, owning things, making friends, and building status. The actions of real players collectively shape the world and its economy.

**Platform.** Mobile-first web app / PWA (installable, no app-store needed at launch). Android and iOS wrappers come later.

**Why it exists.**
- Nigerian life-sim games are trending, which proves the demand.
- Existing games are dense, economically inflated, and light on player-driven systems.
- There is room for a product with a cleaner first experience, a healthier economy, deeper progression and genuine player-to-player economies (jobs, businesses, property).

**What it is not.**
- Not a copy of any existing game. No copied code, art, text, maps, branding or UI assets.
- Not a gambling product. No real-money betting mechanics.
- Not a real-money earning platform. In-game money has no cash-out value.

---

## 2. VISION, MISSION AND PILLARS

**Vision.** A persistent Nigerian virtual life where every player has a life, money, career, home, social identity and opportunities, and where real players collectively create the world.

**Mission.** Make a life-sim that is fun in the first 5 minutes, deep after 5 months, fair to free players, and safe for its community.

**Design pillars**

| Pillar | Meaning |
|---|---|
| **Always a next step** | A player always has a clear, rewarding thing to do. |
| **Culture-rich and original** | Nigerian humor, food, music, language (English and Pidgin), hustle culture, done with respect and originality. |
| **Player-driven economy** | Players hire, pay, sell to and compete with each other. |
| **Healthy economy** | Money has meaning because there are real sinks, not just endless printing. |
| **Social first** | Friends, groups, visits and shared moments drive retention. |
| **Safe and fair** | Moderation, anti-cheat and privacy are core, not later additions. |

---

## 3. PRODUCT PRINCIPLES

1. **Server authoritative.** The client never decides money, inventory, rewards, permissions or movement validity.
2. **Real-time where it matters.** Chat, presence, transfers and location events feel instant.
3. **Mobile first.** Designed for mid-range Android phones on unstable networks.
4. **Configurable.** Jobs, items, prices, locations, rewards and events live in data and admin tools, not hardcoded.
5. **Auditable economy.** Every money movement has a ledger record.
6. **Progressive complexity.** Reveal features gradually. Day one must not feel like a spreadsheet.
7. **Security by design.** Rate limits, validation, audit logs and moderation from the start.
8. **Modular monolith first.** Strong domain boundaries, one deployable app, split only when load demands it.
9. **Production quality.** Tests, logs, error handling and docs for every system.

---

## 4. TARGET PLAYERS

**Primary:** Nigerian players (mostly on phones) who enjoy social games, role-play, simulation, hustle and money games, and status progression.

**Secondary:** Diaspora and international players interested in Nigerian culture.

**Player types to design for**
- **The Hustler:** loves earning, grinding, and optimizing.
- **The Socialite:** loves chatting, visiting, parties and status.
- **The Builder:** loves homes, decorating, businesses and collecting.
- **The Role-player:** loves stories, careers and character identity.
- **The Competitor:** loves leaderboards and ranks.

---

## 5. SCOPE: WHAT IS IN, WHAT IS OUT

### In scope (the full vision, delivered in stages)
Accounts, characters, one city then more, tap-based map, phone UI, needs, skills, careers, hustle board, bank and ledger, taxes and bills, housing, inventory, shops, friends and messaging, groups, leaderboards, events, businesses, property and land, vehicles, education, admin platform, moderation, analytics, notifications, seasonal content.

### Out of scope for the first release (do not build yet)
- Every Nigerian city
- Free-roaming 3D open world with physics
- Full vehicle simulation and driving
- Advanced real estate and construction
- Politics and elections
- Advanced AI NPC conversations
- Full business accounting software
- Large investment markets
- Hundreds of careers and thousands of items
- Native Android/iOS apps
- Complex monetization

### Permanently out of scope
- Real-money gambling and betting
- Real-money cash-out of in-game currency
- Sexual or graphically violent content
- Copying any other game's protected material

---

## 6. RELEASE STAGES

| Stage | Goal | Players |
|---|---|---|
| **Alpha** | Core loop works end to end, internal only | You and a few testers |
| **MVP / Closed beta** | One city, core systems, real people playing | 50–500 |
| **V1 / Public launch** | Polish, moderation, anti-cheat, stable economy | 500–10,000 |
| **V2** | Businesses, property market, education, more careers | 10,000–100,000 |
| **V3+** | More cities, vehicles, organizations, mobile apps | 100,000+ |

Feature tags used below: **[MVP]**, **[V1]**, **[V2]**, **[V3+]**, **[Idea]** (not yet committed).

---

## 7. CORE GAME LOOP

```
CREATE ACCOUNT -> CREATE CHARACTER -> ENTER CITY -> EXPLORE
-> WORK / HUSTLE / STUDY -> EARN MONEY -> PAY BILLS & TAXES
-> SAVE / SPEND / INVEST -> IMPROVE SKILLS & NEEDS
-> RENT / BUY HOME -> BUY ITEMS / VEHICLES -> MAKE FRIENDS
-> JOIN OR START BUSINESSES -> BUILD WEALTH & STATUS
-> TRAVEL / EXPAND -> CONTINUE LIVING IN THE PERSISTENT WORLD
```

**Short loop (minutes):** do a shift or hustle, earn, spend on needs.
**Medium loop (days):** progress career, pay weekly bills, grow skills, complete wishes.
**Long loop (weeks and months):** buy property, start a business, climb the leaderboard, join seasonal events.

---

## 8. FEATURES A–Z

### A
- **Account and authentication [MVP]:** register, login, logout, email verification, password recovery, session management, device list, optional 2FA later.
- **Achievements [V1]:** milestone badges (first job, first home, first ₦1m) with cosmetic or small rewards.
- **Admin platform [MVP basic, V1 full]:** see section 13.
- **Announcements [MVP]:** admin messages and in-game news banners.
- **Avatar [MVP]:** customizable character (skin tone, hair, face, outfits, accessories). Inclusive options, no body-shaming design.

### B
- **Bank [MVP]:** wallet vs bank balance, account number, deposits, withdrawals, transfers, history, receipts.
- **Bills and weekly expenses [MVP]:** rent, staff wages, utilities, due dates and reminders.
- **Billboards and in-world advertising [V2]:** player and business ads on map billboards, paid in in-game money (a money sink and a cosmetic space). Strict content rules and moderation.
- **Bonds and savings [V1]:** safe in-game savings accounts and fixed-term bonds, with modest interest tuned by the economy team.
- **Business system [V2]:** see section 9.9.

### C
- **Careers [MVP foundation, V1 full]:** see section 9.4.
- **Chat [MVP]:** private messages, then group chat. Report, mute and block built in.
- **Contacts [MVP]:** friends list with online status, quick actions (message, send money, invite over, visit).
- **Cooking [V1]:** a skill and a gameplay loop (cook meals for hunger and fun, sell food).
- **Cosmetics [V1]:** clothes, hair, accessories, house skins.
- **Cars [V2]:** see Vehicles.

### D
- **Daily rewards and streaks [V1]:** small, fair login rewards that never lock out returning players.
- **Dashboard (player) [MVP]:** home screen with needs, money, current job and the next suggested action.
- **Death/failure handling [Idea]:** no permadeath. Low needs only reduce mood and performance.

### E
- **Education [V2]:** primary, secondary, university or polytechnic, professional certificates. Unlocks jobs and promotions.
- **Emotes and poses [V1]:** quick expressions during interactions.
- **Events [V1]:** admin-created festivals, competitions, city-wide challenges and limited-time rewards.
- **Energy and fatigue [MVP]:** part of the needs system.

### F
- **Family [V2]:** relatives and family events as optional storylines and small bonuses.
- **Fashion [V1]:** boutique, clothing items, fashion businesses.
- **Friends [MVP]:** add, accept, remove, block. Friend-only features (house access, gifts).
- **Fraud detection [V1]:** automated alerts on abnormal transfers (see section 14).

### G
- **Gifts [V1]:** send items or money with a note. Logged and rate limited.
- **Goals and wishes [V1]:** short, repeatable personal goals with a small reward.
- **Groups and communities [V1]:** player-created groups with chat, roles and shared events.
- **Government and city services [V2]:** non-political, light-touch city offices (ID, permits for businesses, taxes). Keep it simple.

### H
- **Health [V1]:** health and hygiene needs, clinics and pharmacies. Light, never grim.
- **Help and guide [MVP]:** searchable in-game help and a short interactive tutorial.
- **Home [MVP]:** rental room, flat or house. Home screen shows comfort and decorations.
- **House visits and invites [V1]:** friends can visit a house with the owner's permission, with a capacity limit.
- **Hustle board [MVP or early V1]:** player-to-player jobs with escrow (section 9.5).

### I
- **Inventory [MVP]:** items, quantities, stacking, use, equip, gift, sell.
- **Investments [V1/V2]:** in-game land plots and fictional investments with weekly returns. Always fictional, never real-money.
- **Invite and referral [V1]:** invite friends by link for cosmetic or small rewards. Anti-abuse rules apply.

### J
- **Jobs [MVP]:** listings, requirements, shifts, pay, performance, promotion, resignation.
- **Job applications from players [V2]:** players with businesses can hire other players.

### K
- **Karma and reputation [V1]:** hustle rating, business rating and community standing that influence trust and opportunities.
- **Knowledge base [MVP]:** the in-game Help content library.

### L
- **Land and plots [V2]:** buy, hold and sell land with growth tied to the economy.
- **Leaderboards [V1]:** richest, most skilled, best hustlers, top businesses. Anti-cheat protected and with reset seasons.
- **Localization [V1]:** English and Nigerian Pidgin first. Possibly Yoruba, Igbo and Hausa later.

### M
- **Map [MVP]:** tap-based city map with districts and locations (section 11).
- **Market and shops [MVP]:** buy food, clothes, home items and basics.
- **Messages [MVP]:** see Chat.
- **Moderation [MVP basic, V1 full]:** reports, queue, mutes, suspensions, audit logs.
- **Mood [MVP]:** overall status (for example Very Happy) derived from needs and recent events.

### N
- **Needs system [MVP]:** hunger, energy, fun, social, hygiene, bladder (or a simplified set). Decay over time, restored by actions.
- **News feed ("Gist") [V2]:** in-world news about events, richest players, new businesses.
- **Notifications [MVP]:** in-game, then push and email.
- **NPCs [V1]:** shopkeepers, bank staff and background characters so the world is never empty.

### O
- **Onboarding [MVP]:** guided first 10 minutes (section 9.1).
- **Offline progress [V1]:** capped passive earnings (for example investment payouts) while away, never uncapped.

### P
- **Perks [V1]:** purchasable or earned passive bonuses (for example slower hunger decay).
- **Phone [MVP]:** the central UI (section 10).
- **Profile [MVP]:** public card with avatar, username, title, level, achievements.
- **Property [MVP rent, V2 buy/sell]:** section 9.7.
- **Push notifications [V1]:** via web push on supported devices.

### Q
- **Quests and story missions [V1]:** guided tasks that teach systems and give rewards.
- **Quality assurance tools [MVP]:** test accounts, seeded data, admin simulation tools for QA.

### R
- **Ranks and titles [V1]:** earned titles shown on the profile.
- **Relationships [V2]:** friendships first, dating and family as optional, age-appropriate systems.
- **Rent [MVP]:** weekly rent, grace period, eviction rules that are fair and never destructive.
- **Reports and blocks [MVP]:** every player can report messages, profiles and hustle posts.

### S
- **Safety center [V1]:** privacy controls, blocklist, parental information, report history.
- **Savings [V1]:** see Bonds and savings.
- **Seasons [V2]:** seasonal leaderboards, themes and rewards.
- **Settings [MVP]:** account, privacy, notifications, language, sound, data.
- **Skills [MVP]:** cooking, charisma, fitness, coding, hustle, music, dance, comedy, photography and more, each with levels and benefits.
- **Staff and household help [V2]:** hire in-game staff who add weekly costs and benefits.

### T
- **Taxes [V1]:** simple weekly income tax with free thresholds, taken automatically. Acts as an economy sink.
- **Transfers [MVP]:** player to player, with limits, fees where needed and receipts.
- **Travel [V2/V3]:** move between cities with travel time or cost.
- **Tutorial [MVP]:** see Onboarding.

### U
- **Utilities and household costs [V2]:** power, water, internet, generator fuel as flavorful, optional sinks.
- **UI design system [MVP]:** one reusable component library, original look and feel.

### V
- **Vehicles [V3]:** ownership, fuel/running cost, status. Start as status items and travel perks, not driving simulation.
- **Verification [MVP]:** email verification. Phone verification later if abuse requires it.
- **Visit system [V1]:** visit friends' homes and public spots.

### W
- **Wallet [MVP]:** cash on hand for everyday spending.
- **Weather and time of day [V2]:** cosmetic and light gameplay effects.
- **Wishes:** see Goals.

### X
- **XP and levels [MVP]:** per skill and overall. Drives unlocks.

### Y
- **Yearly and seasonal content [V2]:** holidays, festive seasons, anniversary events.

### Z
- **Zones and districts [MVP]:** the city is divided into areas, each with a theme (commercial, residential, market, entertainment, government, waterfront).

---

## 9. CORE SYSTEMS IN DETAIL

### 9.1 Onboarding (first 10 minutes)
1. Register and verify email.
2. Create character (name, avatar, username).
3. Receive starter cash and a starter room.
4. Guided tap on the map to the first location.
5. Do the first simple task (first shift or hustle).
6. Receive the first reward and see the ledger entry.
7. Discover the phone: bank, jobs, messages.
8. Add the first friend or meet a friendly NPC.
9. Get three starter wishes to chase.

**Rule:** never show more than one new system at a time in the first session.

### 9.2 Needs and mood
- Needs decay on a timer and are restored by actions (eat, sleep, socialize, wash).
- Mood summarizes the needs and recent events (for example promotion, a good home, a gift).
- Low needs reduce work performance and rewards but never block the whole game.
- Perks and skills (for example cooking) can improve needs efficiency.
- Needs decay on server time, tuned so a casual player can check in 2–3 times a day.

### 9.3 Skills
Examples: Cooking, Charisma, Fitness, Coding, Hustle, Music, Dance, Comedy, Photography.
- Gained through activities and practice.
- Levels 1–10 at launch (expandable).
- Skills unlock jobs, hustle types, items and perks.

### 9.4 Jobs and careers
- Configurable job table: title, field, level, requirements, shift hours, pay per shift, performance rules.
- Career ladder: Intern, Junior, Intermediate, Senior, Lead, Manager, Executive.
- Performance meter fills with completed shifts and skill checks. At 100% and the required skill, the player can request a promotion.
- Players can resign and switch careers with a cooldown.
- Starter careers (MVP): retail, food service, delivery/errand, office admin, tech, teaching.
- Later: medicine, nursing, law, banking, accounting, engineering, media, fashion, construction, transport, logistics, agriculture, entertainment, skilled trades.

### 9.5 Hustle board (player-to-player work)
- Players post jobs (decorate a house, DJ a party, cook, courier, design, errand).
- Another player applies, the poster accepts, and the fee goes into **escrow** at acceptance.
- Both confirm completion, then escrow is released. Disputes go to a simple moderation flow.
- Ratings build a **Hustle rating**.
- Anti-abuse: price caps, posting limits, duplicate detection, and wash-trading detection.

### 9.6 Banking and ledger (critical)
- Two balances: **wallet** (cash) and **bank**, plus savings and bonds.
- **Every** money movement is a double-entry ledger record. No mutable balance without a matching transaction.
- Ledger fields: id, reference, idempotency key, sender, receiver, amount, fee, type, status, created at, metadata.
- Atomic database transactions, idempotent endpoints, row locking, no negative balances.
- Transaction types: job pay, hustle pay, transfer, purchase, tax, rent, bill, savings interest, bond payout, refund, admin adjustment, event reward.
- Receipts and itemized "last purchase" views.

### 9.7 Property and housing
- **MVP:** rent a room or flat weekly. Pay or get evicted to a cheaper default.
- **V2:** buy homes, upgrade, decorate, rent out to other players, own land and commercial property.
- Each home has capacity, comfort rating, style slots and visit permissions.

### 9.8 Inventory and items
- Item categories: food, clothing, accessories, household, tools, supplies, collectibles, cosmetics.
- Item fields: id, name, category, description, value, stackable, ownership rules, rarity, durability, effects.
- Items are config-driven so new content ships without code changes.

### 9.9 Businesses (major differentiator, V2)
- Types: restaurant, retail shop, fashion brand, tech company, logistics, farm, media, entertainment, transport.
- Features: profile, owner, employees, roles, payroll, stock, revenue, expenses, profit/loss, business account, reputation, location, products.
- Player A's business can employ Player B. Payroll runs automatically from the business account.
- Business tax, licensing costs and upkeep as healthy sinks.
- Start with 3–4 simple business types and expand.

### 9.10 Social systems
- Friends, messages, groups, house visits, gifts, public profiles.
- Safety: block, mute, report, privacy controls, rate limits, link and spam filters.
- Chat filters for severe abuse. Human moderation for edge cases.

### 9.11 Events
- Admin-configurable: start/end, location, eligibility, rewards, announcements, participation tracking.
- Examples: city festival, talent show, career fair, treasure hunt, seasonal sale.

### 9.12 Leaderboards
- Richest, top hustlers, top businesses, skill leaders.
- Display rounded values and anonymize or opt-out via privacy settings.
- Seasonal resets plus an all-time hall of fame.
- Anti-cheat: exclude flagged accounts and review suspicious jumps (no artificial wealth caps).

---

## 10. THE PHONE (MAIN UI)

The phone is the main menu and keeps complexity inside simple app icons.

| Group | Apps |
|---|---|
| **Finance** | Bank, Wallet, Savings, Bonds, Invest |
| **Life** | Jobs, Hustle, Education, Health, Home, Needs |
| **Social** | Messages, Contacts, Groups, Family |
| **Business** | My Businesses, Staff, Stock, Accounts |
| **City** | Map, Travel, Market, News, Events |
| **Status** | Leaderboards, Achievements, Profile |
| **System** | Notifications, Settings, Help and Guide, Safety |

**UX rules**
- Max one action layer deep for core tasks.
- Large tap targets, readable on small screens.
- Show a "Next best action" suggestion on the home screen.
- Unlock apps gradually during onboarding.

**Bottom navigation (to validate in testing):** Home, Map, Market, Phone, Profile.

---

## 11. WORLD AND MAP

**Structure**
```
Country -> City -> District -> Location -> Interactable
```

**Approach for MVP:** a **tap-based map**, not free-roaming movement. Players tap a location to travel there. This is far cheaper to build, runs well on phones, and still supports presence ("who is here") and social interaction.

**Starter city:** one Nigerian city with 5–6 districts and about 10–15 locations.

**Example districts**
- Business district (offices, bank)
- Market district (shops, food)
- Residential districts (rental housing)
- Entertainment district (cinema, lounge)
- Education area (library, school)
- Waterfront/leisure
- Government and services

**Example locations:** bank, supermarket, market, restaurant, cinema, library, clinic, gym, office tower, barber/salon, boutique, estate agent, transport hub.

**Presence:** show who is at a location, with caps for performance. Entering a location triggers its menu (shop, job, social).

**Later:** additional cities, travel costs, city-specific economies and culture.

**Art direction:** original isometric or low-poly style with a distinct color system. Do not imitate any existing game's map or characters.

---

## 12. ECONOMY DESIGN

### 12.1 Goals
- Money always feels worth earning.
- **Wealth inequality is a feature.** Some players will become far richer than others, and that is part of the fun. There is no cap on how rich a player can get.
- No runaway inflation (handled through sinks that rich players want to spend on, not through limits on wealth).
- New and old players can both progress.
- No real-money advantage that breaks fairness.

### 12.2 Faucets (money in)
Job pay, hustle pay (from other players, not created), event rewards, daily rewards, interest and bond payouts, investment returns.

### 12.3 Sinks (money out)
Rent, utilities, weekly bills, income tax, business tax, licensing fees, shop purchases, cosmetics, ads and billboards, fees on large transfers, upkeep and repair, luxury items, transfer fees above thresholds.

### 12.4 Controls
- Admin-tunable parameters: pay scales, prices, tax brackets, interest rates, fee rates, caps.
- Weekly economy report: total money supply, velocity, top earners, sinks vs faucets.
- Transfer and gift limits and cooldowns apply to **new accounts only** (anti-funneling). Established players can move large sums, with every transfer logged.
- **No wealth caps.** Players can accumulate without limit.
- Tax is light and simple (free threshold, modest rates), meant as a sink and not a penalty on success. Rates are admin-tunable.
- **Luxury and status sinks for the wealthy:** mansions, estates, supercars, private jets, yachts, exclusive clubs, big billboards, business empires, charity and city-project donations with public recognition, and prestige cosmetics. Rich players should *want* to spend, so money keeps circulating.
- Leaderboards show true rankings. Suspicious jumps are flagged for review, not capped.

### 12.5 Anti-inflation lessons from other games
- Do not allow unlimited large gifts between fresh accounts.
- Do not let jobs pay out unbounded amounts.
- Watch for duplicate-account funneling and wash trading.
- Rebalance with sinks before adding more faucets.

### 12.6 Currency
Virtual Naira (₦) as display currency. A separate **premium currency** (if ever introduced) must be cosmetic-only and not convert to or from the main currency.

---

## 13. ADMIN PLATFORM

A **separate** app from the player experience, with its own authentication and permissions.

**Modules**
- **Dashboard:** online players, registrations, sessions, economy metrics, health, recent activity.
- **Players:** search, view, suspend, restrict, review activity and reports.
- **Economy:** transaction monitor, parameters, fraud alerts, money-supply charts.
- **Content:** jobs, items, locations, shops, businesses categories, events, rewards, announcements.
- **Moderation:** report queue, mutes, suspensions, appeals, audit logs.
- **Support:** ticket view, player lookup, safe adjustment tools with mandatory reason.
- **Analytics:** retention, DAU/MAU, funnel completion, economy volume.

**RBAC (configurable roles and permissions)**
`SUPER_ADMIN`, `GAME_ADMIN`, `MODERATOR`, `CONTENT_ADMIN`, `ECONOMY_ADMIN`, `SUPPORT_AGENT`, `ANALYST` — plus the ability to create new roles from a permission list.

**Rules:** every admin action is audited. Money adjustments require a reason and, for large amounts, a second approver.

---

## 14. SECURITY AND ANTI-CHEAT

**Principles:** never trust the client.

**Checklist**
- Server-side validation of every financial action, reward, purchase and permission.
- Idempotency keys on transfers and purchases.
- Database transactions with locking to prevent double-spend and race conditions.
- Rate limiting per user and IP on login, transfers, chat, hustle posts.
- Session protection (secure cookies, rotation, device list, revoke).
- WebSocket authentication, per-connection rate limits, scoped channels.
- Input validation and output encoding to prevent injection and XSS.
- Admin routes isolated, protected and audited.
- Secrets in environment config, never in the repo.
- Anomaly detection: large transfers between new accounts, repeated transfers in a loop, unusual job-pay frequency, impossible action timing.
- Multi-account detection signals (shared device/IP patterns, funneling).
- Automated action throttling and manual review for flagged accounts.
- Full audit logs for money, moderation and admin actions.
- Regular backups, restore tests and an incident response plan.

---

## 15. TECHNICAL ARCHITECTURE

### 15.1 Recommended stack
| Layer | Choice |
|---|---|
| Frontend | Next.js, React, TypeScript, Tailwind CSS, PWA |
| Rendering (map/UI) | DOM/SVG/Canvas for tap map, 2D engine later if needed |
| Backend | Node.js, TypeScript, REST (or tRPC) plus WebSockets |
| Database | PostgreSQL |
| Cache / pub-sub | Redis-compatible store |
| Queue/jobs | Background worker (for payroll, interest, decay, events) |
| Storage | Object storage + CDN for avatars and assets |
| Auth | Secure sessions, email verification, password hashing (argon2/bcrypt) |
| Observability | Structured logs, error tracking, metrics, uptime alerts |
| CI/CD | Automated lint, type-check, test and deploy |

### 15.2 Architecture style
**Modular monolith.** One deployable app, with strict domain modules:

Auth, Player, Character, World, Realtime, Economy, Banking, Jobs, Hustle, Education, Property, Inventory, Business, Social, Messaging, Notifications, Events, Moderation, Admin, Analytics.

Each module has its own folder, services, validation and tests. Cross-module access goes through defined interfaces, so modules can be split into services later if load requires it.

### 15.3 Real-time layer
Example events: `player.connected`, `player.disconnected`, `player.entered_location`, `player.left_location`, `message.received`, `money.transfer_completed`, `notification.created`, `event.started`, `event.ended`.

Rules: scope channels (per location, per user, per group), never broadcast everything to everyone, and keep payloads small.

### 15.4 Scaling path
100 -> 1,000 -> 10,000 -> 100,000 -> 1,000,000+
Add indexing, pooling, caching, horizontal app scaling, Redis pub-sub, queue workers, read replicas, partitioning of ledger and messages, and CDN, each only when real load justifies it.

### 15.5 Performance goals
Fast first load, light bundles, lazy-loaded assets, compressed images, efficient queries, minimal polling, and graceful offline/poor-network behavior.

---

## 16. DATA MODEL OVERVIEW

Core tables (final schema decided in the database design document):

`users, sessions, characters, cities, districts, locations, player_locations, wallets, bank_accounts, ledger_entries, financial_transactions, jobs, career_levels, player_jobs, shifts, skills, player_skills, needs_state, education, properties, property_ownership, leases, vehicles, items, inventory, shops, shop_stock, businesses, business_employees, business_transactions, hustle_jobs, hustle_applications, escrows, friendships, groups, group_members, messages, notifications, events, event_participants, achievements, player_achievements, leaderboards, reports, blocks, moderation_actions, audit_logs, config_parameters, roles, permissions`

**Data rules:** UUID or ULID identifiers, timestamps in UTC, soft deletes where audit matters, money stored as integers (minor units) never floats, and migrations tracked in version control.

---

## 17. LEGAL, COMPLIANCE AND SAFETY

- **Data protection:** comply with the Nigeria Data Protection Act (NDPA) and similar rules for other regions. Publish a privacy policy and terms of service. Collect only what is needed.
- **Age policy:** decide the minimum age (for example 13+ with parental guidance, or 16+/18+). Apply age-appropriate content and chat controls. Do not store sensitive data about minors beyond what the law requires.
- **No gambling:** no real-money betting, loot boxes with real-money purchase, or cash-out of virtual currency. Fictional in-game "luck" events, if any, must not be purchasable with real money.
- **Content rules:** no sexual content, hate, harassment, or glorification of serious crime. Keep tone playful and culturally respectful.
- **Payments (if any):** use licensed payment providers. Do not handle raw card data.
- **User-generated content:** moderation, reporting and fast takedown.
- **IP:** all assets original or properly licensed (section 24).
- **Business registration and tax:** register the company, understand how revenue is taxed, and keep records.

> This guide is not legal advice. Consult a Nigerian lawyer before launch.

---

## 18. MONETIZATION

**Principles:** fair, optional, never required for core progression.

**Options (staged)**
- Cosmetics (clothes, hair, house skins, avatar frames) [V1]
- Premium membership with convenience and cosmetic perks, not power [V2]
- Seasonal passes with cosmetic rewards [V2]
- In-world ads and billboards paid for with in-game money; optional sponsored brand partnerships [V2]
- Optional rewarded ads (carefully designed, off by default if players dislike them) [Idea]

**Avoid:** pay-to-win currency packs, gambling mechanics, selling in-game money for real money in a way that breaks the economy.

---

## 19. ANALYTICS

Track product health without over-collecting personal data.

- DAU, WAU, MAU, retention (D1, D7, D30)
- New-player funnel (register -> character -> first job -> first reward -> day-2 return)
- Session length and frequency
- Economy: money supply, faucet and sink totals, average wealth, Gini coefficient
- Job and hustle participation
- Social activity (messages, friends added)
- Errors, crashes, latency, WebSocket health

---

## 20. TESTING STRATEGY

- **Unit tests:** economy math, ledger, permissions, inventory, promotions, rewards, needs decay.
- **Integration tests:** auth, banking, transfers, jobs, hustle escrow, purchases.
- **Concurrency tests:** double-spend, simultaneous transfers, race conditions.
- **Real-time tests:** connect/disconnect, presence, messaging, reconnect.
- **Security tests:** auth bypass, rate limits, injection, permission escalation.
- **Load tests:** before every major scale step.
- **Playtests:** observe real players through onboarding every phase.

---

## 21. DEVELOPMENT ROADMAP

| Phase | Name | Key deliverables |
|---|---|---|
| 0 | Blueprint | This guide, game rules, feature inventory, architecture, security plan |
| 1 | Foundation | Repo, TypeScript, database, config, logging, error handling, CI, design system |
| 2 | Accounts and character | Registration, login, sessions, profile, character creation |
| 3 | World and map | City, districts, locations, tap travel, location menus |
| 4 | Real-time | WebSockets, presence, nearby players, events |
| 5 | Economy and bank | Wallet, bank, ledger, transfers, transaction history, receipts |
| 6 | Jobs and progression | Jobs, shifts, pay, skills, performance, promotions |
| 7 | Phone and social | Phone UI, messages, contacts, friends, notifications |
| 8 | Housing and inventory | Rent, bills, items, shops, purchases |
| 9 | Hustle board | Player jobs, escrow, ratings |
| 10 | Needs, wishes, quests | Needs, mood, wishes, onboarding quests |
| 11 | Admin and moderation | Dashboard, players, economy tools, content tools, reports |
| 12 | Polish and security | UX pass, performance, security review, anti-cheat, accessibility |
| 13 | Closed beta | Load tests, real players, feedback, balancing |
| 14 | Public launch | Production deploy, monitoring, support, analytics |
| 15 | V2 | Businesses, land and property market, education, billboards, seasons |
| 16 | V3+ | More cities, vehicles, organizations, mobile apps |

**Realistic note for a solo builder:** Phases 1–8 plus a thin Phase 9 and Phase 11 are the true MVP. Cut or postpone anything else if time runs short.

---

## 22. RISKS AND MITIGATIONS

| Risk | Mitigation |
|---|---|
| Scope too large for one builder | Stage releases strictly, ship the tap-map MVP, cut features aggressively |
| Empty world / cold start | NPCs, bots at low population, community-seeded beta, invite system |
| Economy inflation | Sinks first, caps, tuning dashboard, weekly reviews |
| Cheating and duplication exploits | Server authority, ledger, idempotency, locking, anomaly alerts |
| Chat abuse and harassment | Reporting, blocks, filters, moderators, rate limits |
| Legal and age compliance | Early legal review, clear age policy, privacy by design |
| Art and asset cost | Original simple style, modular asset system, license where useful |
| Hosting costs at scale | Efficient design, cache, monitor, scale on real load |
| Copying accusations | Strict originality rules (section 24), documented original design decisions |
| AI-agent drift or contradictions | Strong docs, scoped phases, review checkpoints (section 25) |

---

## 23. OPEN DECISIONS (to resolve and record)

1. Final game name, logo and domain.
2. 2D vs low-poly 3D art direction and budget.
3. Minimum player age and age-gate method.
4. Starting city (Lagos, or another) and its district design.
5. Launch languages (English, Pidgin, others).
6. Premium currency: yes or no, and exact scope.
7. Hosting provider and region.
8. Push notification approach (web push vs wrapper app).
9. Phone number verification: yes or no.
10. Moderation staffing plan for beta.
11. Whether to ship ads in v1.
12. Whether Hustle board ships in MVP or V1.

*Record each decision here with date and reason.*

---

## 24. ORIGINALITY AND IP RULES

**Allowed:** the general genre, common life-sim ideas (jobs, homes, money, friends), and tropes shared across many games.

**Not allowed:** copying source code, art, characters, logos, branding, exact UI artwork, maps, copyrighted text, or scraping protected game data. Never present this product as another game.

**Practices**
- Keep an **originality log**: for every major system, note how your design differs.
- Use original names for locations, apps and systems.
- Commission, create or license all art, sound and fonts. Keep license records.
- Do not use real brands, celebrities or real people's likenesses without permission.
- Avoid betting-brand look-alikes entirely.

---

## 25. AI CODING AGENT RULES

Any AI agent (for example Kilo Code or Codex) working on this project must follow these.

1. **Read first.** Read this guide and relevant docs. Inspect the repo. Do not duplicate existing systems.
2. **Do not invent requirements.** Flag ambiguities and ask before destructive changes.
3. **Preserve architecture.** No random frameworks, duplicate libraries, or hardcoded game rules where config is required.
4. **Production quality.** Consider security, validation, errors, authorization, tests, performance and logging every time.
5. **No fake completion.** Do not report a feature as done unless code exists, tests and checks pass, and no known blocker remains.
6. **No security shortcuts.** Never move critical validation to the client.
7. **Keep changes scoped.** Complete the requested phase only.
8. **Report honestly.** List what was done, what was not done, risks, and the files changed.
9. **No bulk deliverable archives.** Provide individual files, not zip bundles.

---

## 26. DEFINITION OF DONE

A feature is done only when all are true:

- Requirement implemented
- Database changes and migrations complete
- API and service logic complete
- UI complete where applicable
- Authorization implemented
- Input validation implemented
- Error handling implemented
- Tests added and passing
- Lint and type checks pass
- Build passes
- Documentation updated
- Economy impact reviewed (if money is involved)

---

## 27. COMPANION DOCUMENTS (to create next)

```
01_PRODUCT_REQUIREMENTS.md
02_GAME_DESIGN.md
03_GAME_ECONOMY.md
04_PLAYER_SYSTEM.md
05_REALTIME_ARCHITECTURE.md
06_WORLD_AND_MAP.md
07_BANKING_AND_LEDGER.md
08_JOBS_AND_CAREERS.md
09_BUSINESS_SYSTEM.md
10_PROPERTY_SYSTEM.md
11_SOCIAL_SYSTEM.md
12_PHONE_SYSTEM.md
13_DATABASE_ARCHITECTURE.md
14_API_ARCHITECTURE.md
15_SECURITY_AND_ANTI_CHEAT.md
16_ADMIN_PLATFORM.md
17_UI_UX_DESIGN_SYSTEM.md
18_SCALABILITY_ARCHITECTURE.md
19_TESTING_STRATEGY.md
20_DEPLOYMENT_AND_INFRASTRUCTURE.md
21_AI_CODING_AGENT_RULES.md
22_DEVELOPMENT_ROADMAP.md
```

**Recommended order:** 03 Economy, 07 Banking and Ledger, 13 Database, 06 World and Map, then the rest. Money and data design first, because they are the hardest to change later.

---

## 28. GOVERNMENT, FORCES AND INSTITUTIONS (V3+)

The long-term vision is a full country simulation: a president, governors, legislature, courts, police, armed forces, parties, media, and private companies.

**Architecture rule:** everything is an **organization** (one `organizations` table with a `type`). Companies, ministries, police, courts, parties and media all share offices, roles, budgets (ledger accounts), members and permissions. Build this generic model from the start so government is added later without rewrites.

**Rules**
- Elected or appointed officeholders change rules only inside admin-defined limits (for example tax rate between 0% and 30%).
- Terms, elections, impeachment and an admin override are mandatory.
- Police and courts are gameplay (fines, investigations, trials, short timeouts). No graphic violence.
- All parties, leaders and institutions are fictional. No real politicians or parties. No ethnic or religious conflict mechanics.
- Launch gating: government features unlock only when active population is large enough (target: several thousand weekly active players). Before that, offices are NPC-run.

Full details: `23_GOVERNMENT_AND_INSTITUTIONS.md`.

---

## FINAL RULE

Do not start by building random screens.

```
PLAN -> ARCHITECT -> SPECIFY -> IMPLEMENT -> TEST -> REVIEW -> RELEASE -> LEARN -> REPEAT
```

*End of Master Guide v1.2.0*
