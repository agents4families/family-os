---
name: os-audit
description: Audit the Family OS itself: stale context, bloat, contradictions, orphaned files, broken skill triggers, secrets that slipped in, and drift between docs and reality. Use monthly, after switching tools, when answers feel generic or wrong, or when someone says "audit the system" or "clean up".
---

# OS Audit

## Purpose
Context rots. Rules contradict each other. Skills drift. A short monthly audit keeps the system small, current, and safe, which keeps it effective.

## Autonomy
A0 for reading everything allowed. Proposes fixes; applies on approval.

## Context to load
- `context/INDEX.md` and every file's frontmatter (read the frontmatter only; open bodies selectively)
- `AGENTS.md`, `harness/*`, `skills/*/SKILL.md` (descriptions), `agents/*`
- Optional: `scripts/check-staleness.sh` output

## Steps
1. **Freshness:** list files past `review_by` or with more than 5 `[TODO]` markers. Sort by how often they're needed (`INDEX.md` order).
2. **Bloat:** word counts of the always-loaded set versus the 2,500-word budget. Identify text that could move to on-demand files.
3. **Contradictions:** compare overlapping facts (dietary rules in `food.md` vs `household.md`; thresholds in `money-rules.md` vs `charter.md`; routines vs calendar-rules). Quote both lines.
4. **Orphans:** context files missing from `INDEX.md`; INDEX entries pointing nowhere.
5. **Secrets scan:** search for patterns like long digit strings, "password", "pin:", "ssn", card-like numbers, API keys. Report file and line; never print the value.
6. **Skills:** each description still triggers on how the family actually talks? Any skill used zero times in 60 days (candidate to delete)? Any manual process repeated twice that deserves a skill?
7. **Autonomy:** compare current levels to the evidence in the last 30 days of logs. Flag any action taken above its level.
8. **Golden tests:** run the safety tests in `harness/evals/golden-tests.md`; report pass or fail.
9. **Tool drift:** has the family changed AI tools or connectors? Update `connected-tools.md`, `CLAUDE.md`, `GEMINI.md`.

## Output contract
`outputs/audits/YYYY-MM-audit.md`: findings by severity (Safety, Correctness, Hygiene), each with file, line, and a proposed fix as a diff. Finish with a three-item "do this first" list.

## Guardrails
- Secrets found: tell the adult where, recommend removal and rotating the credential if one was exposed. Don't re-echo it.
- Don't delete files. Propose archiving to `archive/`.

## Done when
Every finding has a proposed fix, the safety tests ran, and the adults know the top three actions.
