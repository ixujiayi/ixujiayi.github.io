# 一键备份：提交当前改动并推送到 GitHub
# 用法：powershell -ExecutionPolicy Bypass -File scripts\backup.ps1
$ErrorActionPreference = 'Stop'

$git = 'C:\Program Files\Git\cmd\git.exe'
if (-not (Test-Path -LiteralPath $git)) {
    $git = 'git'
}

Set-Location (Split-Path $PSScriptRoot -Parent)
$stamp = Get-Date -Format 'yyyy-MM-dd HH:mm'

& $git add -A
& $git commit -m "backup: $stamp" --allow-empty
& $git push origin main

Write-Host "备份完成：$stamp"
