---
name: session-autobrief
description: "Proactive session start. The moment a new session begins, auto-detect context, show what happened since last session, and suggest next actions. Ahmed should NEVER have to ask 'where were we'."
---

# Session Auto-Brief

## Trigger
EVERY session start. This runs AUTOMATICALLY before Ahmed even types.

## Protocol

### 1. Detect Time Gap
Check session_store for the last session:
```sql
SELECT s.id, s.summary, s.updated_at,
       (julianday('now') - julianday(s.updated_at)) * 24 as hours_ago
FROM sessions s ORDER BY s.updated_at DESC LIMIT 1;
```

### 2. Branch by Gap Size

**< 1 hour (quick break):**
```
👋 Back. Still on [topic]. [1-line status].
```

**1-8 hours (work session gap):**
```
📋 [hours]h since last session ([topic])
Status: [where we left off]
Next: [what's ready to continue]
```

**8+ hours (overnight/sleep):**
Full morning report format:
```
🌅 [hours]h since you left
✅ Completed: [if overnight work ran]
📊 Systems: App [status], VMs [status]
💰 Cost: $X since last check
🔜 Ready: [pending items]
⏰ Upcoming: [deadlines within 7 days]
```

### 3. Context Preload
Based on the last session topic, preload:
- The relevant project profile from `~/.copilot/profiles/`
- Recent file changes from session_store
- Any pending todos from last session's checkpoint
- Relevant lessons from lessons-learned.md

### 4. Suggest, Don't Wait
After the brief, immediately suggest the most logical next action:
- "Continue the PPT pipeline?" (if that's where we left off)
- "The April 6th meeting is in 8 days — want to prep?" (if deadline is near)
- "3 new PPTs detected in training folder — run training?" (if knowledge-watcher finds new data)

## Key Principle
Ahmed starts 10 out of 13 sessions with "continue the session about X" or "remember our last conversation." This skill eliminates that step entirely. The system already knows.
