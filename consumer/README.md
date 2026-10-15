# Consumer Tools Layer: Gemini (Gems + Spark), Grok (+ Grok Bot), Muse

The core Family OS assumes a tool that can open a folder and run skills. Consumer assistants mostly can't. This layer adapts the OS to what they *can* do.

*Researched October 14, 2026. These products change monthly, and several sources are secondary or competitive. Every capability claim carries a confidence note in its tool README, and `probes.md` tells you how to test it yourself.*

## Three constraints that shape everything here

1. **No folder access (mostly).** They can't read `context/` or write `progress.md`. → Compile bundles to Drive; use a Doc and a Sheet as the state bridge.
2. **Small instruction slots.** → Three constitution sizes (1,500 / 4,000 / ~8,000 characters), one role per Gem.
3. **They act, with your accounts.** Spark, Grok Bot, and Muse run on their own cloud machines and can email, book, and buy. → Injection shield, scoped inboxes, approval rules, and tiers of data you let each one see.

## Five principles

| Principle | In practice |
|---|---|
| **Compile, don't copy** | `scripts/compile-consumer.sh` builds the bundles from the master files. Edit once; regenerate. |
| **Publish, don't expose** | Tools only see compiled bundles filtered by sensitivity tier (default ≤1). Gemini private Gems may get tier 2; Grok and Muse never do. |
| **Drive is the bus** | Gemini reads linked Drive files at their latest version; Grok and Spark reach Docs and Sheets via Google connectors; the folder lives in Drive already. |
| **One role per surface** | Five focused Gems beat one giant one. Four Grok agents. Muse for errands only. |
| **Probe before you trust** | `probes.md`: 12 tests, 30 minutes per tool. Failing P1, P2, P3, or P6 means no email, calendar, or money access. |

## At a glance

| | Gemini Gems | Gemini Spark | Grok (Workspaces, Skills, Automations) | Grok Bot | Muse |
|---|---|---|---|---|---|
| **What it is** | Saved role-based assistants | 24/7 agent on Google Cloud, teachable skills | Chat app with instructions, files, scheduled automations | Standing agents on a cloud computer that sign into sites | Personal agent that acts in connected accounts |
| **Instructions / memory** | Instructions + up to 10 knowledge files (100 MB each) | Taught skills persist | Global ≤12k chars (keep ≤4k), Workspace override, memory (viewable/deletable) | Not documented | No documented custom instructions; memory (control disputed) |
| **Reads your files** | Drive files, latest version | Workspace apps | Workspace files; Google/Outlook/Notion connectors | Whatever it can sign into | Connected accounts; Mac app reaches local files |
| **Scheduled work** | No (use Spark or Scheduled actions) | Yes: recurring and trigger-based | Yes: automations; email-triggered on SuperGrok | Yes: works continuously | Yes: goals run in cloud |
| **Writes back** | Via Docs/Sheets extension | Docs, Sheets, Calendar | Via Google connectors | By acting on sites | Not integrated |
| **Approval model** | n/a (chat) | Asks before spending/sending (configurable) | Ask-to-act in connector use; automation run history | Approval requests; enterprise audit controls | Per-action approvals; Sentinel monitor |
| **Money** | Prepare only | Cart prep via Instacart; asks before spending | n/a | Unknown | One-time cards via Link by Stripe |
| **Price signal** | Included with Gemini plans | Reported: AI Ultra $100/mo, US beta | Free automations; SuperGrok for email triggers | Reported: ~$30/mo SuperGrok+ | Free (card required), $20, $100 |
| **Kid-safe?** | Parent-supervised Gem only | No | No | No | No (18+) |
| **Privacy posture** | Google account protections; check Gemini data controls | Same; connected-service sharing as needed | Check Grok-specific data controls; X settings may not cover it | Credentials risk | Training opt-in reported; memory off not possible (disputed) |
| **Confidence in my facts** | Medium-high | Medium | Medium | Low-medium | Low-medium |

## Division of labor (recommended)

