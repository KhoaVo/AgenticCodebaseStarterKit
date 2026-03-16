$hasWorkingChanges = -not [string]::IsNullOrWhiteSpace((git status --porcelain))

if (-not $hasWorkingChanges) {
    Write-Host "No changes to commit."
    exit 0
}

git add -A
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "checkpoint: $timestamp"
