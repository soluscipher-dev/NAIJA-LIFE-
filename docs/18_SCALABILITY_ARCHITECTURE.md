# 18 - Scalability Architecture

Version 1.0 | Scale when load justifies it. Measure first.

## 1. Stages
| Stage | Players (concurrent) | Setup |
|---|---|---|
| S0 Beta | < 500 | 1 server instance, 1 Postgres, 1 Redis |
| S1 | 500 - 5,000 | 2-3 server instances, managed Postgres, Redis, CDN, worker process |
| S2 | 5k - 50k | Autoscaled instances, read replica, PgBouncer, separate realtime tier, queue workers |
| S3 | 50k - 500k | Sharded realtime, partitioned ledger/messages, caching layers, dedicated analytics store |
| S4 | 500k+ | Multi-region, service extraction (ledger, realtime, messaging) |

## 2. Principles
- Stateless app servers (state in Postgres/Redis).
- Horizontal scale realtime via Socket.IO Redis adapter.
- Cache read-heavy static config (jobs, items, locations) in memory/Redis with versioned invalidation.
- Writes that matter (ledger) stay in Postgres, short transactions.
- Background work in queues; never block requests on heavy tasks.

## 3. Hot paths and plans
| Path | Risk | Plan |
|---|---|---|
| Ledger posting | Row contention on popular accounts (system accounts, shop sinks) | Shard system accounts (BURN_01..N), batch posting for sinks, async burn accounting |
| Presence | Many updates | Redis with TTL, aggregate counts, capped lists |
| Messages | High write volume | Partition by month, index tight, archive old |
| Leaderboards | Expensive sorts | Redis sorted sets refreshed by worker |
| Needs decay | Per-player timers | Lazy decay on read, no per-player cron |
| Rent/payroll | Burst at weekly times | Batch jobs with chunking, jitter, idempotency |

## 4. Database
Connection pooling (PgBouncer), read replicas for analytics and leaderboards, vacuum tuning, monitoring bloat, slow-query review each phase.

## 5. Caching
- Config cache (TTL + version key).
- Profile cache (short TTL).
- Never cache balances for decisions; display caching only with short TTL and refresh after mutations.

## 6. CDN and assets
Static assets and images via CDN, immutable hashed filenames, WebP/AVIF, compression, service worker caching for shell.

## 7. Observability
Metrics: RPS, p95 latency, error rate, DB connections, lock waits, queue depth, WebSocket connections, memory. Dashboards + alerts. Distributed tracing when services split.

## 8. Load testing
Tools: k6 or Artillery. Scenarios: login storm, mass shift claims at the same minute, weekly rent batch, 5k socket connections with chatter, transfer contention on one account. Run before each stage upgrade.

## 9. Cost control
Start on small managed services, autoscale by metrics, set budget alerts, compress and cache aggressively, prune old data.

## 10. Regional notes
Majority of players in Nigeria: choose a region with good latency (Europe or Africa regions with CDN edge in Lagos). Keep payloads small for mobile data costs.
