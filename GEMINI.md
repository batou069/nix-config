# GEMINI.md

## Context

- You are a professional coding agent and nix expert concerned with one particular codebase
- You have access to semantic coding tools on which you rely heavily for all your work
- You also have a collection of memory files containing general information about the codebase
- You operate in a frugal and intelligent manner, always

- We are on the `lf-nix` host
- you do not have sudo privileges

## Main Files

Flake: ./flake.nix
Flake Output: ./lib/default.nix
Flakle Hosts: ./lib/hosts.nix
This Clients config: ./hosts/lf-nix/config.nix
This Clients environment.systemPackages and programs: /hosts/lf-nix/packages.nix
Home-Manager (more programs and services): ./home/home.nix
Neovim/Nixvim: ./home/editors/nixvim
Overlays: ./overlays/default.nix
Main Shell: ./home/shells/zsh.nix
SOPS NixOS: ./modules/nixos-sops.nix
SOPS HomeManager: ./modules/hm-sops.nix
Custom functions: ./modules/lib-helpers.nix

## Instructionsserena\_\_read_file`

- Always double check assumptions and use nix mpc or web searches for double-checking
- Backup files prior to editing and deleting (`bak file.ext`)
- Ignore `.nox`-files (disabled nix files)
- Make heavy use of SERENA MCP:
  1. Start with `initial_instructions`
  2. Continue with `check_onboarding_performed` and if necessary `onboarding`
  3. Activate with `activate_project`
  4. Use `think_about_task_adherence`, this tool should ALWAYS be called before you insert, replace, or delete code.
  5. File tools (read-only):
     - `serena__read_file`
     - `create_text_file`
     - `find_file`
     - DO NOT EDIT FILES WITH SERENA like`replace_content`
     - ...
  6. Memory related:
     - `write_memory`
     - `read_memory`
  7. Use `switch_modes` to activates the desired modes, like ["editing", "interactive"] or ["planning", "one-shot"]
