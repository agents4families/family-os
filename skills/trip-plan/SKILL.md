---
name: trip-plan
description: Plan a family trip end to end: options, itinerary with kid-realistic pacing, bookings to make, packing, documents, and home-away tasks. Use when someone says "plan a trip", "vacation", "weekend away", "flights to", "road trip", or "what should we pack".
---

# Trip Plan

## Purpose
Family trips are logistics problems wearing a vacation costume. Plan for nap windows, meltdown thresholds, and dietary needs, then let the fun part happen.

## Autonomy
A1. Hold and compare; humans book and pay. Use Plan Mode where the tool has it.

## Context to load
- `context/household.md`, `context/food.md`, `context/calendar-rules.md`, `context/money-rules.md`
- `context/vault-pointer.md` (passport expiry dates), `context/home.md` (away-from-home tasks)
- Live: calendar (school breaks, conflicts), web search for current options; verify anything time-sensitive (prices, hours, entry rules, closures)

## Steps
1. **Frame it:** dates (flexible?), budget range, travelers, must-haves, hard no's, energy level ("restful" vs "adventure"). Max three questions, offer defaults.
2. **Passports and documents:** check expiry (six months past return is a common rule; verify for the destination), visas, kid travel consent letters if one parent travels alone.
3. **Options:** two or three destinations or structures with total cost ranges (`ESTIMATE:`), travel time door to door, and a one-line kid-fit note. Recommend one with the deciding reason.
4. **Itinerary:** one anchor activity per day, buffer time, nap/quiet windows, meal plan that works for dietary needs (look up GF-safe options in advance), rainy-day alternatives.
5. **Bookings sheet:** what to book, in what order (flights, lodging, cars, tickets with timed entry), cancellation terms, deadlines, and who books.
6. **Packing:** per-person list by trip type and weather; carry-on essentials for kids; medication and comfort items; chargers.
7. **Home plan:** mail, plants, pets, thermostat, lights, a trusted neighbor with a key, smart-home "away" mode (A1 only for locks and alarms).
8. **Tasks and reminders:** add dated tasks to `tasks.json` and propose calendar entries.

## Output contract
Saved to `outputs/trips/YYYY-MM-name/plan.md` plus `packing.md` and `bookings.md`:
```
# Trip: Smoky Mountains, Mar 21-28
Recommendation + why · Budget ESTIMATE $3.1-3.8k
Day plan · Bookings (deadline, owner, link, refundable?) · Packing · Home-away · Open questions
```

## Guardrails
- Every price, schedule, rule, and availability claim carries a source and a retrieval date, or is marked `ESTIMATE:`.
- Don't enter traveler documents or payment details into booking sites. Prepare, then hand off.
- Cancellation terms before price, always.

## Done when
There's a recommendation, a dated booking list with owners, and a packing list; the adults have approved the choice before any booking.
