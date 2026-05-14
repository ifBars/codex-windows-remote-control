# How It Works

OpenAI's mobile Codex flow connects your phone to a machine where Codex is already running. The public launch post describes a secure relay layer: your files, credentials, permissions, and local setup stay on the host machine, while session state, output, approvals, screenshots, terminal output, diffs, and test results flow back to the phone.

The public availability wording currently tells users to update ChatGPT mobile and the Codex app on macOS, and says Windows app support is coming soon.

The useful detail is that the current Codex CLI includes an experimental remote-control path:

```powershell
codex remote-control
```

On Windows, this can start a headless app-server with remote control enabled even when the Windows desktop app does not expose the polished onboarding UI yet.

In a validated run, the Windows CLI:

1. Used the existing ChatGPT Codex login.
2. Enrolled the machine with the relay.
3. Kept a secure port 443 connection open.
4. Became visible to ChatGPT mobile after the mobile flow was refreshed.

So the practical conclusion is narrow:

The protocol path is not inherently macOS-only. The official limitation is around product support and desktop app onboarding. Until OpenAI ships the Windows app UI, the CLI entrypoint can bridge the gap for some users.
