---
name: cross-session-intel
description: "Detect patterns across sessions — recurring failures, trending topics, skill gaps, quality trends. The system's meta-brain that learns HOW Ahmed works over time."
---

# Cross-Session Intelligence

## Trigger
- During session-autobrief (lightweight check)
- When Ahmed says "what have I been working on" or "show me patterns"
- Weekly self-triggered review

## Analysis Dimensions

### 1. Failure Patterns
Query session_store for rejection signals across sessions:
- Count PPT rejections → if trending up, tighten ppt-quality agent rules
- Count deployment failures → if recurring, add pre-deploy checks
- Count "fix it" occurrences → identify which module causes most rework

Report: "PPT quality rejections: 3 this week (down from 7 last week) — gradient headers rule is working"

### 2. Project Focus Trends
Track which projects get the most session time:
```sql
SELECT content, COUNT(*) as mentions
FROM search_index
WHERE search_index MATCH 'personalai OR spo OR trading OR language OR ppt'
GROUP BY content ORDER BY mentions DESC;
```
Insight: "80% of your time this month is on PersonalAI, 15% SPO, 5% trading"

### 3. Workflow Efficiency
Detect repeated manual steps that should be automated:
- "You've manually transferred files from VM 12 times — the file-transfer skill should auto-trigger"
- "You've run deploy.ps1 then health check separately 8 times — one-word deploy is faster"

### 4. Knowledge Growth
Track how examples/ and lessons-learned.md grow:
- New entries this week: [count]
- Categories with most growth: [list]
- Gaps: "No examples saved for trading module yet"

### 5. Quality Trajectory
Track approval vs rejection rate over time:
- This week: 12 approvals, 3 rejections (80% acceptance)
- Last week: 8 approvals, 7 rejections (53% acceptance)
- Trend: ↑ improving — quality gate is working

## Output
```
🧠 Intelligence Report
━━━━━━━━━━━━━━━━━━━━━
📊 Focus: PersonalAI (80%), SPO (15%), Trading (5%)
📈 Quality: 80% acceptance rate (↑ from 53%)
🔄 Recurring: PPT text overlap (3x) — rule strengthened
💡 Suggestion: Create a skill for "test all endpoints" — you do it manually every deploy
📚 Knowledge: 12 new lessons this week, examples/ grew by 4 patterns
```
