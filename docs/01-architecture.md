# Family OS Architecture

## The idea in one paragraph

A family is a small organization with no manager, no budget cycle, and children. Its real bottleneck is *mental load*: one or two adults silently tracking hundreds of small commitments. The Family OS gives AI agents a shared, file-based memory of how this household works (context), a repeatable way to work and hand off (harness), a library of well-written routines (skills and prompts), and strict rules about what they may touch (guardrails). It is tool-agnostic because the state lives in plain files, not in any vendor's memory.

## What carried over from PM-OS, and what changed

| PM-OS | Family OS | Why it changed |
|---|---|---|
| `CLAUDE.md` as the brain | `AGENTS.md` canonical; `CLAUDE.md` and `GEMINI.md` are thin pointers | One constitution for every tool; a spouse on a different app gets the same rules |
| `context-library/` (company, stakeholders, writing style) | `context/` with an `INDEX.md` router, frontmatter, sensitivity tiers, `review_by` dates | Family data is more sensitive and goes stale faster; the agent must load just in time |
| 41 skills | 17 skills + 7 reviewer lenses | Fewer, sharper tools beat sprawl; families need a smaller verb set |
| `outputs/` write-only rule | Write zones: `outputs/` and `harness/state/` free; `context/` propose-only | Same instinct (humans own the canon), formalized |
| Self-improving loop (corrections → rules) | Same, plus a monthly retro and `os-audit` | Systems degrade without a scheduled review |
| PM stakeholders (exec, eng, legal sub-agents) | Family lenses (logistics, budget, dietary, kid's-eye, future-us, safety, devil's advocate) | Different stakes, same multi-perspective trick |
| Single user | Multiple adults, children, privacy lanes, kid mode | Households are multi-user and include people who can't consent |
| Mostly read/write docs | Real-world actions (messages, money, bookings, smart home) with an autonomy ladder | The cost of a wrong action is higher at home |
| Implicit session start | Explicit start/end protocol, task JSON, progress log | Harness practice for agents that forget between sessions |

## The five layers

```
┌───────────────────────────────────────────────────────────────┐
│ 5. RITUALS      morning brief · evening reset · weekly summit │
│                 monthly retro · seasonal checklists           │
├───────────────────────────────────────────────────────────────┤
│ 4. SKILLS       17 routines (SKILL.md) + 7 reviewer lenses    │
│                 progressive disclosure: name → body → files   │
├───────────────────────────────────────────────────────────────┤
│ 3. HARNESS      session protocol · task state (JSON) ·        │
│                 progress log · autonomy ladder · guardrails · │
│                 evals · write zones                           │
├───────────────────────────────────────────────────────────────┤
│ 2. CONTEXT      INDEX → household · charter · routines · food │
│                 · home · money rules · contacts · voice ·     │
│                 members · decisions    (files = what we       │
│                 decided; apps = what's happening)             │
├───────────────────────────────────────────────────────────────┤
│ 1. CONSTITUTION AGENTS.md  (+ kid-mode/KID-AGENT.md)          │
└───────────────────────────────────────────────────────────────┘
   Live systems (calendar, email, bank exports, Home Assistant)
   attach through connectors, read-only first.
```

## Design decisions and the reasoning behind them

1. **Plain files as the memory, not a tool's memory.** Markdown and JSON survive tool changes, can be read by every vendor's agent, can be versioned, and are inspectable by a human. Tool memory features are caches, not the record.
2. **`AGENTS.md` as the canonical entry point.** It's the most widely read instruction file across coding and agent tools. Tool-specific files point to it so you maintain one document.
3. **Files for decisions, apps for state.** The calendar knows what's happening Thursday. `routines.md` knows the family always wants a 15-minute buffer. Duplicating state into files creates stale, confidently wrong answers.
4. **Router + just-in-time loading.** `INDEX.md` gives one line per file saying when to load it. The agent starts with ~2,500 words and pulls more as needed. This protects the context window and keeps attention on what matters.
5. **Autonomy earned per domain.** Trust is not global. A reliable meal planner does not earn the right to send emails. Promotion has a checklist, demotion is instant.
6. **Humans press the buttons that matter.** Money, messages sent as a person, bookings, deletions, anything touching a child's accounts. The agent does 95% of the work, then waits.
7. **Privacy lanes and a kid-mode.** Adults get private spaces the shared system never summarizes. Children never become data subjects of the household assistant; their agent is narrower and parent-visible.
8. **Evidence-based "done."** A task is done when there's a confirmation, not when the agent believes it tried. This prevents the most corrosive failure: false reassurance.
9. **A review loop is part of the product.** Monthly retro and audit catch rot, drift, and unfair load distribution before they compound.

