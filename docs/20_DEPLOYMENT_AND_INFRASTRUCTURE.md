# 20 - Deployment and Infrastructure

Version 1.0

## 1. Environments
| Env | Purpose | Data |
|---|---|---|
| local | Development with Docker Compose | seed data |
| staging | Pre-release testing, mirrors prod | anonymized/seed |
| production | Live | real |

## 2. Local development
`docker compose up -d` for Postgres 16 and Redis 7. `.env` from `.env.example`. Commands (to be created in Phase 1):
```
pnpm install
pnpm db:migrate
pnpm db:seed
pnpm dev          # runs web, admin, server
pnpm lint | typecheck | test | build
```

## 3. Hosting options (decide after beta load/cost review; ADR required)
- **Start simple (suggested for beta):** managed platform for app (Railway, Render, Fly.io, or a VPS with Docker), managed Postgres (Neon, Supabase, RDS), managed Redis (Upstash or similar), object storage (S3-compatible / Cloudflare R2), Cloudflare for DNS/CDN/WAF.
- **Later:** AWS (including Cape Town region) or equivalent with autoscaling, managed DB, CDN.
Pick regions for Nigerian latency; test from Lagos networks.

## 4. Services
web (Next.js), admin (Next.js), server (Fastify + Socket.IO), worker (BullMQ jobs), Postgres, Redis, object storage, email provider (Resend/Postmark/SES), error tracking (Sentry), uptime monitoring.

## 5. CI/CD
- GitHub Actions: lint, test, build on PR.
- Auto-deploy staging on merge to `main`; production on tagged release with manual approval.
- DB migrations run as a separate pre-deploy step, backward compatible (expand/contract pattern).
- Rollback: redeploy previous image; migrations are forward-compatible.

## 6. Configuration and secrets
Environment variables from secret manager. Different secrets per environment. Rotate on staff changes or leaks. Never commit `.env`.

## 7. Domains and security
- Player: `app.example.com` (placeholder). Admin: `admin.example.com` (separate cookie, IP allowlist optional). API: `api.example.com`.
- TLS everywhere, HSTS, WAF rules, rate limits at edge.

## 8. Backups and DR
Daily snapshots + PITR, restore tested quarterly, object storage versioning, documented RTO (4h) and RPO (15 min) targets for beta.

## 9. Monitoring and alerting
Uptime checks, error rate, latency, DB CPU/connections/locks, queue depth, WebSocket connections, ledger reconcile status. Alerts to phone/Slack/email with on-call owner (you).

## 10. Release process
1. Feature flag new risky features. 2. Merge to main -> staging. 3. Smoke test checklist. 4. Tag release. 5. Deploy during low traffic. 6. Watch dashboards 30 minutes. 7. Update CHANGELOG.

## 11. Cost guardrails
Budget alerts, autoscaling limits, log retention limits, image optimization, review monthly.

## 12. Launch checklist
See `plans/LAUNCH_CHECKLIST.md`.
