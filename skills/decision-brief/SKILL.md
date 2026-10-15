---
name: decision-brief
description: Structure a significant family decision (big purchase, school choice, move, car, childcare, major trip, job change impact) into a 1-2 page brief with options, tradeoffs, lenses, a recommendation, and what would change it. Use when someone says "should we", "help us decide", "compare options", or "we keep going back and forth".
---

# Decision Brief

## Purpose
Big family decisions stall because they mix facts, feelings, and money in one conversation. Separate them, make the tradeoffs visible, and give two adults a fair shared document to react to.

## Autonomy
A1. Advises, never decides. Plan Mode recommended where available.

## Context to load
- `context/charter.md` (values, decision rights), `context/money-rules.md`, `context/household.md`
- `context/decisions/` (related past decisions)
- Research as needed (web search for current facts; cite sources and dates)

## Steps
1. **Frame the decision** in one sentence. What exactly is being decided, by when, and who decides (per charter)?
2. **Ask up to three clarifying questions**, each with a default. Skip if the person has already supplied the context.
3. **Gather facts** (costs, timelines, constraints). Mark `ESTIMATE:` and `ASSUMED:`. Verify current facts rather than recalling them.
4. **Options table:** at least three options, including "do nothing" and a creative middle path. For each: upfront and ongoing cost, time, reversibility, and effect on each family member.
5. **Run the lenses** (`agents/`): `budget-hawk`, `kids-eye-view`, `future-us`, `logistics-checker`, `devils-advocate`, plus `safety-reviewer` if relevant. Summarize each in one or two lines. Note conflicts between lenses.
6. **Separate values from facts.** List the two or three value questions only the adults can answer ("How much do we weigh time versus money?"). Don't answer them.
7. **Recommendation:** pick one and say why, with a confidence level and "what would change my mind."
8. **Next step:** the smallest reversible move (a visit, a trial, a quote), with owner and date.
9. After the adults decide, offer to write the entry for `context/decisions/`.

## Output contract
Saved to `outputs/decisions/YYYY-MM-DD-name.md`, max two pages:
```
Decision · By when · Who decides
Options table
Lens summary (conflicts flagged)
Values questions for you two
Recommendation (confidence) · Would change if …
Smallest next step · Sources
```

## Guardrails
- Present each adult's likely perspective fairly. Don't simulate what a spouse "would say" as fact; say "a concern your partner might raise."
- No false precision. A range with its assumptions beats a single confident number.
- For medical, legal, and tax pieces, state what a professional should confirm.

## Done when
Options are comparable on the same dimensions, the values questions are separated out, and the next step has an owner.
