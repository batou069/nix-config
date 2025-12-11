# Gemini CLI Configuration

- **Issue:** `gemini-cli` ignores `GEMINI_API_KEY` environment variable if `~/.gemini/settings.json` exists but lacks the `apiKey` field.
- **Fix:** We inject the `apiKey` into `~/.gemini/settings.json` during Home Manager activation.
- **Implementation:** `home/home.nix` contains a `linkMcpConfig` activation script that reads the sops secret and `mcp.json`, merges them with `jq`, and writes the result to `settings.json`.
- **Manual Fix:** For the current session, we manually performed this merge using `jq` and the current `GEMINI_API_KEY` env var.
