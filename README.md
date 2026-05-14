# Codex Windows Remote Control

An installable Codex skill for helping Windows users connect ChatGPT mobile to a Codex environment using the experimental `codex remote-control` CLI path.

OpenAI's May 14, 2026 launch post says Codex mobile support is in preview and that phone-to-Codex setup currently points users to the macOS Codex app, with Windows app support coming soon. In practice, the current Windows Codex CLI can run the remote-control transport directly.

This repo packages that workflow so a Codex agent can try it repeatably, verify what happened, and explain the limits clearly.

## Quick Start

From PowerShell:

```powershell
bun install -g @openai/codex@latest
codex login status
codex remote-control
```

Then refresh the ChatGPT mobile Codex connection flow.

For a background process:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-codex-remote-control.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\status-codex-remote-control.ps1
```

## Install The Skill

Manual install:

```powershell
git clone https://github.com/ifBars/codex-windows-remote-control.git "$env:USERPROFILE\.codex\skills\codex-windows-remote-control"
```

Then restart Codex so the skill list refreshes.

If you use a skill installer that supports GitHub root-level skills, install the repo root as:

```powershell
python install-skill-from-github.py --repo ifBars/codex-windows-remote-control --path . --name codex-windows-remote-control
```

## Use The Skill

Ask Codex:

```text
$codex-windows-remote-control Help me connect ChatGPT mobile to Codex on this Windows machine.
```

The skill will guide the agent through updating the CLI, checking ChatGPT login, starting `codex remote-control`, verifying process/network signals, and asking you to confirm the mobile UI sees the desktop.

## Status

Validated on Windows with `codex-cli 0.130.0`.

Known caveat: this is not official Windows app support. It uses the CLI's experimental remote-control path while OpenAI's desktop app rollout catches up.

In testing, existing Codex threads worked best. Starting a brand-new thread from mobile was unreliable: sending the first message could clear/delete the draft without creating the thread. Sync also appeared inconsistent when using desktop and phone in the same thread at the same time. For now, use the mobile connection mainly to continue an existing thread, and avoid driving the same thread from desktop and phone concurrently.

## Docs

- [Windows Quickstart](docs/windows-quickstart.md)
- [How It Works](docs/how-it-works.md)
- [Limitations](docs/limitations.md)
- [Troubleshooting](docs/troubleshooting.md)
