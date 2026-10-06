# 11 - Social System

Version 1.0

## 1. Features
Friends, private messages, groups, house visits, gifts, public profiles, reports, blocks, mutes.

## 2. Friends
- Request -> accept/decline. Limit pending requests per day. Max friends (for example 500).
- Friend status: online, last seen (respect privacy settings).
- Friends-only features: house visit mode, gifts above threshold, DM-from-friends-only setting.

## 3. Messaging
- 1:1 private chat (MVP). Group chat (V1).
- Text only at MVP. Image sharing later with scanning and moderation.
- Quick actions in chat: send money, invite over, visit, offer a gig.
- System messages: money received, job offers.
- Limits: message length (500), rate limits (see 05), link filtering, repeated spam detection.
- Retention: keep messages for the account lifetime unless deleted; reported messages are preserved for moderation.

## 4. Groups (V1)
Create (name moderated), invite, roles (owner, admin, member), group chat, group events, member cap.

## 5. Safety
- Block: hides profile, prevents DM/visit/transfer between the two.
- Mute: silences notifications from a player or group.
- Report: reason categories (harassment, scam, spam, inappropriate name, cheating, other) + context (message ids). Rate-limited to prevent abuse.
- Auto-mod: banned word filter (English and Pidgin lists), spam heuristics, link rules.
- Escalation: warning -> mute (temporary) -> suspension -> ban. Appeals flow.

## 6. Scam protection
Money scams are likely (fake gigs, "send me N1m, I'll send back"). Mitigations: scam warnings on large transfers, first-time-recipient warnings, hustle escrow promoted, player education in Help, report shortcut on transfer receipts.

## 7. Privacy
Granular settings (see 04). Public profile never shows private financial data unless the player opts in to showing net worth rank.

## 8. Notifications
In-app center, realtime, then push/email (V1). Categories can be muted.

## 9. Tests
Block enforcement across all channels, privacy settings enforcement, report workflow, message rate limits.
