# Tech Stack

## Core

- **Nix**: Package manager and language.
- **NixOS**: Operating system.
- **Home Manager**: User environment manager.
- **Flakes**: Dependency management and reproducibility.

## System Components

- **Desktop Environment**: Hyprland (Wayland compositor), with parts of KDE Plasma.
- **Shells**: Zsh, Fish, Bash, Nushell (managed via `programs.aliae`).
- **Terminal**: Kitty, Ghostty.
- **Editors**: Neovim (configured via `nixvim`), VSCode.
- **Browsers**: Zen Browser, Firefox.

## Utilities & Tools

- **Secrets**: `sops-nix` (Sops with Age encryption).
- **Styling**: `stylix` (Automated theming).
- **Formatting**: `treefmt-nix` (Alejandra, Prettier, Ruff, etc.).
- **Nix Helpers**: `nh` (Nix Helper CLI).
- **AI Integration**: `nix-ai-tools`, MCP Servers (`nix-mcp-servers`).

## Languages

- **Nix**: Configuration language.
- **Python**: Used for scripts and some tool configurations.
- **Lua**: Neovim configuration.
- **Bash/Shell**: Scripts.
