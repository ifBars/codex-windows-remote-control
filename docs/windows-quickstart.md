# Windows Quickstart

## Human Path

From PowerShell:

```powershell
bun install -g @openai/codex@latest
codex login status
codex remote-control
```

If `codex login status` says you are not logged in, run `codex login` first.

Leave the command running. On your phone, back out of the ChatGPT mobile "Waiting for desktop" screen and re-enter the Codex connection flow.

## Agent Path

Install the skill:

```powershell
git clone https://github.com/ifBars/codex-windows-remote-control.git "$env:USERPROFILE\.codex\skills\codex-windows-remote-control"
```

Restart Codex, then ask:

```text
$codex-windows-remote-control Help me connect ChatGPT mobile to Codex on this Windows machine.
```

## Optional Scripts

Use the scripts only if you want a background process and local status check. They are not required for the workaround.

## Success Signals

- `codex remote-control --help` exists.
- `codex login status` says ChatGPT login is active.
- A `codex.exe remote-control` process is running.
- The process has established port 443 connections.
- ChatGPT mobile shows the Windows machine.
