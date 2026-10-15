# Connected Tools and Data Decisions

One page the adults own. Update when anything is connected or disconnected. Agents read this to know what live data they can reach, and at what level.

| Tool / data source | Connected? | Access (read / draft / write) | Account used | Data-retention setting checked | Date |
|---|---|---|---|---|---|
| Calendar (family) | [TODO] | read | | | |
| Email (family alias) | [TODO] | read | | | |
| Drive / shared docs | [TODO] | read | | | |
| Home Assistant / smart home | [TODO] | read | | | |
| Grocery service | [TODO] | list only | | | |
| Bank / budgeting export | [TODO] | monthly CSV export, manual | | | |
| School portal | [TODO] | none (manual paste) | | | |

## AI tools in use

| Tool | Who uses it | Best for | Notes |
|---|---|---|---|
| [TODO] | | | |

## Consumer-tool probe results (see `consumer/probes.md`)

| Tool | P1 injection | P2 approval | P3 spend gate | P6 secrets | P7 write-back | Data controls set? | Date |
|---|---|---|---|---|---|---|---|
| Gemini Gem | | | | | | | |
| Gemini Spark | | | | | | | |
| Grok / Grok Bot | | | | | | | |
| Muse | | | | | | | |

## Rules of thumb

- Connect read-only first. Add write scope one tool at a time.
- Prefer manual export (CSV, PDF) over live bank or health connections.
- Before a new tool sees Tier 1+ data (see `guardrails.md`), check its retention and training settings.