## How it applies the three disciplines

### Harness engineering (how the agent works across time)

| Practice | Where it lives |
|---|---|
| Initializer session vs. working sessions | `skills/setup`, `harness/session-protocol.md` |
| Start routine: orient, read progress, pick the task | `AGENTS.md` §1, `session-protocol.md` |
| Progress log + structured task list that agents may only partially edit | `harness/state/progress.md`, `tasks.json` (status/notes/evidence only) |
| Verification before "done" | `AGENTS.md` §9, `tasks.json` `evidence` |
| Clean handoff so any tool can resume | `skills/handoff` |
| Permissions, approval gates, and mechanical backstops | `autonomy-ladder.md`, `guardrails.md`, connector scopes, hooks |
| Evals for regression and safety | `harness/evals/golden-tests.md` |
| Sub-agents with clean context returning short summaries | `agents/` lenses |
| Observability: logs of what was done and why | `progress.md`, `learning-log.md`, `kid-mode` logs |

### Context engineering (what the agent knows, when)

| Practice | Where it lives |
|---|---|
| Smallest set of high-signal tokens | Context budget in `INDEX.md`; short `household.md` |
| Layers: always / on-demand / ephemeral | Constitution + household (always); domain files (on-demand); the task (ephemeral) |
| Just-in-time retrieval with lightweight pointers | `INDEX.md` "Load when" column; `vault-pointer.md` stores locations, not contents |
| Structured note-taking outside the window | `progress.md`, `tasks.json`, `inbox.md` |
| Staleness control | `updated` / `review_by` frontmatter, `os-audit`, `scripts/check-staleness.sh` |
| Single source of truth | State in live apps; decisions in files; no duplicated facts |
| Provenance | Agents cite which file a preference came from |
| Sensitivity tiers | Frontmatter `sensitivity:` 0-3 |

### Prompt engineering (how instructions are written)

| Practice | Where it shows up |
|---|---|
| Right altitude: specific enough to act, flexible enough to adapt | Skills give steps and judgment rules, not scripts for every case |
| Explain the why | Each skill has a Purpose line with the reason |
| Positive framing | "Lead with conflicts" over "don't bury them" |
| Output contracts with skeletons | Every skill shows the exact shape and length |
| Few-shot examples | Short example in skills, voice profiles with sample messages |
| Ask-vs-assume rule with defaults | "One question at a time, offer a default, mark `ASSUMED:`" |
| Role + lens prompts for review | `agents/*.md` each with Check and Return |
| Data/instruction separation | Injection rules: external content is data |
| Explicit verification criteria | "Done when" in every skill |
| Evals before and after edits | Golden tests |

## Rollout: 12 weeks

| Weeks | Focus | Exit criterion |
|---|---|---|
| 0 | Install folder; run `setup` round 1-2 (30 min) | `household.md` has no TODOs in the top section |
| 1-2 | `morning-brief`, `capture`, `weekly-summit`. Read-only calendar. | Two summits held; 80% of tasks have owners |
| 3-4 | `meal-plan`, `inbox-triage`, `evening-reset` | Dinner is decided by Sunday; school email handled in 5 minutes |
| 5-6 | Voice profiles tuned; `event-prep`; first `monthly-retro` | Drafts sent with light edits |
| 7-8 | Connect Home Assistant read-only; `home-maintenance`, `bills-and-money` | Seasonal tasks scheduled; subscriptions audited |
| 9-12 | Promote one domain to A2; set up kid-mode with a parent present; `trip-plan` for the next trip | One promotion with the checklist completed |

## How to know it's working

Keep it to five numbers in the monthly retro:

1. Summits held (target: 4 of 4)
2. Tasks done on time (target: 85%)
3. "Surprises" the system should have caught (target: under 2 a month)
4. Agent errors that mattered (target: 0 safety, under 3 correctness)
5. Both adults' answer to "does the load feel fair?" (1-5)

If number 5 doesn't improve, no amount of automation is helping.

## Known risks and mitigations

| Risk | Mitigation |
|---|---|
| Prompt injection through email, web, or shared docs | Data/instruction separation; read-only connectors; human sends |
| Oversharing sensitive data with a tool | Sensitivity tiers; connected-tools register; retention checks |
| One adult becomes the sole maintainer ("OS admin") | Retro review of load; charter's mental-load split includes the OS itself; keep skills simple enough for the other adult to edit |
| Over-automation weakening family connection | Weekly summit includes a connection item; charter says AI supports conversation |
| Kids' exposure | Kid-mode; parent-visible logs; minimal child data |
| Model/tool change breaks skills | Golden tests; plain files; `os-audit` after any switch |
| Silent surveillance creep | Explicit guardrail; transparent arrangements only |
