---
name: kid-activity
description: Generate age-appropriate activities, projects, learning games, rainy-day plans, and screen-light ideas for specific kids, for a parent to run or supervise. Use when someone says "something to do with the kids", "rainy day", "science project", "activity for a 5 and 8 year old", or "homework help plan".
---

# Kid Activity

## Purpose
Give parents a ready-to-run idea matched to the kids' ages, interests, energy, and available stuff. This skill is for the *parent* using the agent. If a child is talking to the agent directly, use `kid-mode/KID-AGENT.md`.

## Autonomy
A0/A1. Produces ideas and plans only.

## Context to load
- `context/members/<child>.md` (interests, reading level, what works)
- `context/household.md`, `context/food.md` (for cooking activities and allergies)
- Weather, time available, and materials on hand (ask)

## Steps
1. Ask (or infer): time available, location (indoor/outdoor), energy (wild or calm), mess tolerance, which kids, materials at home. Offer defaults.
2. Offer 3 ideas: one *together* (works for both ages with roles for each), one *independent* (parent gets 20 minutes), one *out-of-the-house* if relevant.
3. For each: materials from around the house, setup time, run time, parent role, how to scale up for the older child and down for the younger, and the skill it builds (without lecturing).
4. Add safety notes where needed (small parts for the 5-year-old, heat, scissors, water, supervision level).
5. For homework help: coach the parent on prompts that help the child think ("What do you notice?") instead of supplying answers. Offer a 10-minute plan with a timer and breaks.
6. For cooking projects: run the `dietary-checker` lens.

## Output contract
```
**Idea 1: Cardboard marble run (together, 45 min)**
Materials: boxes, tape, scissors, marbles (supervise 5yo: choking hazard, use ping-pong balls)
Setup 5 min · Parent role: cut, then step back
8yo: design the path and test slopes · 5yo: decorate, drop balls, count
Builds: planning, cause and effect
```
Keep each idea to under 10 lines.

## Guardrails
- Prefer active, creative, offline, and social ideas. Offer screen-based ones only if asked, with a time cap.
- No names, photos, or personal details of children are requested or stored for this skill.
- Don't make medical or developmental claims. If a parent has a concern about development, suggest the pediatrician or the school.

## Done when
There are three runnable ideas with materials the family likely has, and a clear role for each age.
