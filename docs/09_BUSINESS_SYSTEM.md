# 09 - Business System (V2)

Version 1.0 | Built on the generic organizations model (ADR-0004).

## 1. Concept
A player (or group) founds a business, funds it, stocks it, hires players, and sells to players and NPC demand. This is the main player-driven economy.

## 2. Business as organization
`organizations(type='company')` with: owner, name, category, location, reputation, license status, ledger account (business account), offices/roles (Owner, Manager, Staff), members.

## 3. Starter business types (V2)
1. Food stall / restaurant
2. Retail shop
3. Delivery/logistics
4. Media/photography studio
Add more later: fashion, tech, farm, entertainment, transport.

## 4. Lifecycle
1. **Register:** pay license fee (sink), choose type and name (moderated), pick a location slot.
2. **Fund:** move money from owner wallet to business account (ledger).
3. **Stock:** buy supplies from wholesale NPC market (sink) or from other players.
4. **Hire:** post positions (pay per shift, hours); players apply.
5. **Operate:** sales from player customers and NPC demand; each sale posts to the ledger (customer -> business; tax if configured).
6. **Payroll:** automatic on schedule from business account.
7. **Close/Sell:** liquidate or transfer ownership (V3).

## 5. Revenue and costs
- Revenue: sales, services, contracts.
- Costs: supplies, payroll, rent of premises, license renewal, taxes, ads.
- Profit/loss report per week (derived from ledger by business account).

## 6. Reputation
Customer ratings, delivery reliability, payroll punctuality -> business reputation. Affects demand and hiring.

## 7. NPC demand model
Simple, config-driven: each location has demand per category per hour; shops compete by price, reputation and stock. Admin-tunable to keep margins sane.

## 8. Roles and permissions
Owner (all), Manager (hire/fire staff, set prices, restock), Staff (work shifts, serve). Permissions via org roles table.

## 9. Safeguards
Payroll failure handling, owner abandonment (auto-close after N inactive weeks with asset return rules), caps on number of businesses per player at early stage, anti-wash-trading checks between owner and "customers."

## 10. Metrics
Businesses created, active, profit distribution, employee count, failure rate, tax collected.
