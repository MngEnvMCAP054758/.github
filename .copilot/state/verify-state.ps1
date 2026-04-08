# verify-state.ps1 — Run at EVERY session start
# Checks ACTUAL state vs claimed state. Updates project-state.json with truth.
# Usage: .\verify-state.ps1 [-Full] [-Quick]

param(
    [switch]$Full,   # Check everything including Azure resources
    [switch]$Quick   # Only check paths and health endpoints
)

$ErrorActionPreference = "Continue"
$stateFile = "$env:USERPROFILE\.copilot\state\project-state.json"
$snapshotDir = "$env:USERPROFILE\.copilot\state\snapshots"

if (-not (Test-Path $stateFile)) {
    Write-Error "State file not found: $stateFile"
    exit 1
}

$state = Get-Content $stateFile -Raw | ConvertFrom-Json
$now = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
$changes = @()

Write-Host "=== State Verification [$now] ===" -ForegroundColor Cyan

# ── 1. Check project source directories ──
foreach ($proj in $state.projects.PSObject.Properties) {
    $name = $proj.Name
    $p = $proj.Value
    $path = $p.source_path
    
    if ($path) {
        $exists = Test-Path $path
        Write-Host "[$name] source_path: " -NoNewline
        if ($exists) {
            Write-Host "EXISTS" -ForegroundColor Green -NoNewline
            # Check for git
            $gitDir = Join-Path $path ".git"
            if (Test-Path $gitDir) {
                $hash = (git -C $path rev-parse --short HEAD 2>$null)
                $branch = (git -C $path branch --show-current 2>$null)
                Write-Host " (git: $branch @ $hash)" -ForegroundColor DarkGray
                try { $p | Add-Member -NotePropertyName git_hash -NotePropertyValue $hash -Force } catch {}
                try { $p | Add-Member -NotePropertyName git_branch -NotePropertyValue $branch -Force } catch {}
            } else {
                Write-Host " (NO GIT)" -ForegroundColor Yellow
            }
        } else {
            Write-Host "MISSING" -ForegroundColor Red
            $changes += "[$name] source_path MISSING: $path"
            if ($p.status -notin @("pending_rebuild", "deleted")) {
                $p.status = "broken"
            }
        }
    }
}

# ── 2. Check deployed endpoints ──
$personalai = $state.projects.personalai
if ($personalai.deployed_url) {
    Write-Host "[personalai] health check: " -NoNewline
    try {
        $resp = Invoke-WebRequest -Uri "$($personalai.deployed_url)/health" -TimeoutSec 10 -UseBasicParsing -ErrorAction Stop
        if ($resp.StatusCode -eq 200) {
            Write-Host "HEALTHY ($($resp.StatusCode))" -ForegroundColor Green
            $personalai.deployed_healthy = $true
        } else {
            Write-Host "UNHEALTHY ($($resp.StatusCode))" -ForegroundColor Red
            $personalai.deployed_healthy = $false
            $changes += "[personalai] deployed but unhealthy: HTTP $($resp.StatusCode)"
        }
    } catch {
        Write-Host "UNREACHABLE" -ForegroundColor Red
        $personalai.deployed_healthy = $false
        $changes += "[personalai] endpoint unreachable: $($_.Exception.Message)"
    }
    $personalai.last_health_check = $now
}

# ── 3. Check trading bot (should be 24/7) ──
$trading = $state.projects.trading
if ($trading.should_be_running_24_7) {
    Write-Host "[trading] process check: " -NoNewline
    $procs = Get-Process -Name "python*" -ErrorAction SilentlyContinue | Where-Object {
        $_.CommandLine -match "trading" -or $_.MainWindowTitle -match "trading"
    }
    if ($procs) {
        Write-Host "RUNNING (PID: $($procs.Id -join ', '))" -ForegroundColor Green
    } else {
        Write-Host "NOT RUNNING" -ForegroundColor Red
        $changes += "[trading] bot is NOT running - should be 24/7"
    }
    $trading.last_verified = $now
}

# ── 4. Azure resource scan (only with -Full) ──
if ($Full) {
    Write-Host "`n=== Azure Resource Scan ===" -ForegroundColor Cyan
    
    # Resource groups
    try {
        $rgJson = az group list -o json 2>$null
        $rgs = $rgJson | ConvertFrom-Json
        $state.azure.resource_groups = @($rgs | ForEach-Object { $_.name })
        Write-Host "Resource groups: $($rgs.Count)" -ForegroundColor DarkGray
    } catch { Write-Host "Failed to list resource groups" -ForegroundColor Yellow }
    
    # VMs
    try {
        $vmJson = az vm list -d -o json 2>$null
        $vms = $vmJson | ConvertFrom-Json
        $state.azure.vms = @($vms | ForEach-Object { @{name=$_.name; rg=$_.resourceGroup; state=$_.powerState} })
        foreach ($vm in $vms) {
            $color = if ($vm.powerState -match "running") {"Green"} else {"DarkGray"}
            Write-Host "VM: $($vm.name) [$($vm.powerState)]" -ForegroundColor $color
        }
    } catch { Write-Host "Failed to list VMs" -ForegroundColor Yellow }
    
    # Web apps
    try {
        $appJson = az webapp list -o json 2>$null
        $apps = $appJson | ConvertFrom-Json
        $state.azure.webapps = @($apps | ForEach-Object { @{name=$_.name; rg=$_.resourceGroup; state=$_.state; url=$_.defaultHostName} })
        foreach ($app in $apps) {
            $color = if ($app.state -eq "Running") {"Green"} else {"Yellow"}
            Write-Host "WebApp: $($app.name) [$($app.state)]" -ForegroundColor $color
        }
    } catch { Write-Host "Failed to list web apps" -ForegroundColor Yellow }
    
    # Storage accounts
    try {
        $stJson = az storage account list -o json 2>$null
        $storage = $stJson | ConvertFrom-Json
        $state.azure.storage_accounts = @($storage | ForEach-Object { @{name=$_.name; rg=$_.resourceGroup} })
        Write-Host "Storage accounts: $($storage.Count)" -ForegroundColor DarkGray
    } catch { Write-Host "Failed to list storage accounts" -ForegroundColor Yellow }
    
    $state.azure.last_resource_scan = $now
}

# ── 5. Update timestamp and save ──
$state._last_verified = $now

$stateJson = $state | ConvertTo-Json -Depth 10
$stateJson | Set-Content $stateFile -Encoding UTF8

# Save snapshot
$snapName = "state_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"
$stateJson | Set-Content (Join-Path $snapshotDir $snapName) -Encoding UTF8

# ── 6. Summary ──
Write-Host "`n=== Verification Complete ===" -ForegroundColor Cyan
if ($changes.Count -gt 0) {
    Write-Host "[!] $($changes.Count) issues found:" -ForegroundColor Yellow
    foreach ($c in $changes) { Write-Host "  > $c" -ForegroundColor Yellow }
} else {
    Write-Host "[OK] All checks passed" -ForegroundColor Green
}
Write-Host "State saved: $stateFile"
Write-Host "Snapshot: $snapName"
