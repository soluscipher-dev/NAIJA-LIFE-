# 03 - Game Economy

Version 1.0 | Currency: Naira (N), integer only. All values below are STARTING numbers for tuning, stored in `config_parameters`, never hardcoded.

## 1. Principles
1. Money is created only by defined faucets and destroyed only by defined sinks.
2. Player-to-player payments move money; they never create it.
3. Wealth is uncapped (ADR-0005). Control inflation with sinks and tuning.
4. Every faucet and sink is measured weekly.

## 2. Accounts (ledger)
- Player wallet (cash), player bank (savings, bonds as sub-accounts).
- System accounts: `SYSTEM_MINT` (source of all faucets), `SYSTEM_BURN` (target of sinks), `SYSTEM_TAX`, `SYSTEM_ESCROW`, `SYSTEM_BANK_RESERVE`.
- Organization accounts (companies, later government).

## 3. Faucets (money in)
| Faucet | Source | Notes |
|---|---|---|
| Starter grant | MINT | One time (for example N50,000) |
| Job pay | MINT (NPC jobs) / business account (player jobs) | Per shift by level |
| Daily reward | MINT | Small, streak-capped |
| Event rewards | MINT | Budgeted per event |
| Bank interest / bond payout | BANK_RESERVE | Funded by fees; capped |
| Investment returns | MINT | Weekly, tuned |
| Hustle pay | Player to player | Not a faucet |

## 4. Sinks (money out)
| Sink | Target | Notes |
|---|---|---|
| Rent | BURN or landlord | NPC rent burns, player landlord rent transfers |
| Weekly bills / utilities | BURN | |
| Income tax | TAX | Light; free threshold, then low rates |
| Shop purchases | BURN or business | |
| Luxury and status items | BURN | Mansions, supercars, jets, yachts, clubs |
| Business licenses and upkeep | BURN | |
| Billboards / ads | BURN | |
| Large-transfer fee for new accounts | BURN | |
| Donations to city projects | TAX/city fund | Public recognition |

## 5. Starting parameter set (tunable)
| Parameter | Start value |
|---|---|
| Starter grant | N50,000 |
| Entry job pay per shift | N2,000 - N4,000 |
| Mid-career pay per shift | N15,000 - N40,000 |
| Executive pay per shift | N100,000+ |
| Room rent / week | N10,000 |
| Flat rent / week | N60,000 |
| Mansion rent / week | N1,500,000 |
| Tax free per week | N1,000,000 |
| Tax rates | 0% to threshold, 10% next band, 20% above (admin-tunable) |
| Savings interest / week | 0.25% (cap per account per week) |
| New-account transfer limit | N100,000 per day for first 3 days |

Numbers must scale so a new player can afford first rent within about 2-3 sessions and a mid-game player has meaningful luxury goals.

## 6. Inflation controls
- Watch money supply, average wealth, and Gini weekly.
- If supply grows faster than sinks: raise luxury prices, add sinks, reduce faucet rates for NEW content (avoid nerfing existing players abruptly).
- Never print money to fix a shortage; change prices.

## 7. Anti-abuse economics
- New-account transfer limits and cooldowns.
- Detect funneling (many accounts -> one), loops (A->B->A), and farming (identical shifts at impossible rates).
- Hustle: price floors/ceilings per category, ratio checks between poster and worker (same device/IP flags).

## 8. Leaderboards
True ranks. Net worth = wallet + bank + savings + bonds + asset value at sell price. Flag abnormal jumps for review; do not cap.

## 9. Economy dashboard (admin)
Money supply, faucets vs sinks (daily and weekly), top earners, top spenders, Gini, active wallets, transfer volume, flagged accounts.

## 10. Change management
Every parameter change is logged with who, when, old value, new value, reason. Large changes require ECONOMY_ADMIN plus second approval.

## 11. Open tuning items
Pricing of luxury tiers, bond yields, investment risk model, business tax schedule, government budget flow (V3+).
