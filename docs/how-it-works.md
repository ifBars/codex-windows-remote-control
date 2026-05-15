# How It Works

OpenAI's mobile Codex flow connects your phone to a machine where Codex is already running. The public launch post describes a secure relay layer: files, credentials, permissions, and local setup stay on the host machine, while session state and approvals flow through ChatGPT mobile.

The public availability wording currently tells users to update ChatGPT mobile and the Codex app on macOS, and says Windows app support is coming soon.

The useful detail is that the current Codex CLI includes an experimental remote-control path:

```powershell
codex remote-control
```

On Windows, this can start a headless app-server with remote control enabled even when the Windows desktop app does not expose the polished onboarding UI yet.

There is also a lower-level app-server form:

```powershell
codex app-server --enable remote_control --listen ws://127.0.0.1:4503
```

That command exposes a local websocket app-server and enables the experimental `remote_control` feature surface for clients. It is useful as a fallback, but it is more implementation-shaped than the top-level `codex remote-control` command.

The config-file version of this idea is less reliable across builds. `remote_control` is a real feature flag in `codex-cli 0.130.0`, but `remote_connections` is not recognized by that CLI. The validated path in this repo did not require a persistent config edit.

In a validated run, the Windows CLI:

1. Used the existing ChatGPT Codex login.
2. Enrolled the machine with the relay.
3. Kept a secure port 443 connection open.
4. Became visible to ChatGPT mobile after the mobile flow was refreshed.

The practical conclusion is narrow: the protocol path is not inherently macOS-only. The official limitation appears to be product support and desktop-app onboarding. Until OpenAI ships the Windows app UI, the CLI entrypoint can bridge the gap for some users.
