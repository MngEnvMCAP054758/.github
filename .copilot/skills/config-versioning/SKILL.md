---
name: config-versioning
description: "Version control for the Copilot CLI ecosystem itself. Track changes to instructions, agents, skills, and configs. Roll back if something breaks."
---

# Config Versioning

## Purpose
The ecosystem updates itself. But updates can break things. This skill keeps a changelog and enables rollback.

## On Every Config Change
When any file in `~/.copilot/` is modified by self-evolve, auto-learn, or manually:

1. Log the change:
   ```
   [date] [file] [action] [summary]
   2026-03-29 copilot-instructions.md APPEND "Added new one-word command: 'analyze'"
   2026-03-29 agents/ppt-quality.agent.md UPDATE "Added rule about gradient headers"
   2026-03-29 lessons-learned.md APPEND "PPT: don't use Comic Sans"
   ```
   Save to `~/.copilot/files/config-changelog.md`

2. Before destructive changes (DELETE, REWRITE), create backup:
   ```
   ~/.copilot/files/backups/[filename].[date].bak
   ```

## Rollback Protocol
If Ahmed says "that change broke things" or "revert the instructions":
1. Check `config-changelog.md` for recent changes
2. Present: "Last 3 changes: [list]. Which to revert?"
3. Restore from backup or undo the specific append

## Monthly Review
Every 30 days (or when prompted with "review the config"):
1. Check lessons-learned.md size — prune duplicates
2. Check copilot-instructions.md — remove outdated project refs
3. Check agent files — verify they still match actual project structure
4. Check skills — verify commands/paths still work
5. Report: "Config health: [stats]"

## Config Stats
Track and report on request:
```
📊 Ecosystem Stats
Instructions: 132 lines (last updated: [date])
Lessons: 50 entries (12 PPT, 8 code, 5 deploy, ...)
Agents: 6 active (last tuned: [date])
Skills: 14 active
Examples: 3 libraries ([count] patterns)
Sessions since last evolution: [count]
```
