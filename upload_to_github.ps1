# PowerShell Script to Push all files directly to https://github.com/soojal901-cmd/skk
param (
    [Parameter(Mandatory=$false)]
    [string]$Token
)

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (-not $Token) {
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "  Pushing Job Portal to https://github.com/soojal901-cmd/skk" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "GitHub par push karne ke liye Personal Access Token (PAT) zaroori hai." -ForegroundColor Yellow
    Write-Host "Token generate karne ke liye: https://github.com/settings/tokens" -ForegroundColor Gray
    Write-Host "(Scope: check 'repo' box)" -ForegroundColor Gray
    Write-Host ""
    $Token = Read-Host "Apna GitHub Personal Access Token paste karein"
}

if (-not $Token) {
    Write-Host "Error: Token faraham nahi kiya gaya. Push cancel ho gaya." -ForegroundColor Red
    exit 1
}

$repoOwner = "soojal901-cmd"
$repoName = "skk"
$branch = "main"

$filesToUpload = @(
    "index.html",
    "README.md",
    "css/styles.css",
    "css/components.css",
    "js/data.js",
    "js/live-sync.js",
    "js/modal.js",
    "js/app.js"
)

$headers = @{
    "Authorization" = "Bearer $Token"
    "User-Agent"    = "PowerShell-JobPortal-Uploader"
    "Accept"        = "application/vnd.github.v3+json"
}

Write-Host "`nUploading files to repository: $repoOwner/$repoName..." -ForegroundColor Cyan

foreach ($relPath in $filesToUpload) {
    $fullPath = Join-Path $PSScriptRoot $relPath
    if (-not (Test-Path $fullPath)) {
        Write-Host "Skipping (not found): $relPath" -ForegroundColor DarkGray
        continue
    }

    $bytes = [System.IO.File]::ReadAllBytes($fullPath)
    $base64Content = [Convert]::ToBase64String($bytes)
    
    $apiUrl = "https://api.github.com/repos/$repoOwner/$repoName/contents/$relPath"

    # Check if file already exists to get SHA for update
    $sha = $null
    try {
        $existing = Invoke-RestMethod -Uri $apiUrl -Method Get -Headers $headers -ErrorAction Stop
        $sha = $existing.sha
    } catch {
        # File doesn't exist yet, proceed with creation
    }

    $bodyObj = @{
        message = "Add verified $relPath to Job Portal"
        content = $base64Content
        branch  = $branch
    }
    if ($sha) {
        $bodyObj["sha"] = $sha
    }

    $jsonBody = $bodyObj | ConvertTo-Json

    try {
        $response = Invoke-RestMethod -Uri $apiUrl -Method Put -Body $jsonBody -Headers $headers
        Write-Host "[SUCCESS] Uploaded: $relPath" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to upload $relPath : $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nAll files processed! Visit your repository:" -ForegroundColor Cyan
Write-Host "https://github.com/$repoOwner/$repoName" -ForegroundColor Yellow
