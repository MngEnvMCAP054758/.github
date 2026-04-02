---
name: deploy-personalai
description: "One-word deployment for PersonalAI Agent. Deploys to Azure App Service, waits, health checks, tests key endpoints, reports results."
---

# Deploy PersonalAI Agent

## Trigger
Ahmed says "deploy" — this skill activates automatically.

## Steps
1. Navigate to `C:\Users\v-amera\AppData\Local\Temp\personalai-deploy`
2. Run `.\deploy.ps1`
3. Wait for deployment to complete (watch for "Deployment successful" or poll app status)
4. Test health: `curl https://personalai-agent.azurewebsites.net/health`
5. Test chat endpoint: `curl -X POST https://personalai-agent.azurewebsites.net/api/chat -H "Content-Type: application/json" -d '{"message":"test"}'`
6. Test PPT upload endpoint availability: `curl https://personalai-agent.azurewebsites.net/api/ppt/upload`
7. Report results:
   ```
   ✅ Deployed to personalai-agent.azurewebsites.net
   /health: 200 OK (145ms)
   /api/chat: 200 OK (890ms)
   /api/ppt/upload: 200 OK (120ms)
   ```
8. If any endpoint fails: auto-restart App Service, retest, then report

## On Failure
- Check deployment logs: `az webapp log tail --name personalai-agent --resource-group rg-ai-app`
- If deploy.ps1 fails: check for syntax errors, missing files, credential issues
- Retry deployment up to 2 times before reporting failure
