# 23 - Government, Forces and Institutions (V3+)

Version 1.0 | Long-term vision: a full country simulation. Built on the organizations model (ADR-0004). Do not build before the player base supports it.

## 1. Vision
A fictional Nigerian-inspired country where players can hold public office, run companies, serve in police or courts, and shape rules, taxes and public projects, all inside safe, bounded limits.

## 2. Fictional world rules (mandatory)
- All parties, leaders, ministries, laws and conflicts are FICTIONAL.
- No real politicians, real parties, or real-world political campaigns.
- No ethnic, tribal or religious conflict mechanics. No real-world election disinformation mechanics.
- Tone: satire-light and civic, never hateful.

## 3. Organization types
`company, ministry, agency, police, army, court, legislature, party, media, ngo`.
All share: offices, roles, members, permissions, a ledger account (budget), a charter (what they may do), an audit trail.

## 4. Government structure (proposal)
- **Executive:** President, Vice President, Ministers (Finance, Labour, Housing, Health, Education, Interior, Trade, Information).
- **Legislature:** elected members propose and vote on bills (rule changes within limits).
- **Judiciary:** courts, judges, prosecutors, public defenders (player and NPC).
- **State/city level:** governors, mayors (when multiple cities exist).
- **Agencies:** tax authority, business registry, housing authority, transport authority.
- **Forces:** police (law enforcement gameplay), armed forces (V4+, strictly non-graphic, defensive/event-based gameplay such as disaster response and parades).

## 5. Powers and limits (guardrails)
Every power has bounds set by admins in `config_parameters` (min/max). Examples:
| Power | Holder | Bounds |
|---|---|---|
| Set income tax rate | Finance Minister (approved by legislature) | 0% - 30% |
| Set business license fee | Trade Minister | within 0.5x - 2x base |
| Fund public projects | Treasury (budget from taxes) | Cannot exceed treasury balance |
| Declare public holidays/events | Information Minister | Max N per season |
| Issue fines | Police/courts | Max per offense type |
| Pass laws | Legislature | Only from a catalog of "lawable" parameters |
Officeholders cannot mint money, edit the ledger, or touch other players' wallets directly.

## 6. Elections and appointments
- Terms: for example 4 weeks. Term limits. Staggered elections.
- Eligibility: minimum account age, level, clean record, minimum reputation.
- Campaign tools: profile page, manifesto (moderated), rallies (events), endorsements. Campaign spending uses in-game money (sink).
- Voting: one account one vote, anti-multi-account checks, secret ballot, results audited.
- Appointments by elected officials with confirmation rules.
- Impeachment/recall by supermajority with cause.
- Admin override and emergency reset always available.

## 7. Treasury and budget
Taxes flow to `SYSTEM_TAX`, then to the national treasury (organization account). The budget allocates to ministries; ministries fund public projects, salaries for public jobs, subsidies. Public spending is transparent in a "Public Ledger" view.

## 8. Public jobs
Civil service careers (clerk, officer, inspector, judge...). Pay from ministry budgets. Same job engine as private careers.

## 9. Law and order (gameplay)
- Offense catalog (game-defined): scams, harassment (in-game), tax evasion, fraudulent business reports, hustle fraud.
- Investigation: police players/NPCs review evidence generated from ledger and chat reports.
- Process: report -> investigation -> charge -> court hearing (async) -> verdict -> penalties (fines, temporary restrictions, community service gigs, reputation).
- Penalties are bounded and game-appropriate. No real-world harm depiction. Appeals to admin.
- Protect against abuse of power: audit log, oversight roles, transparency, quick removal by admins.

## 10. Armed forces (V4+)
Non-graphic: parades, national events, disaster/emergency response mini-events, ranks and uniforms as status. No combat simulation with real-world groups.

## 11. Private companies in the ecosystem
Companies pay corporate tax, need licenses, can lobby (petition mechanics) within rules, can win government contracts via a transparent bidding system.

## 12. Media
Player-run news outlets (organizations) publish articles (moderated), earn from subscriptions/ads. Misinformation controls: labeling, reports, moderation, takedown. Fictional-only subject matter.

## 13. Parties
Player-created parties with membership, manifestos, primaries, funding. Fictional names only; real party names blocked via filter.

## 14. Launch gating and rollout
1. Prerequisite: stable economy, moderation team, organizations model live, >= several thousand weekly active players.
2. Pilot: NPC-run government with player advisory votes.
3. Phase A: Mayor/city council elections in the starter city.
4. Phase B: National offices, legislature, courts.
5. Phase C: Police/courts gameplay.
6. Phase D: Armed forces events.
Feature flags control each stage; rollback plan for each.

## 15. Risks
Toxicity and political abuse, power concentration, griefing, real-world sensitivity, moderation load. Mitigate with bounds, transparency, audit, kill switches, active moderation, and clear fiction.

## 16. Data model hooks (already in schema draft)
`organizations, org_roles, org_members, offices, office_terms (future), elections (future), bills (future), cases (future)`.
