---
name: session-journal
description: "Automatically maintain a running journal of session insights, decisions, and outcomes. Feeds into self-evolution."
---

# Session Journal

## Purpose
Every session generates knowledge. This skill captures it so nothing is lost.

## Auto-Capture (happens throughout session, not just at end)

### Decisions Made
When Ahmed makes a design/architecture/approach decision:
- Log: `[timestamp] DECISION: [what] — [why] — [context]`
- Save to `~/.copilot/files/session-journal.md`

### Errors Encountered
When something fails during the session:
- Log: `[timestamp] ERROR: [what failed] — [root cause] — [fix applied]`
- If the fix is reusable → create/update a skill

### New Patterns Discovered
When a new workflow or technique is used:
- Log: `[timestamp] PATTERN: [description] — [when to reuse]`
- If it's a multi-step workflow → consider creating a new skill

### Ahmed's Reactions
Track emotional signals for quality calibration:
- "perfect", "great", "that's it" → mark approach as GOOD
- "no", "fix it", "this is shit" → mark approach as BAD + log why
- This builds a taste profile over time

## Journal Format
```
# Session Journal — [date]
## Session: [topic/project]

### Decisions
- [decision entries]

### Errors & Fixes
- [error entries]

### Patterns
- [pattern entries]

### Quality Signals
- ✅ [what was approved]
- ❌ [what was rejected + why]

### New Knowledge
- [anything learned that should persist]
```

## End-of-Session
When session ends or Ahmed leaves:
1. Compile journal entries
2. Feed into self-evolve skill
3. Archive journal to `~/.copilot/files/journals/[date].md`
