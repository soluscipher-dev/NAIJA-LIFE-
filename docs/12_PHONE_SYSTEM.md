# 12 - Phone System (Main UI)

Version 1.0 | The phone is the player's menu. Original design, not a clone of any other game's phone.

## 1. Principles
One tap to any core feature, no deep menus, apps unlock gradually, clear "next best action" on the home.

## 2. Layout
- Status bar: time (game/Lagos), mood, wallet balance, notification bell.
- App grid (4 columns), page dots for more.
- Dock (4 pinned apps, player-chosen).
- Bottom app nav outside phone: Home, Map, Market, Phone, Profile.

## 3. App registry (data-driven)
Each app: id, name, icon, category, unlock_condition, route, badge source. Admin can add apps without code for simple content apps (Help, News).

## 4. MVP apps
| App | Purpose |
|---|---|
| Bank | Balances, deposit/withdraw, transfers, history, bills |
| Jobs | Career job, shifts, promotion |
| Hustle | Gig board, my gigs, ratings |
| Messages | Chats, new message, groups later |
| Contacts | Friends, requests, search by username |
| Home | Rent, comfort, visits |
| Inventory | Items, use, gift |
| Map | Open the city map |
| Notifications | Notification center |
| Settings | Account, privacy, language, sound |
| Help | Guides and FAQ |

V1: Needs, Wishes/Goals, Leaderboards, Achievements, Events, Groups, Safety.
V2: Invest, Businesses, Education, Health, News, Property market.

## 5. Unlock order (onboarding)
1. Jobs + Bank + Map (first 5 minutes) -> 2. Messages + Contacts (after first reward) -> 3. Home + Inventory (after first rent due) -> 4. Hustle (level 2) -> 5. rest by milestones.

## 6. Interaction patterns
- Bottom sheets for details, full-screen for deep flows (bank, chat).
- Skeleton loading states; offline banner; retry buttons.
- Haptics and sounds optional (settings).
- Every money action shows a confirm sheet with exact amount and recipient.

## 7. Notifications badges
Per-app badge counts from the notifications service; realtime updates via `notification.created`.

## 8. Accessibility
Dynamic text support, contrast AA, labels for icons, reduced-motion setting.

## 9. Performance
Lazy load app bundles, prefetch likely next app, cache lists, avoid layout shifts.
