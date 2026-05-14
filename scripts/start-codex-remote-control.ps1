param(
    [switch]$SkipUpdate,
    [switch]$Foreground,
    [string]$LogDir = "$env:LOCALAPPDATA\CodexRemoteControl"
)

$ErrorActionPreference = "Stop"

function Write-Step($Message) {
    Write-Host "==> $Message"
}

function Get-CodexRemoteControlProcess {
    Get-CimInstance Win32_Process |
        Where-Object { $_.CommandLine -match 'codex(\.exe)?"?\s+remote-control' -or $_.CommandLine -match 'codex(\.exe)?\s+remote-control' }
}

Write-Step "Checking for an existing codex remote-control process"
$existing = Get-CodexRemoteControlProcess
if ($existing) {
    $existing | Select-Object ProcessId, CommandLine
    Write-Host "Remote control already appears to be running."
    exit 0
}

if (-not $SkipUpdate) {
    Write-Step "Updating @openai/codex with bun"
    if (-not (Get-Command bun -ErrorAction SilentlyContinue)) {
        throw "bun was not found on PATH. Install Bun or rerun with an already current codex binary."
    }
    bun install -g '@openai/codex@latest'
}

Write-Step "Checking codex CLI"
$codex = Get-Command codex -ErrorAction Stop
& $codex.Source --version

Write-Step "Checking ChatGPT login"
& $codex.Source login status

Write-Step "Checking remote-control command availability"
& $codex.Source remote-control --help | Out-String | Write-Host

if ($Foreground) {
    Write-Step "Starting codex remote-control in the foreground"
    & $codex.Source remote-control
    exit $LASTEXITCODE
}

New-Item -ItemType Directory -Force -Path $LogDir | Out-Null
$stdout = Join-Path $LogDir "remote-control.out.log"
$stderr = Join-Path $LogDir "remote-control.err.log"

Write-Step "Starting codex remote-control in the background"
$process = Start-Process -FilePath $codex.Source `
    -ArgumentList "remote-control" `
    -WindowStyle Hidden `
    -RedirectStandardOutput $stdout `
    -RedirectStandardError $stderr `
    -PassThru

Start-Sleep -Seconds 3

Write-Host "Wrapper PID: $($process.Id)"
Write-Host "stdout: $stdout"
Write-Host "stderr: $stderr"

Write-Step "Current remote-control processes"
Get-CodexRemoteControlProcess | Select-Object ProcessId, CommandLine

Write-Step "Next step"
Write-Host "Open ChatGPT mobile, back out of the Waiting for desktop screen, and re-enter the Codex connection flow."
