---
name: cost-tracker
description: "Track Azure spending against the $2500/month budget. Alert at 60/80/95%."
---

# Cost Tracker

## Trigger
"how much are we spending", "cost report", "budget status"

## Protocol
1. Query Azure Cost Management:
   ```
   az consumption usage list --start-date (Get-Date -Day 1).ToString("yyyy-MM-dd") --end-date (Get-Date).ToString("yyyy-MM-dd") --query "[].{Resource:instanceName,Cost:pretaxCost,Currency:currency}" -o table
   ```
2. Sum by resource type
3. Compare against $2500 budget
4. Flag alerts:
   - 60% ($1500): "⚠️ Budget at 60% — on track"
   - 80% ($2000): "⚠️ Budget at 80% — consider deallocating idle VMs"
   - 95% ($2375): "🚨 Budget at 95% — stop non-essential resources"

## Recommendations
- Show which VMs are costing the most
- Identify idle resources (running but no activity)
- Suggest deallocate schedule
