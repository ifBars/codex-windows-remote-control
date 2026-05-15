# Codex Windows Remote Control

Use ChatGPT mobile with Codex running on Windows through the current Codex CLI.

OpenAI's mobile Codex rollout currently points Windows users at "coming soon" desktop-app support. The CLI path can already work:

```powershell
codex remote-control
```

This repo packages the short manual setup, an installable Codex skill, and a few notes from real testing.

## Human Jump Start

In PowerShell:

```powershell
bun install -g @openai/codex@latest
codex login status
codex remote-control
```

If `codex login status` says you are not logged in, run `codex login` first.

Leave that command running.

On your phone:

1. Update ChatGPT mobile.
2. Open the Codex mobile connection flow.
3. If it says "Waiting for desktop", back out and re-enter the flow once.
4. Pick the Windows machine when it appears.

That is the main path. You do not need to download or run any script from this repo to try it.

## Agent Jump Start

Install this repo as a Codex skill:

```powershell
git clone https://github.com/ifBars/codex-windows-remote-control.git "$env:USERPROFILE\.codex\skills\codex-windows-remote-control"
```

Restart Codex, then ask:

```text
$codex-windows-remote-control Help me connect ChatGPT mobile to Codex on this Windows machine.
```

The skill tells the agent to update Codex with Bun, check ChatGPT login, start `codex remote-control`, verify local process/network signals, and ask you to confirm that mobile sees the environment.

## Optional Helpers

The PowerShell scripts in `scripts/` are optional convenience wrappers for people who want a background process and a status check:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-codex-remote-control.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\status-codex-remote-control.ps1
```

If you do not want to run repo-provided PowerShell scripts, skip them. The manual three-command path above is the preferred quick start.

## What Worked In Testing

- Windows with `codex-cli 0.130.0`.
- Native Windows CLI, not WSL.
- Existing Codex threads worked best.

Known rough edges:

- This is not official Windows app support.
- Creating a brand-new thread from mobile was unreliable in testing; sending the first message could clear the draft without creating a thread.
- Desktop and phone did not always sync cleanly when driving the same thread from both clients at once.

For now, use the mobile connection mainly to continue an existing thread, and avoid using desktop and phone in the same thread at the same time.

## Docs

- [How It Works](docs/how-it-works.md)
- [Limitations](docs/limitations.md)
- [Troubleshooting](docs/troubleshooting.md)
