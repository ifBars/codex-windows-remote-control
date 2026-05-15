# Troubleshooting

## `remote-control` Is Missing

Update Codex:

```powershell
bun install -g @openai/codex@latest
codex --version
codex remote-control --help
```

## `app-server daemon` Is Missing On Windows

Use the top-level command instead:

```powershell
codex remote-control
```

The daemon path is not required for the Windows workaround.

## `codex remote-control` Does Not Work

Try the lower-level app-server form that some Windows users have reported working:

```powershell
& "$env:LOCALAPPDATA\OpenAI\Codex\bin\codex.exe" app-server --enable remote_control --listen ws://127.0.0.1:4503
```

Keep that process running and refresh the ChatGPT mobile Codex flow.

This is not the preferred quick start because it depends on the Windows app bundle path and opens a local websocket listener. Use it as a fallback, not the first instruction.

## Config Snippet Advice

Some posts suggest adding:

```toml
[features]
remote_connections = true
remote_control = true
workspace_dependencies = false
```

Check your CLI before doing that:

```powershell
codex features list
```

On `codex-cli 0.130.0`, `remote_control` is recognized, `workspace_dependencies` is recognized, and `remote_connections` is not recognized. The tested Windows workaround did not require editing `config.toml`.

If you want to test the feature flag without changing config, run:

```powershell
codex --enable remote_control remote-control
```

Only persist feature flags if they are recognized by your installed CLI.

## ChatGPT Mobile Still Says Waiting For Desktop

Keep `codex remote-control` running, then:

1. Back out of the waiting screen.
2. Re-enter the Codex connection flow.
3. Restart the Windows Codex desktop app once.
4. Re-check the remote-control process status.

If you want a local status check without reading logs manually, the optional `scripts/status-codex-remote-control.ps1` helper prints matching processes and port 443 connections. It is not required.

## Mobile Sends The Wrong Path

If the mobile app or the agent appears to assume a macOS-style project path, steer it with the exact Windows path:

```text
Use C:\Users\you\path\to\repo as the workspace.
```

Existing Codex threads were more reliable in testing than brand-new mobile-started threads.

## WSL Auth Fails

If WSL reports `refresh_token_reused`, run login inside WSL:

```bash
~/.codex/packages/standalone/current/codex login
~/.codex/packages/standalone/current/codex login status
```

Then retry:

```bash
~/.codex/packages/standalone/current/codex remote-control
```

## Logs Show Plugin 403 Warnings

Plugin sync warnings are not automatically remote-control failures. Check whether the process is still running and whether it has established port 443 connections.
