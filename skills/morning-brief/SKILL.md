---
name: morning-brief
description: A 60-second brief of today for the family: schedule, conflicts, who drives, prep needed, weather impact, one decision. Use when someone says "what's today", "morning brief", "brief me", or when run on a weekday schedule.
---

# Morning Brief

## Purpose
Start the day knowing what matters, who is doing what, and what could go wrong. Short enough to read standing in the kitchen.

## Autonomy
A0 for reading. A1 for drafting. Safe to run on a schedule.

## Context to load
- `context/routines.md`, `context/calendar-rules.md`
- Live: family calendar for today and tomorrow, weather, `harness/state/tasks.json` (due today or overdue)
- If no calendar is connected: ask for a paste or a screenshot description.

## Steps
1. Get today's date and weekday from the system.
2. Pull today's events and tomorrow's first event. Add recurring items from `routines.md` the calendar may lack.
3. Detect problems: overlaps, two places at once, no one assigned to pickup, a tight transition under the buffer rule, weather that changes plans.
4. Assign owners using the rhythm in `routines.md` and `charter.md`. Mark `UNASSIGNED` where none.
5. Check prep: forms due, items to bring, meals needed, gifts, charging gear. Look for "tomorrow needs X tonight."
6. Pick at most one decision that can't wait ("Confirm Saturday sitter by noon").

## Output contract
Under 200 words. Save to `outputs/briefs/YYYY-MM-DD-morning.md` only if run on a schedule.

```
**Thu Oct 15 · 54°F, rain after 3**
⚠ Conflict: Soccer 4:30 (Parent A) overlaps dentist 4:15 (kid 2). Pickup UNASSIGNED.
Today
- 8:10 Dropoff: Parent A
- 3:15 Pickup, Lincoln: UNASSIGNED
- 6:00 Dinner: tacos (kids' choice)
Bring/prep: Permission slip (due today), cleats in the car, rain jackets
Decide today: Who covers 3:15? Suggest Grandma (free per last text), I'll draft the ask.
Tomorrow: 7:45 early start, library books due.
```

## Guardrails
- Lead with problems. If there are none, say "Clean day" and stop.
- Don't list every event; list what changes behavior.
- Don't send messages. Offer drafts.

## Done when
The conflicts, unassigned items, and prep list are each either empty or named with an owner.
