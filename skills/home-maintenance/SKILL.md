---
name: home-maintenance
description: Generate and track seasonal home maintenance, warranty and filter reminders, vendor calls, and repair triage. Use when someone says "home maintenance", "what should we do around the house this season", "something's broken", "furnace filter", or "get ready for winter".
---

# Home Maintenance

## Purpose
Houses punish forgetting. Spread small seasonal tasks across the year so nothing becomes an expensive emergency.

## Autonomy
A1 for planning and vendor drafts. Smart-home changes at A2 only for lights, scenes, and thermostat within approved range. Locks, garage, alarm, and cameras stay A1 forever.

## Context to load
- `context/home.md` (assets, vendors, smart home)
- `context/routines.md` (seasonal anchors), `context/money-rules.md`
- `outputs/home/maintenance-log.md`

## Steps
1. Identify the season and region from `household.md`. Generate the seasonal checklist from the asset list (HVAC service and filters, gutters, smoke/CO detectors, dryer vent, water heater flush, sump pump, exterior sealing, winterizing hoses, sprinklers, roof/attic check, appliance cleaning).
2. Compare with the log: what's overdue, what's due within 30 days. Keep to 3-5 tasks per month.
3. Triage by type: **Safety** (do now), **Prevents damage** (this month), **Efficiency/comfort** (this season), **Nice to have** (backlog).
4. For repairs: ask symptom, location, when it started, anything urgent (water, smell of gas, sparking). **For gas smell, sparks, active flooding, or smoke, say: leave the area and call emergency services or the utility emergency line first.** Then help with vendor choice.
5. Draft vendor requests from `contacts.md` with specifics and a request for a written quote. Provide questions to ask on the call.
6. Propose DIY vs pro with a rough cost range (`ESTIMATE:`) and time.
7. Update tasks with owners and add log entries when completed (human confirms).

## Output contract
`outputs/home/YYYY-season-checklist.md`: a table of task, why, owner, target month, DIY/pro, estimated cost, status. A running `maintenance-log.md` (date, task, who, notes, next due).

## Guardrails
- Never advise bypassing safety devices or doing gas, major electrical, or structural work yourself.
- Quotes and warranty terms come from documents the adult provides; don't assume coverage.

## Done when
This month's tasks have owners and dates, any safety item is first in line, and the log matches what was actually done.
