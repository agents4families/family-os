---
name: index
updated: 2026-10-14
review_by: 2027-01-14
sensitivity: 0
---
# Context Map

Read this first. Load only the files a task needs. One line per file tells you when it matters.

| File | Load when | Sensitivity |
|---|---|---|
| `household.md` | Almost always. Who lives here, timezone, home base, key facts. Keep short. | 1 |
| `charter.md` | Decisions, conflicts, anything values-based. Who decides what. | 0 |
| `routines.md` | Planning any day or week. School/work rhythm, pickups, bedtimes, recurring commitments. | 1 |
| `calendar-rules.md` | Scheduling, accepting invites, finding time. | 0 |
| `food.md` | Meals, groceries, restaurants, parties. Dietary constraints live here. | 2 |
| `home.md` | Maintenance, repairs, vendors, smart home, anything about the house. | 1 |
| `money-rules.md` | Any spend, bill, subscription, or budget talk. Rules and thresholds only, no account numbers. | 2 |
| `contacts.md` | Anyone external: school, doctors, sitters, neighbors, vendors, relatives. | 1 |
| `voice.md` | Writing anything as a family member. Tone by audience. | 0 |
| `members/<name>.md` | Tasks about one person: preferences, sizes, schedules, interests. | 1-2 |
| `members/<name>/private/` | Only when that member is the active user and asked. | 2 |
| `vault-pointer.md` | Needing to know where a document lives (never the contents). | 1 |
| `decisions/` | Before re-deciding something. One file per decision, searchable by name. | 0-1 |
| `../harness/connected-tools.md` | Before using any live data source. | 1 |
| `../harness/autonomy-ladder.md` | Before taking any action beyond drafting. | 0 |
| `../kid-mode/KID-AGENT.md` | A child is talking to the agent. | 0 |

## Loading rules

- Start small: `household.md` + the one or two files in the table that match the task.
- If you need a decision history, list `decisions/` filenames first and open only the relevant one.
- If a file's `review_by` date has passed, use it, mention it, offer a refresh.
- New context files must be added here, with a "Load when" line, or they will never be found.

## Context budget

Target under 2,500 words total for the always-loaded set (`household.md`, `charter.md` summary line, this index). If it grows past that, move detail into an on-demand file and leave a pointer.
