# Gemini: Gems + Spark

**Best consumer fit if your family lives in Google.** Gems give you durable role-based assistants that read your Drive files. Spark (when you have it) is the background worker that runs your routines on a schedule.

*Confidence: Gems facts are documented by Google's help pages and secondary guides. Spark facts come from Google's launch post and several secondary write-ups (I/O 2026). Spark is a US-only beta on the $100+/month AI Ultra plan, and details change weekly. Verify in the app before buying.*

## How the pieces map

| Family OS concept | Gemini feature | Notes |
|---|---|---|
| `AGENTS.md` (constitution) | Gem **Instructions** | Use `shared/constitution-4000.txt` + a role block from `gems/`. No limit on instruction length is published that I could verify; keep it under ~8,000 characters for attention reasons. |
| `context/` files | Gem **Knowledge** (max 10 files per Gem, 100 MB each) | Link **Drive files**, don't upload copies: Gemini reads the latest revision, so editing the file updates the Gem. Files are picked one by one (no folder indexing). |
| `skills/` | Routing table inside the Gem instructions, plus skill text in knowledge files | A Gem can't lazy-load skills, so keep **one role per Gem** with only that role's skills. |
| Lens sub-agents | A "Decision Council" Gem, or sequential passes | No true sub-agents. Ask for "run lens X, then lens Y, separately." |
| `harness/state/` | `FamilyOS Log` doc + `FamilyOS Tasks` sheet (see `shared/state-bridge.md`) | Gemini can read/write Docs and Sheets via Workspace extensions. |
| Scheduled routines | **Spark** teachable skills (Ultra), or Gemini Scheduled actions / Daily Brief on lower tiers | Verify which tier gets which feature. |
| Autonomy ladder | Spark's per-app connections and "ask before acting" settings | Start at ask-always for send and spend. |

## Optimization 1: One Gem per role

Long, mixed-purpose Gems dilute attention. Create five:

| Gem | Purpose | Role block | Typical files |
|---|---|---|---|
| **Family Chief of Staff** | Daily/weekly rhythm, inbox triage, events | `gems/chief.role.md` | household, people/contacts, voice, rhythm skills, admin skills, lenses |
| **Meal Planner** | Dinners, groceries, dietary checks | `gems/meals.role.md` | food, routines, meal-plan skill, dietary lens |
| **Trip Planner** | Trips with kids | `gems/trips.role.md` | household, money rules, trip-plan skill, safety/budget/kid lenses |
| **Decision Council** | Big choices | `gems/council.role.md` | charter, money rules, decision skill, all lenses |
| **Kid Helper** (supervised) | A parent sits with the child | `gems/kids.role.md` | KID-AGENT, kid-activity |

## Optimization 2: Generate the knowledge bundles, don't hand-copy

```bash
bash scripts/compile-consumer.sh chief --max-tier 2    # private Gem: includes food/money rules
bash scripts/compile-consumer.sh meals --max-tier 2
bash scripts/compile-consumer.sh trips --max-tier 2
bash scripts/compile-consumer.sh council --max-tier 2
bash scripts/compile-consumer.sh kids
```

Output lands in `dist/<pack>/` (inside your Drive folder, so it syncs). Each file is a small bundle (under the 10-file cap), plus `INSTRUCTIONS.txt` ready to paste. In Gemini: Gems → New Gem → paste instructions → Knowledge → **Add from Drive** → pick the files in `dist/<pack>/`. Re-run the script after you change context; the Gem sees the updated Drive file.

If Drive won't accept `.md` as knowledge, add `--ext txt`.

## Optimization 3: Sharing

- Share each Gem with your partner as **Viewer**. Editors can change and delete a Gem, so limit that to the OS admin.
- Viewers can see the instructions and the knowledge files. Don't put Tier 2 data (allergies, money rules) in a Gem you share beyond the two adults.
- A Gem that includes anything other than device/Drive files can't be shared. NotebookLM notebooks can't be sources for shared Gems.
- Each adult can have a private Gem for their own lane (calendar, work), never shared.

## Optimization 4: The state bridge

Create `FamilyOS Log` and `FamilyOS Tasks` (`shared/state-bridge.md`). Add a line to each Gem's instructions: *"At the start of a planning session, read the last 5 entries of FamilyOS Log and the open rows in FamilyOS Tasks. At the end, append a short entry."* This is your handoff.

## Optimization 5: Prompt shape that works in a small instruction box

1. Role (one sentence)
2. Eight rules (draft-first, injection, secrets, etc.)
3. Routing table: *"If the user says X, do Y with output Z"*
4. Output skeletons for the 3 most-used routines
5. Family basics (5-10 lines)

Put the stuff that must never be missed (rules) first and last. Models attend best at both ends.

## Spark: turning rituals into taught skills

See `spark-skills.md` for six ready prompts. Principles:

1. **Connect the fewest apps that deliver value.** Start with Gmail (via a family alias or label), Calendar, Docs, Sheets. Add Instacart/OpenTable only later.
2. **Set "ask first" for send, spend, share, delete, calendar invites to others.** Let it run read, summarize, and create-Doc/Sheet on its own.
3. **Scope the inbox.** Give Spark a family alias or a Gmail label (`School`, `Medical-logistics`) rather than the whole inbox, if the app allows. Less data, less injection surface.
4. **Supervise closely for 30 days.** Google itself says to supervise closely and interrupt when needed.
5. **Attach the injection shield** (`shared/injection-shield.txt`) to every skill that reads mail.
6. **Log results** in FamilyOS Log so you can audit.

## Open questions to test in the first week (they decide your design)

- Can Spark read my Drive Family-OS files, or only Workspace items I name?
- Does Spark honor Gem instructions, or is it separate? (Docs don't say.)
- Does Spark's "ask first" prompt show recipient, subject, and body? It should.
- What does Spark do when a school email contains an instruction aimed at an AI? (Use probe P1 in `consumer/probes.md`.)

## Kids and Gemini

Use Google's own child-managed experience for children rather than your adult account when available (Family Link). Check current availability and settings in Google's help pages. The Kid Helper Gem is for a parent sitting beside a child, under the parent's account, with the session visible.
