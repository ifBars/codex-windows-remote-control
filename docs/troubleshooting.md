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

## ChatGPT Mobile Still Says Waiting For Desktop

Keep `codex remote-control` running, then:

1. Back out of the waiting screen.
2. Re-enter the Codex connection flow.
3. Restart the Windows Codex desktop app once.
4. Re-check the remote-control process status.

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
