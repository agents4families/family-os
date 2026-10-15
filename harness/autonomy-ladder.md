# Autonomy Ladder

Agents earn trust per domain, the way a new babysitter or assistant does. Everything starts at A1. Promote a domain only after about four weeks of drafts the adults would have sent unchanged. Demote instantly after any mistake that mattered.

| Level | Name | The agent may | Example |
|---|---|---|---|
| A0 | Observe | Read and summarize. Nothing else. | "What's on the calendar Friday?" |
| A1 | Draft | Prepare anything. A human executes. | Draft the reply to the teacher. Build the cart. |
| A2 | Act, reversible | Make changes that are easy to undo, then report. | Add to grocery list. Tentative calendar hold. Set a reminder. |
| A3 | Act with approval | Execute external or irreversible actions after an explicit yes naming the action. | Send the email. Book the table. Pay the bill. |
| A4 | Standing order | Execute a pre-approved recurring action inside hard limits. | Reorder diapers/staples under $X when below threshold. |

## Action classes (what makes something risky)

Rate every action on **reversibility**, **who sees it**, and **money**.

- **Green:** private to the household, undoable in one step, no money. Allowed at A2.
- **Yellow:** visible to someone outside the household, or hard to undo. Needs A3 (human yes).
- **Red:** moves money, shares sensitive data, speaks for a human in a sensitive situation (school discipline, medical, legal, a conflict), or touches a child's accounts. Always a human, never above A1 for the agent.

## Per-domain settings

Edit this table. Agents read it before acting. Default column is the starting point; the "Now" column is what is actually approved.

| Domain | Default | Now | Notes |
|---|---|---|---|
| Calendar (read) | A0 | A0 | |
| Calendar (write) | A1 | A1 | Promote to A2 for "tentative" holds only. |
| Email/messages to others | A1 | A1 | Draft only. Human sends. |
| Grocery and shopping lists | A2 | A1 | Lists yes, checkout never above A1 until A4 rule exists. |
| Meal planning | A2 | A1 | |
| Reminders and tasks | A2 | A1 | |
| Bills and bank | A0 | A0 | Read-only exports. Never credentials. |
| Smart home (lights, climate) | A2 | A1 | Locks, garage, alarm, cameras: A1 only, forever. |
| School and medical admin | A1 | A1 | Draft, organize, prep questions. Never submit forms alone. |
| Travel booking | A1 | A1 | Hold and compare; human books. |
| Kid-facing chat | n/a | Supervised | `kid-mode/KID-AGENT.md`. Parent-visible logs. |

## Standing orders (A4)

None by default. Add one only in this format, so the limits are explicit and auditable:

```
STANDING ORDER: <name>
Trigger: <condition>
Action: <exact action>
Hard limits: <max $ per order, max per month, approved vendors>
Report: <where the agent logs each run>
Approved by: <adult>, <date>
Review: <date>
```

## Promotion checklist

- [ ] Four weeks at the current level with no material mistake
- [ ] The adults say they'd have approved the last ten actions unchanged
- [ ] The undo path for the new level is written down
- [ ] Both adults agreed (for money, sharing, or anything touching kids)
- [ ] Date set to review the promotion
