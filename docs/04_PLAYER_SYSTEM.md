# 04 - Player System

Version 1.0

## 1. Entities
Account (login identity) -> Character (in-game person) -> Wallet/Bank -> Inventory -> Employment -> Skills -> Properties -> Relationships -> Achievements -> Notifications -> Statistics.

MVP rule: one character per account.

## 2. Account
- Fields: id, email (unique, verified), username (unique, case-insensitive, 3-20 chars, letters/digits/underscore), password hash (argon2id), status (active, suspended, banned, deleted), created_at, last_login_at.
- Email verification required before wallet features like transfers.
- Sessions: secure httpOnly cookies, rotation, device list, revoke all.
- Recovery: time-limited single-use reset token via email.

## 3. Character
- Display name (cooldown on change), avatar config (JSON: skin, hair, face, outfit, accessories), gender presentation options, created_at.
- Stats: level (overall), mood label, needs state (see 02), skills (see 02).
- Public profile: avatar, username, display name, title, level, badges, hustle rating, join date. Never show email, wallet detail, or exact location unless the player allows.

## 4. Avatar rules
- Inclusive options (skin tones, hair types, outfits), no body-shaming mechanics.
- Original art only. Avatars are stored as config, rendered client-side from licensed/original asset layers.

## 5. Needs state
Stored as last-known value + `updated_at`; current value is computed from elapsed server time on read (lazy decay) to avoid cron-per-player.

## 6. Progression
- Skill XP -> skill level. Overall level from total XP. Thresholds in config.
- Titles unlock from achievements and careers.

## 7. Privacy settings
- Hide from leaderboards, hide online status, allow messages from (everyone / friends), allow house visits (everyone / friends / nobody).

## 8. Account lifecycle
- Deletion request: soft-delete, anonymize chat per policy, keep ledger records (legal and audit) with pseudonymized identity.
- Suspension and ban handled by moderation (see 16).

## 9. Statistics
Jobs done, hustle rating, shifts worked, money earned/spent (aggregated), friends, achievements. Used for profile and analytics; no sensitive personal data.

## 10. Edge cases
Username change policy (rare, cooldown), duplicate-account detection signals, email change flow requiring re-verification, minors policy per legal decision (Master Guide 23).
