$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$gitHooks = Join-Path $repoRoot ".git\hooks"
if (-not (Test-Path $gitHooks)) {
    Write-Error "No .git/hooks directory found. Run this from inside a Git repository."
    exit 1
}
Copy-Item (Join-Path $repoRoot "githooks\post-commit") (Join-Path $gitHooks "post-commit") -Force
Copy-Item (Join-Path $repoRoot "githooks\post-merge") (Join-Path $gitHooks "post-merge") -Force
Copy-Item (Join-Path $repoRoot "githooks\post-checkout") (Join-Path $gitHooks "post-checkout") -Force
Write-Host "Installed Git hooks:"
Write-Host "- post-commit"
Write-Host "- post-merge"
Write-Host "- post-checkout"
Write-Host "They will regenerate memory-bank indexes automatically."
