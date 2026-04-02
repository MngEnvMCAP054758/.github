---
name: session-pickup
description: "Instantly resume work from a previous session. Reads session history, loads last checkpoint, shows context summary. Triggered when Ahmed says 'continue the X session' or 'remember our last conversation about Y'."
---

# Session Pickup

## Trigger
- "continue the session about X"
- "remember our last conversation"
- "where were we with X"
- "resume the Y thing"

## Protocol
1. Search session_store database for relevant sessions:
   ```sql
   SELECT s.id, s.summary, s.created_at
   FROM sessions s
   JOIN turns t ON t.session_id = s.id AND t.turn_index = 0
   WHERE s.summary LIKE '%keyword%' OR t.user_message LIKE '%keyword%'
   ORDER BY s.created_at DESC LIMIT 5;
   ```

2. Load the latest checkpoint for that session:
   ```sql
   SELECT title, overview, work_done, next_steps
   FROM checkpoints
   WHERE session_id = '<id>'
   ORDER BY checkpoint_number DESC LIMIT 1;
   ```

3. Present instant context:
   ```
   📂 Resuming: [session summary]
   Last time: [1-line overview of what was done]
   Next step: [what was planned next]
   Ready to continue.
   ```

4. Don't wait for confirmation — if Ahmed said "continue", start the next step immediately.

## Key Rule
This should take < 10 seconds. No 5-minute ramp-up. Ahmed expects instant context recovery.
