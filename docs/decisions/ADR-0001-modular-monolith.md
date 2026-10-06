# ADR-0001: Modular monolith first

**Status:** Accepted  **Date:** 2026-10

## Context
Solo builder working through AI agents. Microservices add cost and failure modes before there is load.

## Decision
One deployable server with strict domain modules and exported service interfaces. Split a module into a service only when measured load requires it.

## Consequences
- Faster development and simpler deploys.
- Module boundaries must be enforced in review (no cross-module table access).
