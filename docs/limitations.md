# Limitations

This is an unsupported workaround. OpenAI's public rollout says to use the macOS Codex app for mobile setup and says Windows app support is coming soon.

Known limits:

- The `remote-control` command is experimental.
- OpenAI can change server-side gating, enrollment behavior, command names, or protocol expectations.
- Mobile visibility is the only real end-to-end success check.
- A running process and port 443 connection are strong signals, but they do not prove the phone can see the environment.
- Existing Codex threads worked best in testing. Creating a new thread from mobile was unreliable: sending the first message could clear/delete the draft without creating the thread.
- Desktop and phone did not always sync cleanly when driving the same thread from both clients at once. Avoid simultaneous desktop+phone use in the same thread when possible.
- Some mobile/desktop flows may still behave like they were designed around the macOS app first. When starting or steering work from mobile, be explicit about Windows paths such as `C:\Users\...` and prefer existing threads.
- WSL has separate Codex auth state and may fail with stale refresh tokens until `codex login` is redone inside WSL.
- Plugin sync warnings in logs may be unrelated to remote-control success.
- The alternate `app-server --enable remote_control --listen ws://127.0.0.1:4503` form opens a local websocket listener and depends on the Windows app bundle path. Prefer `codex remote-control` first.
- Do not blindly copy config snippets. In `codex-cli 0.130.0`, `remote_connections` is not a recognized feature flag.

Security boundary:

- You do not need to run this repo's helper scripts to try the workaround.
- Do not expose local ports to the public internet.
- Do not proxy the relay through third-party services.
- Do not copy auth tokens between Windows and WSL.
- Keep using Codex/ChatGPT's normal login and permission model.
