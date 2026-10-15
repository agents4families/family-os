# Grok: Workspaces, Skills, Automations, and Grok Bot

**Best consumer fit for:** fast, current-web and X research (local events, product comparisons, what's happening this weekend), scheduled automations that don't need a premium tier, and cheap experiments with standing agents.
**Not for:** anything involving your children, anything Tier 2, or unattended access to accounts with money.

*Confidence: Workspaces, Skills, Automations, and Connectors come from a mix of guide sites and xAI-adjacent write-ups (some contradict each other on limits). **Grok Bot** facts come from a third-party tracker with internal date inconsistencies; xAI's own pages were not checked. Treat every number below as "verify in the app."*

## Mapping

| Family OS concept | Grok feature | Notes |
|---|---|---|
| `AGENTS.md` | **Custom Instructions** (global) and **Workspace instructions** | Reported limit: 12,000 characters, but it was cut to 4,000 for a month in March 2026 before being restored. **Keep the global text ≤ 4,000 characters** (`shared/constitution-4000.txt`) so another cut doesn't break it. Edits apply only to new chats. |
| `context/` | **Workspace files** (attached to a specific Workspace) | Workspace instructions override global ones. Limits on file number/size weren't stated; test with 5-8 bundles. |
| Skills | **Skills** (custom, created from a description, an example, or written instructions) | Closest thing to `SKILL.md`. Paste each skill's body in. |
| Roles | **Custom agents** (up to 4 reported) | Chief of Staff, Planner, Reviewer, Admin (read-only). |
| Scheduled routines | **Automations** (one-time, daily, weekday, weekly, monthly, yearly; free on all accounts), **email-triggered Automations** (SuperGrok) | Use **Run now** and run history to test. |
| Live data | **Connectors**: Google Workspace (Gmail, Drive, Docs, Sheets, Calendar), Outlook, OneDrive, Notion, GitHub, Linear, custom MCP | Start read-only, one connector at a time. |
| Autonomy ladder | **Grok Bot** approvals | Standing agents report they ask for approval; details of control granularity weren't documented. |
| State | `FamilyOS Log` / `Tasks` via Google connector (see `shared/state-bridge.md`) | |

## Optimization 1: Publish, don't expose

Compile a **Tier 0-1 bundle** for Grok and attach only that:

```bash
bash scripts/compile-consumer.sh chief          # default max tier = 1
```

Skipped files (food, money rules, anything Tier 2) are listed so you can see what Grok never gets. If you need dietary checks in Grok, state the hard rules in a single line in the Workspace instructions yourself ("one adult is gluten-free; verify labels") rather than attaching `food.md` (which holds allergy details).

## Optimization 2: One Workspace, four agents

- **Workspace "Family OS"**: constitution + bundles.
- **Agent 1, Chief of Staff:** default agent, routines and drafts.
- **Agent 2, Planner:** meals, events, trips; research-heavy; sources and dates required.
- **Agent 3, Reviewer:** runs lenses on plans. Instruction: "You are skeptical, short, and specific. Run only the lens named."
- **Agent 4, Admin (read-only):** inbox digest, subscription review. Connectors read-only. Cannot draft messages.

## Optimization 3: Port skills

For each skill you use, tell Grok: *"Create a Skill named [name] from these instructions"* and paste the skill body from `skills/<name>/SKILL.md` minus the Autonomy and Context sections (replace "Context to load" with "Use the attached Workspace files"). Start with 5: morning-brief, weekly-summit, meal-plan, inbox-triage, event-prep. Test each against `harness/evals/golden-tests.md`.

## Optimization 4: Automations (starter set)

Prepend `shared/injection-shield.txt` to any that read mail.

| Name | Schedule | Prompt (short) | Connectors |
|---|---|---|---|
| Morning brief | Weekdays 6:30 | "Using my calendar, write today's brief: events, who drives, conflicts, prep, weather impact, at most one decision. Under 150 words. Lead with problems." | Calendar (read) |
| Sunday prep | Weekly Sun 3:00pm | "Draft next week's plan from my calendar: day by day, conflicts, prep, a dinner plan that respects our dietary rule, top 3 for the week. Draft only." | Calendar (read) |
| Bill reminder | Monthly day 1 | "List recurring bills and subscriptions due this month from the Doc 'Subscriptions' and remind me which need a decision." | Docs (read) |
| School triage | Email-triggered (SuperGrok) | "On new email from [school domain], extract deadlines, forms, costs, and what to bring. Draft a one-line reply. Take no other action." | Gmail (read), **sender filter on** |

**Careful with email-triggered automations.** They run whenever an outsider's email arrives, so they are the highest injection-exposure setup in this folder. Restrict the sender filter to the school's real domain, give the automation read-only access, and send its output only to you.

## Optimization 5: Grok Bot (standing agents)

> **Superseded.** Grok Bot now has its own guide, based on xAI's documentation: `../grokbot/README.md`. The notes below predate it and come from a third-party tracker.

Reported: agents on their own cloud computer that sign into existing sites (even without APIs), work continuously, and message you when they need approval. Included with SuperGrok-level plans (reported ~$30/month for base SuperGrok; beta; plans changed several times in August 2026).

Use it only for **errands on low-stakes sites with separate accounts**: price tracking, event ticket alerts, restaurant availability, comparing quotes.

Do **not** use it for: bank, health, school portals with child records, anything where you would have to hand over a real credential. This conflicts with the "never give credentials to an agent" rule. If it needs a login, create a dedicated account with a unique password, no saved payment method, and no 2FA recovery pointing to your main email.

## Privacy checklist (do before connecting anything)

- [ ] Settings → data controls: turn off training/personalization on your data if offered. Note that X privacy settings may not cover other Grok surfaces; check Grok's own controls.
- [ ] Review memory: view, delete items, clear all. Memory is inferred from chats; don't tell it Tier 2 facts.
- [ ] Connectors read-only; remove anything unused.
- [ ] Log choices in `harness/connected-tools.md`.

## Where Grok should not go

Kid-facing use. xAI has faced public criticism over content moderation and companion personas, and there is no child-safety mode that I could verify. Keep children on the supervised Kid Helper in a tool with documented child protections.
