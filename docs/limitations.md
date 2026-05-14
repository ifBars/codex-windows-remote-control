# Limitations

This is an unsupported workaround.

OpenAI's public rollout says to use the macOS Codex app for mobile setup and says Windows app support is coming soon. That means this repo should not claim official Windows support.

Known limits:

- The `remote-control` command is experimental.
- OpenAI can change server-side gating, enrollment behavior, command names, or protocol expectations.
- Mobile visibility is the only real end-to-end success check.
- A running process and port 443 connection are strong signals, but they do not prove the phone can see the environment.
- WSL has separate Codex auth state and may fail with stale refresh tokens until `codex login` is redone inside WSL.
- Plugin sync warnings in logs may be unrelated to remote-control success.

Security boundary:

- Do not expose local ports to the public internet.
- Do not proxy the relay through third-party services.
- Do not copy auth tokens between Windows and WSL.
- Keep using Codex/ChatGPT's normal login and permission model.
