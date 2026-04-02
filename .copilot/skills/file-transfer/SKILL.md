---
name: file-transfer
description: "Transfer files between local machine and Azure VMs. Automatically routes by file size: base64 for small, chunked for medium, blob storage for large."
---

# File Transfer (Local ↔ Azure VM)

## Trigger
"download from vm", "upload to vm", "transfer file", or any task needing file movement between local and VM.

## Auto-Route by File Size

### Small Files (< 3KB)
Single base64 encode via run-command:
```powershell
# Read on VM
$content = [Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\path\to\file"))
Write-Output $content
```
Decode locally: `[Convert]::FromBase64String($b64) | Set-Content -Path $localPath -AsByteStream`

### Medium Files (3-14KB)
Chunked base64 reads (2700-byte chunks → ~3600 base64 chars per call to stay under 4096 limit):
```powershell
$bytes = [IO.File]::ReadAllBytes("C:\path\to\file")
$chunk = $bytes[$start..$end]
Write-Output ([Convert]::ToBase64String($chunk))
```
Reassemble chunks locally.

### Large Files (> 14KB)
Azure Blob Storage intermediary:
1. Upload from VM to blob using SAS token:
   ```powershell
   $headers = @{"x-ms-blob-type"="BlockBlob"}
   Invoke-RestMethod -Uri "$sasUrl" -Method PUT -InFile $filePath -Headers $headers
   ```
2. Download locally: `az storage blob download --account-name stspovid26b --container-name transfer --name $blobName --file $localPath --auth-mode login`
3. Clean up blob after transfer

## Storage Account Notes
- Account: stspovid26b
- Key auth is DISABLED — always use `--auth-mode login`
- Generate SAS: `az storage blob generate-sas --account-name stspovid26b --container-name transfer --name $blobName --permissions rw --expiry (Get-Date).AddHours(1).ToString("yyyy-MM-ddTHH:mm:ssZ") --auth-mode login --as-user`
