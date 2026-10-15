---
name: bills-and-money
description: Monthly 30-minute money review from exports the adult provides: bills calendar, subscription audit, budget versus actual, upcoming big expenses. Use when someone says "monthly money review", "subscriptions", "are we on budget", "bills due", or pastes a statement export.
---

# Bills and Money

## Purpose
Know where the money went, catch what's creeping, and plan for what's coming, without giving an AI keys to the accounts.

## Autonomy
A0/A1. Read-only on exports the adult pastes or uploads. No logins, no payments, no cancellations. Money is a Red action class.

## Context to load
- `context/money-rules.md`
- `outputs/money/` (last month's review, subscriptions list)
- The adult's CSV or pasted summary for this month (remove account numbers before sharing)

## Steps
1. Ask for the export (CSV or pasted transactions). Remind them to strip account numbers. If a number appears anyway, don't repeat it.
2. Categorize transactions into the budget categories. List uncertain ones for the adult to label; remember their answers as proposed rules.
3. Compute actual versus target by category. Show the top three overages and top three savings, with the cause where visible.
4. **Subscriptions:** list recurring charges with amount, cadence, last used (ask), and a keep/cancel/downgrade suggestion. Flag new or increased charges.
5. **Bills calendar:** due dates next 45 days, autopay status, any that look unusual.
6. **Upcoming:** known big items (insurance renewals, annual fees, travel, birthdays, tax deadlines) from the calendar and `vault-pointer.md`.
7. **Two decisions max** for the adults, with the tradeoff.
8. Draft cancellation or negotiation messages when asked; humans send.

## Output contract
`outputs/money/YYYY-MM-review.md`: a one-page summary (table by category, subscriptions table, next-45-days bills, decisions needed). Maintain `outputs/money/subscriptions.md`.

## Guardrails
- Don't give investment, tax, or legal advice. Provide organized facts and questions for a professional. Note that you are not a financial advisor.
- Never store balances, account numbers, or card numbers in files. Round figures in summaries are fine; full ledgers stay in the finance tool.
- Don't judge spending. Report patterns and ask what matters.

## Done when
Categories reconcile to the export total, subscriptions are listed with a decision for each flagged item, and next month's bills are on the calendar as tasks.
