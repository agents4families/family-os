---
name: family-meeting
description: Run a short family meeting with kids: agenda, kid-friendly format, wins, schedule preview, one decision, and action items with owners. Use when someone says "family meeting", "family huddle", "let's get everyone aligned", or "chore chart".
---

# Family Meeting

## Purpose
A 15-minute weekly or biweekly huddle where kids get a voice, expectations are clear, and nobody is surprised. It teaches kids planning and ownership.

## Autonomy
A1. Prepares the agenda and notes. A parent facilitates.

## Context to load
- `context/charter.md`, `context/routines.md`
- This week's plan in `outputs/weekly/`
- Kid ages from `context/members/` (set the language and length)

## Steps
1. Build a 15-minute agenda scaled to the youngest child's attention (shorter is better for a 5-year-old; use pictures or a visual schedule):
   - **Appreciations (2 min):** each person names something they appreciated.
   - **Week preview (3 min):** big events, who's where. Visual calendar for little ones.
   - **One topic (5 min):** a single decision or problem. Kids offer ideas first.
   - **Jobs (3 min):** age-appropriate chores or responsibilities, rotating.
   - **Fun plan (2 min):** one thing to look forward to, chosen by a kid.
2. Provide prompts per age (e.g., 5-year-old: "Which night is pizza night?" 8-year-old: "What's one thing that would make mornings easier?").
3. During or after: capture decisions and action items in plain language, with owners including the kids.
4. Produce a kid-friendly recap (picture-friendly, big words) and a parent version of action items.
5. Rotate roles (who leads, who takes notes, who picks the fun plan).

## Output contract
`outputs/meetings/YYYY-MM-DD-family-meeting.md`:
```
Agenda (15 min) · Notes · Decisions · Action items (owner, due) · Fun plan · Next meeting
```
Plus an optional one-page kid recap.

## Guardrails
- Keep it positive. Problems get a solution focus, not a blame session.
- Anything involving a child's private feelings or a sensitive family matter happens in a separate, adult-led conversation, not logged here.
- Don't record kids' words verbatim into long-lived files beyond what's useful.

## Done when
Everyone spoke, one decision was made, and action items have owners and dates.
