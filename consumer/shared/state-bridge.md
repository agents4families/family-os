# State Bridge: Memory for Tools That Can't Write to Your Folder

Consumer assistants usually can't edit local files. Without a place to write, they forget everything between sessions and `handoff` has nowhere to go. The fix is a pair of cloud files every tool can reach through its Google connector (or that you paste into).

## Create two files in the Drive folder (5 minutes)

1. **`FamilyOS Log`** (Google Doc). First lines:
   ```
   FamilyOS Log. Newest entry at the bottom. Format: date · tool · adult / Did / Open / Next
   ```
2. **`FamilyOS Tasks`** (Google Sheet). Import `tasks-template.csv`. Columns: id, title, owner, due, domain, status (open/waiting/done/dropped), notes, evidence, updated. Freeze the header row. Add data validation on `status`.

These two are the consumer-tool twins of `harness/state/progress.md` and `tasks.json`. If you use both Claude (folder) and Gemini/Grok (Docs), pick one as the truth: **the folder files are canonical.** Once a week, run `handoff` in the folder tool and ask it to reconcile: "Compare FamilyOS Tasks (paste) with tasks.json and list differences."

## Rules for agents

- Read the last 5 Log entries and all `open` and `waiting` tasks at the start of a planning session.
- Append only. Never rewrite earlier Log entries.
- In the Sheet, change only `status`, `notes`, `evidence`, `updated`. Add new rows at the bottom. Never delete rows.
- `done` needs `evidence` (confirmation number, event link, "Parent A sent it 10/14").

## Paste-in lines

**Start:** `Read the last 5 entries in FamilyOS Log and the open rows in FamilyOS Tasks. Then: [task].`

**End:** `Append an entry to FamilyOS Log (Did / Open / Next) and update FamilyOS Tasks. Don't mark anything done without evidence.`

## When a tool can't reach Docs/Sheets

Ask it for the entry as plain text, then paste it yourself. A 20-second habit beats a lost week.

## Sensitivity

Both files are Tier 1. Keep health, money figures, and children's details out. Share them only with the two adults.
