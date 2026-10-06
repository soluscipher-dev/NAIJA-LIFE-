# ADR-0003: Double-entry ledger, integer money

**Status:** Accepted  **Date:** 2026-10

## Context
Economy exploits (duplication, race conditions) destroy this type of game.

## Decision
All money movement goes through a ledger service: double-entry (entries sum to zero), atomic DB transactions, row locking, idempotency keys. Money is bigint whole naira. Balances are derived or cached with ledger as truth.

## Consequences
- Every money feature must use the ledger service.
- Slightly more work per feature, far safer economy.
