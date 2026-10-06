# ADR-0002: Tap-based map for MVP

**Status:** Accepted  **Date:** 2026-10

## Context
Free-roaming worlds need movement sync, collision, and heavy rendering. That is costly for one builder and for low-end phones.

## Decision
The MVP map is a tap-based city map. Players tap a location to go there. Presence is per location.

## Consequences
- Much cheaper realtime load and simpler anti-cheat.
- Free movement can be revisited in V3+ if justified.
