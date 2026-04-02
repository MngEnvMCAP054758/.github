---
name: morning-report
description: "Generate a morning status report covering all running services, VMs, training jobs, costs, and pending tasks. Use when Ahmed says 'how things' after being away."
---

# Morning Report

## Trigger
- "how things?" (after being away)
- "morning status"
- "what happened overnight"

## Report Generation
1. Check PersonalAI App Service health:
   `curl -s -o /dev/null -w "%{http_code}" https://personalai-agent.azurewebsites.net/health`

2. Check all known VMs:
   `az vm list -d --query "[].{Name:name, Status:powerState, RG:resourceGroup}" -o table`

3. Check any running training/batch jobs (look for progress files):
   `Get-Content ~/Downloads/overnight_progress.txt -ErrorAction SilentlyContinue`

4. Check Azure costs (current billing period):
   `az consumption usage list --top 10 --query "[].{Resource:instanceName, Cost:pretaxCost}" -o table`

5. Present in standard format:
```
🌅 Morning Report — [time since last activity]
✅ Completed: [tasks/phases done]
⏳ In Progress: [running tasks + progress]
❌ Failed: [failures + what was tried]
📊 Cost: $X.XX since last check
🔜 Next: [what's ready + decisions needed]
```

## Key Rule
6 lines max. Numbers, not paragraphs. Ahmed will ask to "go deeper" if he wants details.
