---
name: meal-plan
description: Plan the week's dinners (and optional lunches) around real schedules, dietary rules, and budget, then produce a deduped, store-sorted grocery list. Use when someone says "meal plan", "what's for dinner this week", "grocery list", or "plan meals".
---

# Meal Plan

## Purpose
Remove the 5pm "what's for dinner?" scramble and keep food safe for everyone, including the person with dietary restrictions.

## Autonomy
A1. Adding to a shared list may be A2 if approved. Never checks out.

## Context to load
- `context/food.md` (hard constraints, favorites, equipment, staples)
- `context/routines.md` (time per night), the week's calendar
- `context/money-rules.md` (grocery target)
- `outputs/meal-plans/` (last 3 plans, to avoid repeats)

## Steps
1. For each night, set a **time budget** from the calendar (late practice means 20 minutes or slow-cooker).
2. Pick meals: roughly 60% from the favorites rotation, at most one new recipe, one leftover or flex night. No protein twice in a row.
3. **Run the `dietary-checker` lens** on every meal and every ingredient, including sauces, broths, spice blends, and cross-contact. Show the result: ✓ or the swap.
4. Make kid versions where needed (deconstructed plate, sauce on the side).
5. Build the grocery list: consolidate quantities, subtract pantry staples, group by store section and by store if the family uses more than one.
6. Estimate cost as `ESTIMATE:` and compare to the weekly target.
7. Add a prep plan: what to chop/cook ahead on which day.

## Output contract
Saved to `outputs/meal-plans/YYYY-Www.md`:
```
| Day | Dinner | Time | Check | Notes |
Mon | Tacos (corn tortillas) | 25m | ✓ GF | kid: plain chicken
…
Grocery list (by section)
Produce: …   Protein: …   Pantry: …   Dairy: …
ESTIMATE: $128 vs $140 target
Prep: Sunday, cook rice + marinate chicken
```

## Guardrails
- Allergy and gluten rules are absolute. If a label can't be verified, say "check the label" instead of "safe."
- Don't invent store inventory or prices. Use user-provided prices, or label estimates.
- Ask about "strict" versus "preference" for restrictions if `food.md` doesn't say.

## Done when
Every dinner has a time, a dietary check result, and ingredients on the list; the list is deduped and grouped.
