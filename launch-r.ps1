# Launch R in the current VS Code workspace folder
# Usage: Run this script from VS Code integrated terminal
# It will start the R GUI/terminal with working directory set to the folder containing this script.

# Determine script folder and parent robustly.
if ($PSScriptRoot) {
    $workspace = $PSScriptRoot
} else {
    # Fallback when $PSScriptRoot is unavailable (shouldn't happen in PS 5.1 when run as a script)
    $workspace = (Get-Location).ProviderPath
}

# Get parent of workspace (one level up) without using -LiteralPath/-Parent combination that caused ambiguity.
try {
    $rootPath = Split-Path -Path $workspace -Parent
} catch {
    Write-Warning "Failed to derive parent path from '$workspace': $_"
    $rootPath = $workspace  # Fallback: treat workspace itself as root.
}

if (-Not (Test-Path -Path $rootPath)) {
    Write-Error "Parent path not found: $rootPath"; exit 1
}

# Ensure workspace exists.
if (-Not (Test-Path -Path $workspace)) {
    Write-Error "Workspace path not found: $workspace"; exit 1
}

Write-Host "Parent  : $rootPath"
Write-Host "Project : $workspace"
Write-Host "Starting R with working directory set to project folder..."
Push-Location -LiteralPath $workspace
# Path to R executable (adjust if version changes)
$RExe = "C:\Users\GQAEC\AppData\Local\Programs\R\R\bin\R.exe"
if (-Not (Test-Path $RExe)) {
    Write-Error "R executable not found at $RExe. Update path in launch-r.ps1."
    exit 1
}
& $RExe --no-save --no-restore
Pop-Location
