# 05 - Realtime Architecture

Version 1.0 | Socket.IO on the Fastify server, Redis for adapter, presence and rate limits.

## 1. Principles
Server authoritative. Clients send intents ("go to location X"), server validates, updates state, emits events to scoped rooms. Clients never broadcast to other clients.

## 2. Connection lifecycle
1. Client opens socket with session cookie (or short-lived socket token from `/auth/socket-token`).
2. Server authenticates, loads player, joins rooms: `user:{id}`, `loc:{locationId}`, `group:{id}` for memberships.
3. Presence: key `presence:{userId}` with TTL refreshed by heartbeat (every 25s). Offline when TTL expires or on disconnect (with grace period 20s).
4. Reconnect: client resends last event cursor; server replays missed notifications from DB.

## 3. Rooms (scoped channels)
| Room | Purpose |
|---|---|
| `user:{id}` | Private notifications, money events, DMs |
| `loc:{id}` | Who is here, location events |
| `group:{id}` | Group chat |
| `city:{id}` | City-wide announcements and events (low volume only) |
| `org:{id}` | Organization staff channel (V2+) |

Never emit to a global room.

## 4. Event catalog
Server -> client:
`presence.updated`, `location.player_entered`, `location.player_left`, `message.received`, `notification.created`, `wallet.updated`, `transfer.received`, `shift.completed`, `needs.updated`, `event.started`, `event.ended`, `announcement.created`, `session.revoked`.

Client -> server (intents):
`location.travel`, `message.send`, `presence.heartbeat`, `typing.start` (optional).
All other mutations (money, jobs, shop) go through REST so they are idempotent and easy to test; the server then emits the resulting events.

## 5. Payload rules
Small JSON, ids not objects, versioned (`v:1`). Include `eventId` and `ts` for dedupe. Never include private data of other players.

## 6. Rate limiting
Per socket and per user (Redis token bucket): messages 20/10s, travel 6/min, heartbeats 1/20s. Violations: drop, count, escalate to temp mute or disconnect.

## 7. Location presence at scale
- `loc:{id}` presence list returns a capped, sorted sample (friends first, then recent) of up to 50.
- Counts are aggregated numbers; full lists are paged on demand.
- Big locations may shard into "instances" (channel suffix) when population exceeds a threshold.

## 8. Scaling
- Multiple server instances behind a load balancer with sticky sessions or Socket.IO Redis adapter.
- Presence and rate-limit state in Redis.
- Move heavy fan-out (events with many recipients) to queue workers.

## 9. Failure modes
- Redis down: degrade to local presence, disable realtime fan-out beyond single instance, keep REST working.
- Slow clients: drop to latest-state snapshots instead of queuing unlimited events.
- Duplicate events: clients dedupe by `eventId`.

## 10. Testing
Connect/disconnect, reconnect with cursor, presence TTL, scoped delivery (no leakage across rooms), rate-limit behavior, concurrent travel actions.
