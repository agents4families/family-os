---
name: handoff
description: Close a working session cleanly: log progress, update task statuses with evidence, clear the inbox, and list proposed context changes, so the next session in any tool starts warm. Use at the end of any session, when context is getting long, or when someone says "wrap up", "handoff", "save progress", or "continue later".
---

# Handoff

## Purpose
The agent forgets everything between sessions; the folder doesn't. This skill turns a conversation into durable state so the next session (maybe in a different tool) loses nothing.

## Autonomy
A2 for `harness/state/` and `outputs/`. Proposes, never applies, changes to `context/`.

## Context to load
- `harness/session-protocol.md`, `harness/state/progress.md`, `tasks.json`, `inbox.md`

## Steps
1. Summarize what happened in this session: files created or changed (paths), decisions made, things sent or booked (by humans), and anything that failed.
2. Update `tasks.json`: set `status`, `notes`, `updated`; set `done` only with `evidence`, otherwise `waiting`. Never edit `title`, `owner`, or `due`; list proposed edits separately.
3. Add new tasks discovered along the way.
4. Process `inbox.md`: remove items handled, leave the rest.
5. List **proposed context diffs** (facts learned, corrections, new preferences) as exact before/after lines, and ask for approval. Apply only the approved ones.
6. Append an entry to `progress.md` (Did, State, Open, Next, Learned).
7. If a correction repeated this session, add a line to `learning-log.md` and propose a rule.

## Output contract
Appended to `progress.md`:
```
## 2026-10-14 17:40 · claude-desktop · Parent A
Did: Planned week of Oct 19 (outputs/weekly/2026-W43-plan.md); drafted teacher reply (not sent).
State: Plan accepted by both adults; meal plan Mon-Thu done, Fri open.
Open: Permission slip (Parent A, due Fri) · Sitter for Sat (waiting on the sitter's reply)
Next: Finish Friday dinner, then inbox-triage the school folder.
Learned: Thursdays need 20-minute dinners (proposed for routines.md).
```

## Guardrails
- Be literal. If something wasn't confirmed, write "unconfirmed."
- Don't paste sensitive content into the log. Reference files instead.

## Done when
A fresh agent could read `progress.md` and `tasks.json` and know exactly what to do next.
