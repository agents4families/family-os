@AGENTS.md

# Claude-specific notes

The shared rules above are the source of truth. This file only adds what is specific to Claude tools.

- **Skills:** `skills/` is canonical. Claude Code reads `.claude/skills/`; run `scripts/link-tools.sh` once to create it (symlink on Mac/Linux, copy as fallback).
- **Sub-agents:** the lenses in `agents/` can be registered in `.claude/agents/` (the link script does this). Spawn them for reviews so each runs in a clean context and returns only a short verdict.
- **Plan mode:** use it for `trip-plan`, `decision-brief`, and any task that touches more than one domain.
- **Connectors / MCP:** Calendar, Gmail, Drive, and Home Assistant are the useful ones. Start read-only. Add write access per `harness/autonomy-ladder.md` only after a month of clean drafts. Record what is connected in `harness/connected-tools.md`.
- **Scheduled tasks:** `morning-brief` (weekday mornings), `weekly-summit` prep (Sunday afternoon), and `os-audit` (first of the month) are good candidates. Scheduled runs are unattended, so they must stay at A1 (read and draft only) and write results to `outputs/`.
- **Desktop app, non-technical adult:** open the Family-OS folder as the working folder and say "run the weekly summit." No terminal required.
- **Hooks (optional, Claude Code):** a `PreToolUse` hook that blocks writes to `context/` without a confirmation is the cheapest safety net. Example in `harness/guardrails.md`.
