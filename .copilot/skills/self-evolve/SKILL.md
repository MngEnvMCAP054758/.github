---
name: self-evolve
description: "End-of-session self-improvement. Automatically updates lessons-learned.md, examples, instructions, and skills based on what happened in the current session. Run at the end of every session or when Ahmed says 'learn from this'."
---

# Self-Evolution Engine

## When to Run
- End of every session (before Ahmed leaves)
- When Ahmed says "learn from this" or "remember this"
- After any rejection ("this is shit", "fix it", "not good enough")
- After any successful delivery that Ahmed approved

## Step 1: Rejection Mining
Scan the current conversation for rejection signals:
- "this is shit" / "not good" / "fix it" / "redo" / "no" / "wrong"
- Identify WHAT was rejected and WHY
- Append to `~/.copilot/lessons-learned.md` under the right category:
  ```
  ## [Category]
  - [Date]: [What went wrong] — [Why it was rejected] — [What fixed it]
  ```

## Step 2: Success Capture
Scan for approval signals:
- "perfect" / "great" / "that's it" / "deploy" (after seeing output) / "send it"
- Save the successful deliverable pattern to `~/.copilot/examples/`:
  - Code pattern → `examples/code-patterns/`
  - PPT design → `examples/ppt-design/`
  - Doc template → `examples/doc-templates/`
  - Email → `examples/doc-templates/`

## Step 3: New Project Detection
Check if any new directories were created or new repos cloned:
- Look at session file changes for paths outside known projects
- If a new project root is detected:
  1. Create `~/.copilot/profiles/<project-name>.json`
  2. Create `.github/copilot-instructions.md` in the project
  3. Update `~/.copilot/copilot-instructions.md` with project context

## Step 4: Skill Refinement
Check if any skill was used and had issues:
- If a deploy failed → update `skills/deploy-personalai/SKILL.md` with the fix
- If a VM command needed different params → update `skills/vm-execute/SKILL.md`
- If a new workflow was performed manually → consider creating a new skill for it

## Step 5: Instructions Evolution
Check if Ahmed gave new standing orders this session:
- "always do X" / "never do Y" / "from now on"
- Append to `~/.copilot/copilot-instructions.md` in the appropriate section
- New one-word commands → add to One-Word Commands section
- New quality rules → add to Quality Standards section

## Step 6: Agent Tuning
If an agent was used and its output was rejected:
- Read the agent's .agent.md
- Identify what instruction was missing that caused the failure
- Add the missing rule to the agent file

## Output Format
After running self-evolution:
```
🧬 Self-Evolution Report
📝 Lessons added: [count] new entries
📚 Examples saved: [count] patterns captured
🔧 Skills updated: [list of refined skills]
📋 Instructions: [changes made]
🤖 Agents: [agents tuned]
🆕 New: [new projects/profiles/skills detected]
```
