# Windows Quickstart

## Requirements

- Windows
- Bun on PATH
- Codex CLI logged in with ChatGPT
- Updated ChatGPT mobile app

## Start Remote Control

```powershell
bun install -g @openai/codex@latest
codex --version
codex login status
codex remote-control
```

Leave the command running. On your phone, back out of the ChatGPT mobile "Waiting for desktop" screen and re-enter the Codex connection flow.

## Background Mode

From this repo:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-codex-remote-control.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\status-codex-remote-control.ps1
```

## Expected Signals

- `codex remote-control --help` exists.
- `codex login status` says ChatGPT login is active.
- A `codex.exe remote-control` process is running.
- The process has established port 443 connections.
- ChatGPT mobile shows the Windows machine.
