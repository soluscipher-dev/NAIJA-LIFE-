# 15 - Security and Anti-Cheat

Version 1.0 | Security is a core system. Review each phase against this list.

## 1. Threat model (top risks)
1. Money duplication / race conditions. 2. Account takeover. 3. Multi-account farming and funneling. 4. Scams and social engineering. 5. Chat abuse. 6. Admin account compromise. 7. Bots/automation. 8. Data leaks. 9. DDoS/abusive traffic.

## 2. Authentication and sessions
- argon2id password hashing; breached-password check (k-anonymity API) optional.
- Login throttling per account + IP, progressive delays, alerts on many failures.
- Sessions: random 256-bit ids, hashed in DB, rotation on login/privilege change, idle + absolute timeout, device list, revoke all.
- Email verification and reset tokens: single-use, hashed, short TTL.
- Optional 2FA (TOTP) for players with high balances; REQUIRED for all admin accounts.

## 3. Authorization
- Ownership checks on every resource (player can only touch own wallet/inventory).
- Admin RBAC with granular permissions; separate admin app, separate session cookie, separate subdomain, IP allowlist option.
- Deny by default.

## 4. Server authority
Client sends intents only. Server computes: rewards, prices, timers, needs, locations, cooldowns. No client-provided amounts for rewards. Item prices read from DB at purchase time.

## 5. Money safety (see 07)
Ledger, locking, idempotency, reconcile, caps/velocity, large-transfer alerts.

## 6. Anti-cheat signals
| Signal | Action |
|---|---|
| Many accounts, same device/IP, transfers to one account | Flag funnel, hold transfers, review |
| Shifts claimed faster than allowed | Reject, count, auto-flag after N |
| Perfectly regular action timing (bot-like) | Challenge (captcha) or throttle |
| Transfer loops A->B->A | Flag wash |
| Unusual gains vs cohort | Flag for economy review |
| Rapid new-account to large balance | Hold withdrawals/transfers |
Flags create `fraud_flags` records; admins can freeze accounts (ledger-safe freeze, no deletion).

## 7. Bot and abuse control
Rate limits (IP, user, endpoint), captcha on register/suspicious actions, email domain checks, disposable-email blocking, device fingerprint (privacy-respecting hash), progressive trust levels for new accounts.

## 8. Application security
- Input validation (Zod) and output encoding; parameterized SQL only.
- CSP, HSTS, secure headers, CORS allowlist, CSRF protection.
- File uploads (avatars/images later): type/size checks, re-encode, scan, random names, serve from separate domain/CDN.
- Dependency scanning (Dependabot, `pnpm audit`), lockfile committed.
- Secrets in environment/secret manager; rotate on exposure.
- No sensitive data in logs. Redact tokens and emails.

## 9. WebSocket security
Authenticate on connect, validate every event payload, per-event rate limits, scoped rooms, disconnect on abuse, origin checks.

## 10. Infrastructure security
Private DB network, least-privilege DB roles (app role cannot DROP), TLS everywhere, WAF/CDN, DDoS protection, backups encrypted, admin access via VPN or allowlist.

## 11. Incident response
Runbook: detect -> contain (freeze flagged accounts, disable feature flag) -> assess ledger integrity -> fix -> restore/compensate -> postmortem. Maintain feature flags to disable transfers, hustle, or shops quickly (kill switches).

## 12. Privacy and compliance
NDPA alignment, data minimization, retention policy, user data export/deletion requests, breach notification procedure.

## 13. Security checklist per feature
- [ ] AuthZ tested  - [ ] Validation  - [ ] Rate limit  - [ ] Idempotent (if money)  - [ ] Audit log (if sensitive)  - [ ] Abuse cases tested  - [ ] No secrets/PII in logs.
