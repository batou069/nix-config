# My NixOS & Hyprland Configuration

This repository contains my personal [NixOS](https://nixos.org/) configuration, managed declaratively using [Nix Flakes](https://nixos.wiki/wiki/Flakes). It sets up a complete desktop environment built around the [Hyprland](https://hyprland.org/) Wayland compositor, designed to be reproducible, modular, and easily portable across different machines.

## ✨ Features

- **Declarative & Reproducible**: The entire system configuration, from the kernel to application dotfiles, is defined in Nix.
- **Hyprland WM**: Uses the Hyprland compositor for a modern, fluid, and highly customizable desktop experience.
- **Modular Design**: The configuration is split into logical modules for hardware, services, and user settings, making it easy to manage and adapt.
- **Home Manager**: User-specific configurations and dotfiles are managed with [Home Manager](https://github.com/nix-community/home-manager), ensuring a consistent environment.
- **Automated Installation**: Includes scripts to automate the installation process on a new machine.

## 📂 Repository Structure

The repository is organized to separate concerns, making it clean and maintainable:

```
.
├���─ flake.nix         # Main entry point defining inputs and outputs
├── hosts/            # Machine-specific configurations
│   └── lf-nix/       # Configuration for the 'lf-nix' host
│       ├── config.nix    # System-level settings (services, hardware)
│       ├── home.nix      # User-level settings (dotfiles, packages)
│       └── ...
├── modules/          # Reusable NixOS modules (e.g., drivers)
├── home/             # Home Manager configurations for specific applications
└── assets/           # Static configuration files and assets
```

- **`flake.nix`**: Defines all dependencies (like `nixpkgs` and `home-manager`) and orchestrates the build for different hosts.
- **`hosts/`**: Each subdirectory represents a unique machine. The `lf-nix` directory contains the primary configuration for this setup.
- **`modules/`**: Contains reusable configuration files that can be imported into any host, such as configurations for NVIDIA, AMD, or Intel graphics drivers.
- **`home/`**: Holds Home Manager configurations, neatly organizing dotfiles and settings for applications like `vscode`, `firefox`, `fzf`, and more.

## 🚀 Usage

### Installation

The `install.sh` script (work in progress) is intended to guide you through the installation process on a new system, including disk partitioning using the `disko.nix` configuration.

### Applying the Configuration

To apply the configuration to the target machine after making changes, run the following command from the repository root:

**For NixOS system configuration:**
```bash
sudo nixos-rebuild switch --flake .#lf-nix
```

**For Home Manager user configuration:**
```bash
home-manager switch --flake .#lf
```

This will build the new system generation and activate it.