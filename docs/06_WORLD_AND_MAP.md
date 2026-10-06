# 06 - World and Map

Version 1.0 | ADR-0002: tap-based map for MVP.

## 1. Hierarchy
Country -> City -> District -> Location -> Interactable. All data-driven (DB + admin).

## 2. MVP city (placeholder content, rename freely)
Original names only. Example layout (fictional): 
- **Central Business District** - Bank, Office Tower, Recruitment Center
- **Market Quarter** - Supermarket, Open Market, Food Court
- **Palm Heights (residential)** - Estate Agent, Rental blocks
- **Entertainment Strip** - Cinema, Lounge, Games Arcade
- **Knowledge Park** - Library, Training Center
- **Waterfront** - Park, Jetty, Cafe
Total ~12-15 locations at launch.

## 3. Location definition (data)
`id, city_id, district_id, name, type, icon, map_x, map_y, open_hours (optional), capacity (for presence), actions[]`

Actions per location (config): `shop`, `work_shift`, `rest`, `socialize`, `bank`, `estate_agent`, `service` (salon, clinic), `event_stage`.

## 4. Travel
- Player taps location -> `location.travel` intent.
- Server validates: location exists, open, player not in a blocking activity (mid-shift).
- Travel time: instant for MVP within the same district, short timer (5-20s) between districts, optional cost later. Never client-timed.
- State: `player_locations(player_id, location_id, entered_at)`.

## 5. Presence at a location
- Show total count and a capped sample list. Tap a person -> profile card -> actions (message, friend request, send money, invite).
- Players can set "invisible to strangers" in privacy settings.

## 6. Map rendering
- Single scrollable/pannable map image or SVG with tappable hotspots (absolutely positioned from `map_x/map_y`).
- Lazy-load heavy art. Provide a list view fallback for accessibility and slow devices.
- Budget: initial map payload < 300 KB (compressed), icons as sprite/SVG.

## 7. Content authoring
Admin tool to create/edit districts and locations, with preview. Seed script for the starter city.

## 8. Expansion
- New cities = new rows + art. Travel between cities with cost/time (V3).
- Seasonal decoration layers (V2).
- Possible free-roam mode later via a new ADR.

## 9. Originality rule
Do not mimic any existing game's map layout, names, building art or icons. Maintain an originality note per city in `docs/decisions/` when designing.
