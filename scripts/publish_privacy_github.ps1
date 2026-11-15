# Publishes docs/privacy to GitHub Pages via repo "bondly-privacy"
# Prereq: gh auth login
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot\..

$repo = "bondly-privacy"
gh auth status

if (-not (git remote get-url origin 2>$null)) {
  gh repo create $repo --public --description "Bondly: Lock Screen & Touch — privacy policy" --source=. --remote=origin --push
} else {
  git add docs/privacy .github/workflows/privacy-pages.yml lib/core/config/legal_urls.dart
  git commit -m "Publish Bondly privacy policy for GitHub Pages" 2>$null
  git push -u origin main
}

Write-Host ""
Write-Host "Enable Pages: GitHub repo Settings -> Pages -> Build: GitHub Actions"
Write-Host "Policy URL (after workflow): https://$(gh api user -q .login).github.io/$repo/"