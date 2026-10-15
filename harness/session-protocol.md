# Session Protocol

The agent has no memory between sessions. The folder is the memory. This protocol, adapted from long-running-agent harness practice, makes every session pick up where the last one stopped, in any tool.

## Two kinds of session

**Initializer (once):** `setup` skill. Interviews the adults, fills `context/`, creates the first task list, logs the baseline. Different prompt, same harness.

**Working session (every other time):** does one coherent chunk of work, leaves the folder in a clean state.

## Start routine (the agent does this silently, then states its plan in one line)

1. Read `context/INDEX.md`.
2. Read the last 10 entries of `harness/state/progress.md`.
3. Read `harness/state/tasks.json`. List `open` items owned by the current user or `agent`.
4. Check `harness/state/inbox.md` for unprocessed captures.
5. Confirm today's date and day of week from the system (never guess). Note anything due within 48 hours.
6. Load only the context files the task needs.

## During

- One task at a time. Finish or park it before opening another.
- Use `tasks.json` for anything that takes more than one session or has an owner and a date. Agents may change only `status`, `updated`, `notes`, and `evidence`. Never delete or rewrite a task's `title`, `owner`, or `due`. Propose the change instead. (Structured JSON survives agent edits better than prose lists.)
- Park side-discoveries in `inbox.md` instead of chasing them.
- Long task or long chat? Write a checkpoint to `progress.md` before the context gets heavy. Don't depend on the tool's auto-summary.

## End routine (`handoff` skill)

Append to `harness/state/progress.md`:

```
## YYYY-MM-DD HH:MM · <tool> · <adult>
Did: <what changed, with file paths>
State: <what is now true>
Open: <what is waiting, on whom>
Next: <the single best first move for the next session>
Learned: <optional, one line>
```

Then update `tasks.json` statuses, empty processed items from `inbox.md`, and list any context-file edits you are proposing.

## Verification rule

A task's `status` becomes `done` only with `evidence`: a confirmation number, a calendar event ID or link, a sent-message note from the human, a photo of the signed form the adult mentions. No evidence, status stays `waiting`.

## Cross-tool handoff

Because state lives in files, a morning brief started in one tool can be finished in another. Never rely on a tool's built-in memory for anything the household needs to keep. If a tool has its own memory feature, treat it as a convenience cache, and write anything important to the folder.

## Recovery

If something looks wrong (a task marked done with no evidence, a context file that contradicts the calendar), stop, report the discrepancy, and ask. Use Drive/Git version history to roll back a bad edit.
