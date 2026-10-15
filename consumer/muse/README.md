# Muse (Meta): The Errand Runner on a Leash

Muse is Meta's personal agent (launched September 2026; runs on Muse Spark). It works toward goals in your connected accounts, can book, buy, and fill out forms, and runs on its own cloud machine so it keeps working when your phone is closed.

*Confidence: **low to medium.** Most details below come from a competitor's blog that cites press reports; Meta disputes some of the privacy claims. Meta's own pages describe the model (Muse Spark) and the API but not the consumer product's memory or controls. Confirm every item in the app and Meta's help pages before connecting accounts.*

## What it's good for in a family

- **Errands with a built-in payment guardrail.** Reported: payments through Link by Stripe using one-time-use card numbers. That fits our "no standing card access" principle better than giving an agent a saved card.
- **Reservations and tickets** (OpenTable, Ticketmaster connectors reported).
- **Goal-style planning over time**: "get us ready for the school fair," "plan Maya's birthday for Nov 7."
- **A Mac app** that works with native Mail, Calendar, Notes, Messages, and files (reported).

## What it's not good for

- **Kids.** 18+ only.
- **Anything sensitive or hard to retract.** Reports say memory can't be turned off and users are opted into training by default. Meta disputes some of this, so check in settings. Until you've verified, assume it remembers whatever you tell it.
- **Unreviewed form submission or email.** It can send email and fill forms; you must keep the approval step meaningful (see below).

## How Muse maps to the Family OS

| Concept | Muse | Notes |
|---|---|---|
| Constitution | **No documented custom instructions or file upload.** | Seed memory with `muse/primer.txt` in the first chat, then verify by asking it to recite the rules. |
| Context files | Not available | Give it **only** what a task needs, in the chat. |
| Skills | Not available | Use **goal prompts** from `muse/goals.md`. |
| Scheduled routines | Goals that run in its cloud machine | Use for errands, not for your daily brief (use Gemini/Grok for that). |
| Autonomy | **Sentinel** monitoring agent: low-risk steps run automatically, high-risk actions ask approval | Approvals are per action. |
| State | Not integrated | You log outcomes in FamilyOS Log yourself. |

## Optimization 1: Connect the minimum, in this order

1. **Calendar:** the family calendar only.
2. **Gmail:** a **dedicated family alias** (the connector reportedly allows one account per provider, which makes an alias the natural choice). Not your primary inbox.
3. **OpenTable/Ticketmaster:** after two weeks of clean behavior.
4. **Do not connect:** Plaid (bank), Apple Health, Facebook/Instagram, iMessage, or Full Disk Access on the Mac. If you test the Mac app, give it a dedicated folder containing only `dist/` bundles.

## Optimization 2: Make approval meaningful

Per-action approvals fail if you tap "yes" without reading. Set a rule: **approve only when the prompt shows who, what, when, and how much.** If it doesn't, decline and ask for the exact action. Treat a Muse approval as our A3 "human yes." Anything that Muse can do but our ladder holds at A1 (school forms, medical admin, bills, locks) stays off its job list.

## Optimization 3: Spending control

- Fund Link with a low-limit card or a prepaid balance, or set a spending cap if offered.
- Per-goal budget in the prompt: "Spend at most $60. Stop and ask if over."
- Review one-time card activity weekly.

## Optimization 4: Batch the work

Because approvals are per action, batch with goals: "Plan Saturday's birthday: propose venue, time, and guest message; do nothing until I approve the plan." One review beats ten pings.

## Optimization 5: Privacy

- [ ] Opt out of training/personalization if the setting exists.
- [ ] Review memory; delete anything you didn't intend to store; use "forget this" when needed.
- [ ] Use Tier 0 facts only (preferences, general dietary rules). No kids' names, schools, addresses, health.
- [ ] Log what's connected in `harness/connected-tools.md`; re-check monthly, since reported behavior and permissions have changed in months.

## Personality note

You can rename it and give it an avatar. Keep it neutral; the Family OS stance is "capable assistant," not "companion."
