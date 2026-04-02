---
name: deadline-tracker
description: "Track deadlines and milestones mentioned in conversations. Proactively remind when dates approach. Triggered by date mentions or 'what's coming up'."
---

# Deadline Tracker

## Auto-Detect
Scan every conversation for date references:
- Explicit: "April 6th meeting", "by Friday", "next week"
- Relative: "in 3 days", "by end of month", "tomorrow"
- Implicit: "before the meeting", "when Joseph needs it"

## Storage
Append detected deadlines to `~/.copilot/files/deadlines.md`:
```
# Active Deadlines

## [date] — [description]
- Project: [which project]
- Contact: [who's involved]
- Deliverables: [what needs to be ready]
- Status: [not started / in progress / ready]
- Added: [when detected]
```

## Proactive Reminders
During session-autobrief, check deadlines:
- **> 7 days away**: mention in brief, no urgency
- **3-7 days away**: "⚠️ [deadline] in [N] days — [status]"
- **< 3 days away**: "🚨 [deadline] in [N] days! [what's not ready]"
- **Overdue**: "❌ [deadline] was [N] days ago — [what's pending]"

## Current Known Deadlines
- April 6, 2026 — SPO Assessment meeting with Joseph Vasil
  - Deliverables: scripts, CSVs, PBI report, documentation, demo video
  - Status: ready (all items completed)

## Quick Check
When Ahmed asks "what's coming up" or "any deadlines":
```
📅 Upcoming
━━━━━━━━━━
🟢 Apr 6 — SPO Assessment meeting (Joseph) — READY
[other deadlines...]
```
