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

## Alternate App-Server Form

Some people are using the lower-level app-server command from the Windows Codex app bundle:

```powershell
& "$env:LOCALAPPDATA\OpenAI\Codex\bin\codex.exe" app-server --enable remote_control --listen ws://127.0.0.1:4503
```

That starts an app-server websocket listener and enables the experimental remote-control feature surface for clients. In my testing, this was not required. The shorter `codex remote-control` command was enough to enroll the Windows machine and make it visible from ChatGPT mobile.

Use the app-server form as a fallback if `codex remote-control` is unavailable or does not work with your install. Leave whichever command you use running while refreshing the mobile flow.

## Latest CLI Fork

`codex-cli 0.135.0` changed `codex remote-control start` to use the app-server daemon lifecycle. Upstream currently rejects that daemon lifecycle on Windows, so this project tracks a focused fork for Windows remote-control daemon support:

- Fork: https://github.com/ifBars/codex
- Branch: `windows-remote-control-daemon`

The fork keeps the upstream Unix daemon behavior intact and adds a Windows PID backend so the latest CLI line can start and stop a remote-control app-server on Windows until official support lands.

## About Config Snippets

You may see posts suggesting this in `$HOME\.codex\config.toml`:

```toml
[features]
remote_connections = true
remote_control = true
workspace_dependencies = false
```

I do not recommend making that the first path. In `codex-cli 0.130.0`, `remote_connections` is not a recognized feature flag, and the confirmed working path did not require editing `config.toml`.

If you want to experiment with feature flags, prefer a one-shot command first:

```powershell
codex --enable remote_control remote-control
```

If that helps your install, then you can decide whether to make a persistent config change. Do not add `remote_connections` unless your own `codex features list` shows that key exists.

## What Worked In Testing

- Windows with `codex-cli 0.130.0`.
- Native Windows CLI, not WSL.
- Existing Codex threads worked best.

Known rough edges:

- This is not official Windows app support.
- Creating a brand-new thread from mobile was unreliable in testing; sending the first message could clear the draft without creating a thread.
- Desktop and phone did not always sync cleanly when driving the same thread from both clients at once.
- Some mobile/desktop flows may still behave like they were designed around the macOS app first. If a request involves paths or project locations, spell out the real Windows path and prefer continuing an already working thread.

For now, use the mobile connection mainly to continue an existing thread, and avoid using desktop and phone in the same thread at the same time.

## Docs

- [How It Works](docs/how-it-works.md)
- [Limitations](docs/limitations.md)
- [Troubleshooting](docs/troubleshooting.md)
