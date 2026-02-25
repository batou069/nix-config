# Project Overview

This project is a comprehensive **NixOS** and **Home Manager** configuration managed as a **Nix Flake**.

## Purpose

It defines the system state and user environments for multiple hosts (Laptop `lf-nix` and Desktop `viech`). It aims for a reproducible, declarative system setup using a shared core configuration with host-specific overrides.

## Structure

- **`flake.nix`**: The entry point defining inputs (dependencies) and outputs (system configurations).
- **`lib/`**: Flake library functions.
  - `default.nix`: General helpers.
  - `hosts.nix`: logic to define hosts.
- **`hosts/`**: Contains system-specific and shared NixOS configurations.
  - `default/`: Shared configuration files used by all hosts.
  - `lf-nix/`: Laptop configuration (`config.nix`, `packages.nix`, `hardware.nix`, `home.nix`).
  - `viech/`: Desktop configuration (`config.nix`, `packages.nix`, `hardware.nix`, `home.nix`).
  - `[hostname]/packages.nix`: Defines `environment.systemPackages` and programs for that host.
- **`home/`**: Contains Home Manager configurations and modules.
  - `_common.nix`: Common Home Manager modules shared across hosts.
  - `_editors/nixvim`: Neovim/Nixvim configuration.
  - `shells/`: Shell configurations (`zsh.nix` etc.).
  - `gui/`, `tui/`, `cli/`, `services/`: Categorized module imports.
- **`modules/`**: Custom Nix modules and helpers.
  - `lib-helpers.nix`: Custom helper functions.
  - `nixos-sops.nix`: SOPS NixOS module.
  - `hm-sops.nix`: SOPS Home Manager module.
- **`overlays/`**: Custom overlays (`default.nix`).
- **`secrets/`**: Encrypted secrets (`secrets.yaml`) managed by `sops-nix`.

## Configuration Logic

- **Host Configuration**: Each host in `hosts/` defines its own `config.nix` and `hardware.nix`, importing shared configs from `hosts/default/`.
- **Home Manager**:
  - Host-specific Home Manager config is located in `hosts/[hostname]/home.nix`.
  - Common Home Manager settings are imported from `home/_common.nix`.
- **Secrets**: Managed via `sops-nix` (configured in `modules/*-sops.nix`).
