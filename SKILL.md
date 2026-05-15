---
name: codex-windows-remote-control
description: Help users connect ChatGPT mobile to a Windows machine running Codex by using the experimental `codex remote-control` CLI path. Use when a user is on Windows, sees ChatGPT mobile waiting for a Codex desktop, asks why mobile Codex only mentions macOS, wants to try the unsupported Windows workaround, needs WSL fallback triage, or wants an agent to install/update Codex CLI, start remote control, verify enrollment signals, and document results.
---

# Codex Windows Remote Control

## Goal

Get ChatGPT mobile to discover a Windows-hosted Codex environment using the experimental Codex CLI remote-control entrypoint.

Treat this as an unsupported workaround. OpenAI's public rollout says mobile-to-desktop setup currently points users to the macOS Codex app and says Windows app support is coming soon. The useful discovery is that the current Windows CLI package can run `codex remote-control` directly.

## Default Workflow

1. Confirm the user's platform and Codex state.
2. Prefer native Windows first.
3. Use WSL only if native Windows cannot run the current CLI or cannot authenticate.
4. Keep the remote-control process alive while the user refreshes ChatGPT mobile.
5. Verify with process, login, network, and user-visible mobile signals.
6. Record what worked and what did not.

## Native Windows Path

Use this path first on Windows:

```powershell
bun install -g @openai/codex@latest
codex --version
codex login status
codex remote-control
```

Prefer the manual command first. If the user explicitly wants a background process and accepts running repo-local PowerShell, use the bundled helper:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-codex-remote-control.ps1
```

Then inspect status:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\status-codex-remote-control.ps1
```

Success indicators:

- `codex --version` is new enough to expose `remote-control`.
- `codex remote-control --help` describes a headless app-server with remote control enabled.
- `codex login status` reports ChatGPT login.
- A `codex.exe remote-control` process remains running.
- The process has established TLS connections on remote port `443`.
- ChatGPT mobile stops waiting and shows or opens the desktop environment.

## Mobile Check

After remote control is running, tell the user to refresh the mobile flow:

1. Back out of the ChatGPT mobile "Waiting for desktop" screen.
2. Re-enter the Codex mobile connection flow.
3. Look for the Windows machine name.
4. If it still waits, restart the Windows Codex desktop app once while leaving the CLI `remote-control` process running.

Do not call the setup complete until the user confirms the mobile app sees the environment. Process and network signals are useful, but mobile visibility is the real end-to-end check.

## WSL Fallback

Use WSL only after the native Windows path fails.

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
~/.codex/packages/standalone/current/codex --version
~/.codex/packages/standalone/current/codex login status
~/.codex/packages/standalone/current/codex remote-control
```

If WSL reports `refresh_token_reused`, redo `codex login` inside WSL. Do not assume the Windows ChatGPT login automatically carries into WSL; it has a separate `$HOME/.codex` state.

## Troubleshooting Rules

- If `codex remote-control` is missing, update the CLI with `bun install -g @openai/codex@latest`.
- If `codex app-server daemon` is missing on Windows, that is expected for many builds. Use top-level `codex remote-control`.
- If the desktop app has no visible mobile onboarding UI, keep testing the CLI path. The Windows app may have bundled remote UI chunks without the product rollout enabled.
- If logs show plugin sync 403s but the remote-control process is connected, do not treat plugin warnings as remote-control failure by themselves.
- If the phone still waits after a confirmed CLI connection, document that as a product-gating or discovery issue and try WSL only if useful.

## References

Read these only when needed:

- `references/protocol-notes.md` for why the Windows CLI path is possible.
- `references/attempt-template.md` for documenting a user's run.
- `docs/windows-quickstart.md` for user-facing setup steps.
- `docs/how-it-works.md` for public explanation material.
