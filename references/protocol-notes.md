# Protocol Notes

These notes are for agents helping users understand why the workaround can work.

## What OpenAI Says Publicly

OpenAI's May 14, 2026 announcement says Codex in ChatGPT mobile can connect to machines where Codex is running, uses a secure relay layer, and keeps files, credentials, permissions, and local setup on the host machine. The availability section tells users to update ChatGPT mobile and the Codex app on macOS, and says Windows app support is coming soon.

Source: https://openai.com/index/work-with-codex-from-anywhere/

## What The Current CLI Exposes

Current Codex CLI docs expose:

```sh
codex app-server daemon start
codex app-server daemon restart
codex app-server daemon enable-remote-control
codex app-server daemon disable-remote-control
codex app-server daemon stop
codex app-server daemon version
codex app-server daemon bootstrap --remote-control
```

The top-level Windows workaround uses:

```sh
codex remote-control
```

The daemon path may be Unix-oriented or unavailable on Windows builds, but the direct top-level command can still start a headless app-server with remote control enabled.

## Observed Windows Behavior

On Windows with `codex-cli 0.130.0`, `codex remote-control` was observed to:

- authenticate with the user's existing ChatGPT Codex login,
- create a local remote-control enrollment,
- connect to `chatgpt.com` over TLS/WebSocket-style port 443 connections,
- appear in ChatGPT mobile after the user refreshed the mobile connection flow.

This means the transport and relay path are not inherently macOS-only. The official limitation appears to be product onboarding and desktop-app support, not a hard protocol impossibility.

## Important Boundary

Do not present this as official OpenAI Windows support. Present it as an experimental CLI path discovered from public Codex CLI behavior and validated in a real Windows run.
