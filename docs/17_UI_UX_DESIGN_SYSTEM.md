# 17 - UI/UX and Design System

Version 1.0 | Original look and feel. Do not imitate other games' visual identity. Tokens live in `design/design-tokens.json`; preview in `design/style-guide.html`.

## 1. Experience goals
Premium, friendly, fast, clear, mobile-first. A first-time player knows what to do in under 10 seconds on any screen.

## 2. Brand direction (placeholder, adjust freely)
- Personality: warm, witty, proud, energetic.
- Palette: **Naija Green** (primary), **Sunset Orange** (accent/action), **Ink** (text), **Cream** (surfaces), **Lagoon Blue** (info), **Hibiscus** (alerts/love). Avoid copying other games' purple-gradient phone look.
- Typography: a rounded, friendly display font for headings and a clean sans for UI (for example "Baloo 2" / "Nunito" or "Plus Jakarta Sans" - all open-licensed). Verify licenses.
- Iconography: one consistent set (for example Lucide, open license) plus original custom location icons.
- Illustration: original character and building art. Commission or generate with clear license terms.

## 3. Layout and navigation
- Mobile viewport design target: 360x800 (small Android) up to 430x932.
- Bottom nav: Home, Map, Market, Phone, Profile (validate with testing).
- Top bar: mood, time, wallet, notifications.
- Safe areas respected; thumb-reachable primary actions.

## 4. Core components
Button (primary/secondary/ghost/danger), Card, Bottom sheet, Modal, Tabs, Chip, Progress bar (needs/skills), Avatar, Badge, Toast, Skeleton, Input, Money input (with quick amounts), List row, Empty state, Receipt, Confirm sheet, Phone app icon, Map hotspot, Chat bubble.

## 5. Patterns
- **Money actions:** always confirm sheet with amount and recipient; success receipt; failure explains why.
- **Progress:** bars with labels, celebrate milestones (confetti, sound optional).
- **Empty states:** friendly, with one clear next action.
- **Errors:** human language, retry, never raw codes.
- **Loading:** skeletons; optimistic UI only for non-money actions.
- **Onboarding:** coach marks, one concept per screen, skippable.
- **Notifications:** toast for transient, center for history.

## 6. Motion
Short (150-250ms), purposeful, respects reduced-motion. Subtle map hotspot pulse, coin-count animations for earnings.

## 7. Accessibility
Contrast AA, tap targets >= 44x44, labels on icon buttons, focus states, text scaling to 130%, color not the only signal.

## 8. Performance budget
Initial JS < 200 KB gz for the first route; images in WebP/AVIF; icons as SVG; lazy-load apps; target LCP < 2.5s on mid-range Android 4G.

## 9. Tone of voice
Light, local, helpful. English with occasional Pidgin phrases. Examples: "Your wallet don full small. Nice!" Keep clear first; flavor second. Do not overdo slang or stereotypes.

## 10. Screens to design (MVP)
Splash/Login/Register, Verify email, Create character, Home dashboard, Map, Location sheet, Phone home, Bank, Transfer flow, Jobs/Career, Shift timer, Hustle board, Gig detail, Messages list, Chat, Contacts, Profile, Home/Rent, Inventory, Shop, Notifications, Settings, Help.

## 11. Wireframe sketch (home)
```
+--------------------------------+
| (mood) 12:00   N1,234,000  (bell)|
+--------------------------------+
| Next step: Start your first shift|
| [ Work now ]                     |
+--------------------------------+
| Needs: hunger ####- energy ###--|
| Wish: Make a new friend  +2 star |
+--------------------------------+
|     [ city map preview ]        |
+--------------------------------+
| Home | Map | Market | Phone | Me |
+--------------------------------+
```

## 12. Design handoff
Figma file with tokens as variables; components named identically to code; export icons as SVG; a11y annotations.
