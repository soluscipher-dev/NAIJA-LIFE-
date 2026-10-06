# 14 - API Architecture

Version 1.0 | Fastify + Zod. REST for mutations and queries; Socket.IO for realtime (see 05).

## 1. Conventions
- Base path: `/api/v1`. JSON only. Shared Zod schemas in `packages/shared`.
- Auth: session cookie (httpOnly, secure, sameSite=lax). CSRF protection for cookie auth (double-submit token or origin check).
- Errors: `{ error: { code, message, details? } }` with correct HTTP status. Error codes are stable strings (for example `INSUFFICIENT_FUNDS`).
- Pagination: cursor-based (`?cursor=&limit=`), max limit 50.
- Idempotency: `Idempotency-Key` header required on money and reward endpoints.
- Versioning: breaking changes -> `/api/v2`.
- Rate limits: standard headers returned.

## 2. Layers
Route (validation, auth) -> Service (business logic, transactions) -> Repository (SQL). Services call other modules via their service interfaces only.

## 3. Endpoint catalog (MVP)
### Auth
`POST /auth/register`, `POST /auth/login`, `POST /auth/logout`, `POST /auth/verify-email`, `POST /auth/forgot-password`, `POST /auth/reset-password`, `GET /auth/sessions`, `DELETE /auth/sessions/:id`, `POST /auth/socket-token`
### Player
`GET /me`, `POST /character`, `PATCH /character`, `GET /players/:username`, `GET /needs`, `GET /skills`, `PATCH /settings/privacy`
### World
`GET /world/city`, `GET /locations/:id`, `POST /locations/:id/travel`, `GET /locations/:id/presence`
### Bank
`GET /bank/summary`, `POST /bank/deposit`, `POST /bank/withdraw`, `POST /bank/transfer`, `GET /bank/transactions`, `GET /bank/bills`, `POST /bank/bills/:id/pay`
### Jobs
`GET /jobs`, `POST /jobs/:id/apply`, `GET /career`, `POST /career/shifts/start`, `POST /career/shifts/:id/claim`, `POST /career/promotion`, `POST /career/resign`
### Hustle
`GET /hustle/gigs`, `POST /hustle/gigs`, `POST /hustle/gigs/:id/apply`, `POST /hustle/gigs/:id/accept`, `POST /hustle/gigs/:id/deliver`, `POST /hustle/gigs/:id/confirm`, `POST /hustle/gigs/:id/dispute`, `POST /hustle/gigs/:id/rate`
### Home and inventory
`GET /home`, `POST /home/rent`, `POST /home/pay-rent`, `GET /inventory`, `POST /inventory/use`, `POST /inventory/gift`, `GET /shops/:id`, `POST /shops/:id/buy`
### Social
`GET /friends`, `POST /friends/requests`, `POST /friends/requests/:id/accept`, `DELETE /friends/:id`, `POST /blocks`, `DELETE /blocks/:id`, `GET /conversations`, `GET /conversations/:id/messages`, `POST /conversations/:id/messages`, `POST /reports`
### Notifications
`GET /notifications`, `POST /notifications/read`
### Leaderboards
`GET /leaderboards/:type`

### Admin API (`/admin/api/v1`, separate auth, RBAC)
`/players`, `/players/:id/suspend`, `/economy/metrics`, `/economy/parameters`, `/content/jobs|items|locations|events`, `/reports`, `/announcements`, `/audit-logs`.

## 4. Security on every route
1. AuthN, 2. AuthZ (ownership or permission), 3. Zod validation (body, params, query), 4. rate limit, 5. audit (if sensitive), 6. safe error output (no stack traces).

## 5. Validation rules (examples)
- username: `^[a-zA-Z0-9_]{3,20}$`; password min 10 chars; message max 500; transfer amount integer 1..limit; notes sanitized and max 80 chars.

## 6. Observability
Request id on every request/log line; structured logs; metrics per route (latency, errors); slow-query log.

## 7. Documentation
OpenAPI generated from Zod schemas; served in dev at `/docs`. Keep this catalog in sync.

## 8. Outbox and jobs
Domain events recorded in an `outbox` table inside the same transaction, then published to Redis/Socket.IO by a worker. Background jobs (BullMQ): rent, bills, interest, payroll, needs-notify, leaderboard refresh, reconcile.
