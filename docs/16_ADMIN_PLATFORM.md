# 16 - Admin Platform

Version 1.0 | Separate app (`apps/admin`), separate auth, RBAC, full audit.

## 1. Access
- Admin users are users with admin roles; they log in at the admin domain with mandatory 2FA.
- Optional IP allowlist. Short session timeout. No admin actions from the player app.

## 2. Roles and permissions
Default roles: SUPER_ADMIN, GAME_ADMIN, MODERATOR, CONTENT_ADMIN, ECONOMY_ADMIN, SUPPORT_AGENT, ANALYST.
Permissions are strings like `players.view`, `players.suspend`, `economy.adjust`, `economy.parameters.edit`, `content.jobs.edit`, `moderation.reports.resolve`, `audit.view`, `roles.manage`.
Roles are data (tables `roles`, `permissions`, `role_permissions`). New roles require no code change.

## 3. Modules
### Dashboard
Online now, registered, DAU/WAU/MAU, new-player funnel, economy summary, server health, open reports, recent admin actions.
### Players
Search (username, email, id), profile view, ledger history, sessions, devices, flags, notes, suspend/restrict/ban, force logout, appeal handling.
### Economy
Money supply, faucets vs sinks, Gini, top wealth changes, transfer monitor, fraud flags queue, parameter editor (with diff and approval), manual adjustments (reason required, second approver above threshold).
### Content
CRUD with draft/publish for: jobs and career levels, items, shops and stock, locations/districts, events, wishes, achievements, announcements, help articles. Preview before publish. Import/export JSON.
### Moderation
Report queue (priority by severity/volume), conversation context view, actions (warn, mute, suspend, ban), canned responses, appeals, banned-word lists, hustle disputes.
### Support
Player lookup, safe tools (resend verification, unlock, compensation within limits).
### Analytics
Retention cohorts, funnels, session length, economy charts, feature usage.
### System
Feature flags and kill switches (transfers, hustle, shops, chat, registrations), maintenance mode, job queue status.

## 4. Audit logging
Every write action logs: admin id, action, target, before/after JSON, reason, IP, timestamp. Immutable (append-only, no UPDATE/DELETE permitted for app role).

## 5. Safety rules
- Four-eyes approval for large economy adjustments and parameter changes beyond thresholds.
- Admin cannot edit own permissions.
- Rate limits on admin APIs too.

## 6. UX
Desktop-first but usable on tablet. Fast tables with filters and saved views. Clear destructive-action confirmations.

## 7. MVP vs later
MVP: dashboard, players, content CRUD (jobs, items, locations), reports, announcements, audit log, basic economy dashboard. Later: advanced analytics, event builder, org/government management.