| Job | Best tool | Why |
|---|---|---|
| System of record, weekly summit, skills, evals, maintenance | **Claude (folder)** or any folder-capable agent | Real files, handoff, hooks |
| Daily rhythm if your family is in Google | **Gemini Spark** (Ultra) or Gems + Daily Brief (lower tiers) | Calendar/Gmail/Docs native, runs while you sleep |
| Meals, trips, decisions on demand | **Gemini Gems** | Linked Drive knowledge, shareable with a partner |
| Research: events, products, quotes | **Grok** | Fast current-web and X search |
| Cheap scheduled nudges | **Grok Automations** | Free scheduling |
| Reservations, tickets, small purchases | **Muse** | One-time cards, booking connectors |
| Kids | **Parent-supervised Kid Helper** in a tool with documented child protections | `kid-mode/KID-AGENT.md` |

Tier rule: Tier 2 data (allergies, money rules, medical logistics) lives in the folder tool and in *private* Gems. It never goes to Grok, Grok Bot, or Muse.

## Autonomy ladder mapping

| Ladder | Gems | Spark | Grok / Bot | Muse |
|---|---|---|---|---|
| A0 Observe | ✓ | Read connectors | Read connectors | n/a |
| A1 Draft | ✓ | Drafts, Docs, digests | Drafts, digests | Plans/proposals |
| A2 Reversible acts | n/a | Add rows, create Docs, tentative holds | Add rows via connector | Calendar holds |
| A3 Act with approval | n/a | Send/spend with "ask first" on | Bot with approval prompts | Per-action approval (must show who/what/when/how much) |
| A4 Standing order | n/a | Only after a clean month, in writing | Not recommended | Not recommended |

## 6-week rollout

| Week | Do |
|---|---|
| 1 | Create `FamilyOS Log` + `Tasks` (state bridge). Compile and create the **Chief of Staff** Gem. Run `probes.md` P4-P7 on it. |
| 2 | Add **Meal Planner** Gem. Weekly summit using the Chief Gem. Start Spark Daily Brief (or Gemini Daily Brief). |
| 3 | School Digest on a label/alias, with P1 injection test first. |
| 4 | Grok: Workspace + 5 ported skills + morning/Sunday automations (Tier ≤1 only). |
| 5 | Decision Council and Trip Planner Gems. Share Gems with partner as Viewer. |
| 6 | Muse on one errand with a spending cap. Retro: what to keep, drop, promote. Update `connected-tools.md`. |

## Files in this folder

```
consumer/
├── README.md                You are here
├── probes.md                12 capability and safety probes
├── shared/                  constitution-1500.txt, constitution-4000.txt, injection-shield.txt,
│                            state-bridge.md, tasks-template.csv
├── gemini/                  README.md (Gems + Spark), spark-skills.md, gems/*.role.md
├── grok/                    README.md (Workspace, Skills, Automations, Grok Bot)
└── muse/                    README.md, primer.txt, goals.md
```

## Sources (research, Oct 14, 2026)

- Google: [The Gemini app becomes more agentic](https://blog.google/innovation-and-ai/products/gemini-app/next-evolution-gemini-app/); [Share a Gem](https://support.google.com/gemini/answer/16504957)
- Secondary: [DataCamp on Gemini Spark](https://www.datacamp.com/blog/gemini-spark); [Engadget](https://www.engadget.com/2176556/googles-gemini-spark-is-an-agentic-ai-assistant/); [Gems file limits (Fast.io)](https://fast.io/resources/gemini-gems-file-limit/)
- Meta: [Introducing Muse Spark](https://ai.meta.com/blog/introducing-muse-spark-msl/); [Muse Spark 1.1](https://ai.meta.com/blog/introducing-muse-spark-meta-model-api/); consumer-product details from a competitor's blog, [Carly on Meta Muse](https://www.usecarly.com/blog/meta-muse/) (treat privacy and reliability claims as unverified)
- Grok: [Grok Guide 2026](https://beevaults.com/grok-guide-2026/); [Custom instructions and Workspaces](https://www.uniflow.kr/en/grok-custom-instructions-setup-guide-workspaces-agents/); [Grok Projects and Build update](https://daily.dev/posts/grok-adds-team-projects-private-apps-and-wider-rollout-of-grok-build-zlbwox0fm); [Grok Bot timeline](https://keywordseverywhere.com/news/grok-updates/grok-bot/)
