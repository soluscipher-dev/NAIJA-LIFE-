# 13 - Database Architecture

Version 1.0 | PostgreSQL 16+. Draft schema: `db/schema.sql`. Final migrations are created in Phase 1+ with Drizzle/SQL migrations.

## 1. Conventions
- Primary keys: UUID (v7 preferred) or `bigint identity` for high-volume tables (ledger_entries, messages).
- Timestamps: `timestamptz`, stored UTC. Columns `created_at`, `updated_at`.
- Money: `bigint` whole naira. Never numeric floats.
- Names: snake_case, plural tables.
- Soft delete (`deleted_at`) only where audit/restore matters (users, messages for moderation).
- Enums: use text + CHECK or lookup tables (easier to migrate than PG enums).
- JSONB for flexible config (avatar config, metadata), never for core relational data.

## 2. Domain groups
| Domain | Tables |
|---|---|
| Auth | users, sessions, email_tokens, password_resets |
| Player | characters, needs_state, skills, player_skills, achievements, player_achievements |
| World | cities, districts, locations, player_locations |
| Ledger | ledger_accounts, ledger_transactions, ledger_entries |
| Jobs | jobs, career_levels, player_jobs, shifts |
| Hustle | hustle_gigs, hustle_applications, hustle_ratings, hustle_disputes |
| Inventory | items, inventory, shops, shop_stock |
| Property | properties, property_ownership, leases |
| Social | friendships, blocks, messages, conversations, groups, group_members, reports |
| Notifications | notifications |
| Orgs | organizations, org_roles, org_members, offices |
| Admin | admin_users (link to users), roles, permissions, role_permissions, audit_logs, config_parameters, announcements, events, event_participants |

## 3. Key constraints
- `users.email` unique (lowercase), `users.username` unique (citext).
- `ledger_entries` per transaction must sum to zero (enforced by constraint trigger + tests).
- `ledger_accounts.balance >= 0` for player accounts (CHECK by kind).
- `friendships` unique pair (least, greatest ids).
- `inventory` unique (character_id, item_id) with quantity > 0.
- `player_jobs` one active per character.
- `shifts` unique active shift per character.
- Idempotency unique (actor_id, idempotency_key) on ledger_transactions.

## 4. Indexing guide
- FKs indexed. 
- Ledger: (account_id, created_at desc), (transaction_id).
- Messages: (conversation_id, created_at desc).
- Notifications: (user_id, read_at, created_at desc).
- Locations: (city_id, district_id).
- Shifts: (character_id, status), (ends_at) for scheduler.
- Hustle: (status, category, created_at desc).
- Use partial indexes for hot filters (for example open gigs).

## 5. Transactions and locking
Money flows follow 07_BANKING_AND_LEDGER. Lock accounts in ascending id order. Use `SELECT ... FOR UPDATE SKIP LOCKED` for job queues. Keep transactions short.

## 6. Migrations
- Versioned SQL migrations in `packages/db/migrations`. Forward-only in production; write rollback notes.
- Every migration reviewed for locks (no long table rewrites on hot tables). Use `CREATE INDEX CONCURRENTLY` where needed.
- Seed scripts: `seed:dev` (starter city, jobs, items) and `seed:test`.

## 7. Backups and recovery
Daily full + continuous WAL archiving (PITR). Quarterly restore drills. Retention 30 days minimum. Ledger tables are highest-priority.

## 8. Partitioning plan (future)
`ledger_entries` and `messages` by month once > 100M rows. Archive cold data.

## 9. Data privacy
Personal data minimized, email encrypted at rest at the disk level, access limited by role, deletion/anonymization procedure documented.

## 10. Reporting
Read replica or materialized views for analytics and the economy dashboard to avoid load on primary.
