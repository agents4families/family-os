---
name: setup
description: Interview the adults and fill in the household's context files so every other skill works. Use on first run, when household.md has [TODO] markers, or when someone says "set up", "onboard", "get started", or "update our family info".
---

# Setup (initializer session)

## Purpose
A family OS with empty context gives generic answers. This skill gathers the facts that matter most in short rounds, so the system is useful by the end of week one instead of perfect by never.

## Autonomy
A1. Proposes all file edits; applies them after a yes (first-run bulk approval is fine: "I'll fill these three files with what you've said. OK?").

## Context to load
- `context/INDEX.md`, `context/household.md`, `harness/connected-tools.md`
- Template files in `context/` as each round needs them

## Steps
1. Count `[TODO]` markers across `context/`. Report it ("42 gaps, I'll close the top 12 today").
2. Run rounds of at most 6 questions, one theme per round. Offer defaults and let them answer in fragments or by voice-dictation. Order:
   - **Round 1, People and week:** who lives here, ages, school/work rhythms, who does what mornings.
   - **Round 2, Constraints:** allergies and dietary rules, protected time, hard "never" rules.
   - **Round 3, Systems:** which calendar, email, notes, and list apps; what to connect read-only.
   - **Round 4, Money and home:** thresholds, bills cadence, house basics, vendors.
   - **Round 5, Voice and values:** 3 sample messages per adult, charter highlights, mental-load split.
3. After each round, show the exact edits to the relevant context file(s) and apply them on approval. Bump `updated` and set `review_by` three months out.
4. Never request or store Tier 3 data. If someone volunteers an account number or password, don't repeat it; say where it should live instead.
5. Offer to import existing material: Google Docs, notes, spreadsheets. Summarize and propose placement. Don't copy whole documents.
6. Set the autonomy table in `harness/autonomy-ladder.md` to the defaults, and confirm connected tools in `harness/connected-tools.md`.
7. Create the first week's tasks in `tasks.json`. Schedule the first `weekly-summit`.
8. Run `handoff`.

## Output contract
- Updated context files (with diffs shown).
- `outputs/setup/YYYY-MM-DD-setup-summary.md`: what was filled, what is still `[TODO]`, and the three highest-value next answers.

## Guardrails
- Keep sessions to 20-30 minutes. Stop at the end of a round, not mid-theme.
- Ask about children's details only to the extent they affect logistics.
- Record only what the person states. Don't infer health conditions, relationship dynamics, or finances.
- If the two adults answer differently, record both and flag it for the charter; don't pick.

## Done when
- `household.md`, `routines.md`, `food.md`, and `calendar-rules.md` have no `[TODO]` in their top sections.
- The adults have run one `morning-brief` and one `weekly-summit` successfully.
- `progress.md` has the setup entry.
