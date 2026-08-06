# 一键备份：有改动时提交并推送到 GitHub
# 用法：powershell -ExecutionPolicy Bypass -File scripts\backup.ps1
$ErrorActionPreference = 'Stop'

$git = 'C:\Program Files\Git\cmd\git.exe'
if (-not (Test-Path -LiteralPath $git)) {
    $git = 'git'
}

Set-Location (Split-Path $PSScriptRoot -Parent)
$stamp = Get-Date -Format 'yyyy-MM-dd HH:mm'
$log = Join-Path $env:TEMP 'myweb-backup.log'

try {
    $status = & $git status --porcelain
    if ($LASTEXITCODE -ne 0) { throw 'git status 执行失败' }

    if ($status) {
        & $git add -A
        if ($LASTEXITCODE -ne 0) { throw 'git add 执行失败' }

        & $git commit -m "backup: $stamp"
        if ($LASTEXITCODE -ne 0) { throw 'git commit 执行失败' }

        & $git push origin main
        if ($LASTEXITCODE -ne 0) { throw 'git push 执行失败' }

        $message = "备份完成：$stamp"
    } else {
        $message = "没有改动，跳过备份：$stamp"
    }
    Write-Host $message
    Add-Content -LiteralPath $log -Value ("[{0}] {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $message)
} catch {
    $errorMsg = "备份失败：$stamp`n$($_.Exception.Message)"
    Write-Error $errorMsg
    Add-Content -LiteralPath $log -Value ("[{0}] {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $errorMsg)
    exit 1
}
