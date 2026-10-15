---
name: event-prep
description: Build a countdown checklist and logistics plan for any event: birthday party, school event, appointment, holiday gathering, guests visiting, sports tournament. Use when someone says "prep for", "we're hosting", "birthday party", "planning for the recital", or "what do we need for".
---

# Event Prep

## Purpose
Events fail on forgotten small things, not big ones. Work backwards from the event and give every item an owner and a date.

## Autonomy
A1. Calendar holds and reminders at A2 if approved. Never sends invitations or pays vendors alone.

## Context to load
- `context/household.md`, `context/food.md`, `context/calendar-rules.md`, `context/contacts.md`
- Live: calendar around the event date
- Past events: `outputs/events/` (what we learned last time)

## Steps
1. Ask the minimum: what, when, where, how many people, budget, who's in charge, kids involved. Offer defaults for the rest.
2. Check the calendar around the event for conflicts and buffers.
3. Generate a **backward timeline** (T-14, T-7, T-3, T-1, day-of, after) with tasks tied to owners.
4. Cover the standard bases: invitations/RSVPs, venue/space, food and drinks (run `dietary-checker` for guests' needs), supplies, decorations, gift/favors, schedule of the day, kids' needs (naps, snacks, quiet space), transportation, weather plan B, cleanup, thank-yous.
5. For hosting: guest-count math (food quantities, seating), allergies, parking, bathroom flow, music/activities, a 15-minute reset before arrival.
6. Budget with an `ESTIMATE:` per line and a total against `money-rules.md` thresholds. Over the threshold means both adults approve.
7. Draft any invitations, reminders, and vendor emails in the right voice.

## Output contract
Saved to `outputs/events/YYYY-MM-DD-name.md`:
```
# Maya's 6th birthday, Sat Nov 7, 2-4pm, home
Headcount: 12 kids + 14 adults · Budget ESTIMATE $220 (limit $250)
Timeline
T-14 Send invites (Parent A) · T-7 Order cake, GF option (partner) · …
Day-of schedule: 1:30 setup · 2:00 arrivals · 2:30 activity · 3:00 cake …
Dietary: 1 GF adult, 1 nut allergy (kid) → nut-free cake; check labels
Plan B (rain): garage + living room
Open decisions (2)
```

## Guardrails
- Never share kids' names, address, or schedule beyond the invite audience the adults chose.
- Keep safety items visible: allergens, supervision ratios, pool/fire hazards.

## Done when
Every item has an owner and date, the calendar holds exist (or are drafted), and open decisions are listed for the adults.
