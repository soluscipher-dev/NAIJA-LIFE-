# 01 - Product Requirements (PRD)

Version 1.0 | Owner: Abel | Source of truth for WHAT the product must do. See 00_MASTER_GUIDE for the vision.

## 1. Product summary
Mobile-first web/PWA, real-time multiplayer Nigerian life-sim. Players live persistent lives, earn and spend virtual naira, and interact in a player-driven economy.

## 2. Goals and success metrics (MVP beta)
| Goal | Metric | Target |
|---|---|---|
| Players understand the game fast | Onboarding completion | >= 70% |
| Players return | D1 / D7 retention | >= 35% / >= 15% |
| Economy stays healthy | Sinks / faucets ratio weekly | 0.8 - 1.2 |
| Social engagement | Players with >= 1 friend after 3 days | >= 50% |
| Stability | Crash-free sessions | >= 99% |
| Security | Confirmed money-duplication exploits | 0 |

## 3. Personas
- **Hustler** - grinds income, optimizes. - **Socialite** - chats, visits, events. - **Builder** - homes, businesses. - **Role-player** - careers and identity. - **Competitor** - leaderboards.

## 4. MVP functional requirements
IDs are stable; use them in tickets and tests.

### Accounts (ACC)
- ACC-1 Register with email, username, password. ACC-2 Email verification. ACC-3 Login/logout. ACC-4 Password reset by email. ACC-5 Session list and revoke. ACC-6 Rate-limited auth endpoints. ACC-7 Unique username (case-insensitive).

### Character (CHR)
- CHR-1 Create one character per account (name, avatar options). CHR-2 Profile card. CHR-3 Needs and mood. CHR-4 Skills with levels. CHR-5 Edit display name (cooldown).

### World (WLD)
- WLD-1 One city with districts and locations. WLD-2 Tap-to-travel with travel time/cost. WLD-3 Location menus (shop, job, social). WLD-4 See who is at a location (capped list).

### Multiplayer (MUL)
- MUL-1 Presence online/offline. MUL-2 Realtime location presence. MUL-3 Realtime messages and notifications. MUL-4 Reconnect handling.

### Economy (ECO)
- ECO-1 Wallet and bank balance. ECO-2 Deposit/withdraw wallet <-> bank. ECO-3 Player transfers with receipts. ECO-4 Transaction history. ECO-5 Weekly bills and rent. ECO-6 Light tax. ECO-7 All through ledger.

### Jobs (JOB)
- JOB-1 Job listings with requirements. JOB-2 Apply/accept (auto for NPC jobs). JOB-3 Work a shift (server-timed). JOB-4 Pay via ledger. JOB-5 Performance and promotion. JOB-6 Resign with cooldown.

### Hustle board (HUS)
- HUS-1 Post job with fee. HUS-2 Apply and accept. HUS-3 Escrow hold. HUS-4 Confirm and release. HUS-5 Rating. HUS-6 Dispute to moderation.

### Housing and inventory (HOM, INV)
- HOM-1 Rent a home weekly. HOM-2 Eviction fallback rules. INV-1 Items with quantity. INV-2 Buy from shops. INV-3 Use items (restore needs). INV-4 Gift items.

### Social (SOC)
- SOC-1 Friend requests. SOC-2 Private messages. SOC-3 Block, mute, report. SOC-4 Notifications center.

### Phone (PHN)
- PHN-1 Phone home with app icons. PHN-2 Apps: Bank, Jobs, Hustle, Messages, Contacts, Home, Inventory, Map, Notifications, Settings, Help.

### Leaderboards (LDB)
- LDB-1 Richest, top hustlers. LDB-2 Opt-out of public ranking.

### Admin (ADM)
- ADM-1 Separate admin login with RBAC. ADM-2 Player search/suspend. ADM-3 Content CRUD (jobs, items, locations). ADM-4 Economy dashboard. ADM-5 Report queue. ADM-6 Announcements. ADM-7 Audit log.

## 5. Non-functional requirements
- Performance: first load < 3s on 4G mid-range Android; interaction latency < 300 ms p95.
- Availability: 99.5% (beta).
- Security: see 15_SECURITY_AND_ANTI_CHEAT.
- Accessibility: readable text, contrast AA, tap targets >= 44px.
- Localization-ready strings (English now, Pidgin next).
- Privacy: NDPA compliant; minimal data.
- Observability: structured logs, error tracking, metrics.

## 6. Out of scope (MVP)
See Master Guide section 5: other cities, vehicles, advanced property, government, military, AI NPC conversations, native apps.

## 7. Acceptance
A requirement is accepted when it meets the Definition of Done in the Master Guide (section 26).

## 8. Open questions
Tracked in Master Guide section 23.
