---
name: vm-execute
description: "Execute commands on Azure VMs via az vm run-command. Handles base64 encoding, 4096 char output limit, and error recovery automatically."
---

# VM Execute

## Trigger
Any task requiring command execution on an Azure VM.

## Protocol
1. Check VM is running: `az vm get-instance-view --name <vm> --resource-group <rg> --query "instanceView.statuses[1].displayStatus" -o tsv`
2. If VM is stopped: `az vm start --name <vm> --resource-group <rg>` and wait
3. Encode the PowerShell script to base64:
   ```powershell
   $script = '<your script here>'
   $bytes = [System.Text.Encoding]::Unicode.GetBytes($script)
   $b64 = [Convert]::ToBase64String($bytes)
   ```
4. Execute: `az vm run-command invoke --command-id RunPowerShellScript --name <vm> --resource-group <rg> --scripts "powershell -EncodedCommand $b64"`
5. Parse output from JSON response: `.value[0].message`
6. If output > 4096 chars: split the query into multiple calls

## Known VMs
- vm-spo-assess: rg-spo-assessment (user: azadmin)

## Error Handling
- "VMAgentStatusCommunicationError": VM agent not ready, wait 30s and retry
- "Timeout": increase timeout or break script into smaller parts
- Empty output: check script syntax, ensure Write-Output is used (not Write-Host)
