# 10 - Property System

Version 1.0

## 1. Phases
- **MVP:** NPC-landlord rentals (weekly rent).
- **V2:** buy homes, upgrades, decoration, land plots, player landlords.
- **V3:** commercial property, construction, real-estate companies, property market.

## 2. Property types
Room, mini-flat, flat, house, mansion, land plot, commercial unit.
Each property type (config): price, rent, capacity (guests), comfort, decor slots, status points.

## 3. Rent rules (MVP)
- Weekly rent due at a fixed time (for example Saturday 09:00 Lagos time). Reminder notifications 3 days and 1 day before.
- Players can pay ahead.
- Grace period 48h with a late fee.
- If still unpaid: eviction to the free shared-shelter tier. Items are preserved in storage (retrievable on rehoming for a small fee). Never delete inventory.

## 4. Ownership (V2)
- Purchase via ledger (`purchase`), record in `property_ownership` (owner, acquired_at, price, upgrades).
- Sell back to system at a fraction (sink) or to other players via listing.
- Land plots: grow in value by a configured weekly rate within bounds; selling realizes the growth.

## 5. Decoration and comfort
Furniture items placed in decor slots increase comfort, which improves needs recovery and mood. Cosmetic skins per property tier.

## 6. Visits and invites
- Owner sets visit mode: nobody, friends, link, public.
- Capacity limit; owner can remove guests.
- House invite links are unguessable tokens, revocable, rate limited.

## 7. Player landlords (V2)
List a property for rent, set weekly rent within bounds, collect via ledger (platform fee sink). Eviction process follows the same safe rules.

## 8. Anti-abuse
Listing price bounds, ownership transfer limits for new accounts, duplicate-account laundering detection, bounded land appreciation.

## 9. Tests
Rent scheduler idempotency, eviction safety, concurrent purchase of the same property, listing and transfer flows.
