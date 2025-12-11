# Project Overview

This project is a comprehensive **NixOS** and **Home Manager** configuration managed as a **Nix Flake**.

## Purpose

It defines the system state (`hosts/lf-nix`) and user environment (`home/home.nix`) for the user `lf`. It aims for a reproducible, declarative system setup including desktop environment (Hyprland/KDE), development tools, shell configurations, and secret management.

## Structure

- **`flake.nix`**: The entry point defining inputs (dependencies) and outputs (system configurations).
- **`hosts/`**: Contains system-specific NixOS configurations.
  - `lf-nix/`: The main host configuration (`config.nix`, `packages.nix`, `hardware.nix`).
- **`home/`**: Contains Home Manager configurations.
  - `home.nix`: The main user configuration entry point.
  - `shells/`: Shell configurations (`aliae.nix`, `zsh.nix`, etc.).
  - `gui/`, `tui/`, `editors/`: Categorized module imports.
- **`modules/`**: Custom Nix modules and helpers.
  - `lib-helpers.nix`: Defines `libPkg`, `libPkgs`, `libOverlay`.
  - `hm-sops.nix`, `nixos-sops.nix`: Secrets configuration.
- **`lib/`**: Library functions for flake outputs (`default.nix`, `hosts.nix`).
- **`overlays/`**: Custom overlays (`default.nix`).
- **`secrets/`**: Encrypted secrets (`secrets.yaml`) managed by `sops-nix`.

## Key Features

- **Centralized Shell Config**: Uses `aliae` to manage aliases and env vars across Zsh, Fish, Bash, and Nushell.
- **Unified Styling**: Uses `stylix` for system-wide theming (Catppuccin).
- **Secrets Management**: Uses `sops-nix` with Age encryption.
- **Helper Functions**: Uses `libPkg`/`libPkgs` to safely access flake input packages.
