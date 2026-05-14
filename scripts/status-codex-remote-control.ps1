$ErrorActionPreference = "Stop"

function Get-CodexRemoteControlProcess {
    Get-CimInstance Win32_Process |
        Where-Object { $_.CommandLine -match 'codex(\.exe)?"?\s+remote-control' -or $_.CommandLine -match 'codex(\.exe)?\s+remote-control' }
}

Write-Host "==> Codex CLI"
if (Get-Command codex -ErrorAction SilentlyContinue) {
    codex --version
    codex login status
} else {
    Write-Host "codex was not found on PATH."
}

Write-Host ""
Write-Host "==> remote-control processes"
$processes = Get-CodexRemoteControlProcess
if (-not $processes) {
    Write-Host "No codex remote-control process found."
    exit 1
}

$processes | Select-Object ProcessId, CommandLine | Format-Table -AutoSize -Wrap

Write-Host ""
Write-Host "==> TCP connections"
$connections = @()
foreach ($process in $processes) {
    $connections += Get-NetTCPConnection -OwningProcess $process.ProcessId -ErrorAction SilentlyContinue |
        Where-Object { $_.RemotePort -eq 443 -or $_.State -eq "Established" } |
        Select-Object @{ Name = "ProcessId"; Expression = { $process.ProcessId } },
            State,
            LocalAddress,
            LocalPort,
            RemoteAddress,
            RemotePort
}

if ($connections.Count -gt 0) {
    $connections | Format-Table -AutoSize
} else {
    Write-Host "No established or remote-port-443 connections found for the remote-control process yet."
}

Write-Host ""
Write-Host "If a process is running and has established port 443 connections, refresh the ChatGPT mobile Codex connection flow."
