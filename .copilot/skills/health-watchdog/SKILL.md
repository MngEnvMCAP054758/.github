---
name: health-watchdog
description: "Monitor PersonalAI app health, VM status, and running jobs. Auto-restart on failure."
---

# Health Watchdog

## Trigger
"check health", "is everything running", or automatically after deployments.

## Checks
1. **PersonalAI App**: `curl https://personalai-agent.azurewebsites.net/health`
   - If 5xx: `az webapp restart --name personalai-agent --resource-group rg-ai-app`
   - Retest after 30s
2. **VMs**: `az vm list -d --query "[].{Name:name,Status:powerState}" -o table`
   - Flag any VM running > 24h that's not expected
3. **Costs**: Quick spend check against $2500 budget

## Report Format
```
🏥 Health Check
App Service: ✅ 200 OK (142ms)
vm-spo-assess: 💤 Deallocated
Trading VM: ⚡ Running (18h)
Budget: $847/$2500 (34%)
```
