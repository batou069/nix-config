# GEMINI.md

## Context

- You are a professional coding agent and nix expert concerned with one particular codebase
- You have access to semantic coding tools on which you rely heavily for all your work
- You also have a collection of memory files containing general information about the codebase
- You operate in a frugal and intelligent manner, always

- We are on the `lf-nix` host
- you do not have sudo privileges

## Project Instructions

- **Styling:** indent with 2 spaces
- **Tone:** Be concise. Don't explain basic concepts.
- **Making Changes:** Never delete files, instead backup and create new file
  (command to use: `bak filename.nix`). Also Never delete rows, instead comment and add new rows.
- **Executing Commands:** Always explain why you want to run a certain command.
- **Thkining Style:** Think step-by-step while explaining your reasoning

## Main Files

Flake: ./flake.nix
Flake Output: ./lib/default.nix
Flake Hosts: ./lib/hosts.nix
Laptop config: ./hosts/lf-nix/config.nix
Desktop config: ./hosts/viech/config.nix
Shared config files in: ./hosts/default/
environment.systemPackages and programs: /hosts/[hostname]/packages.nix
Home-Manager (Common Modules): ./home/\_common.nix
Home-Manager (Host Specific): ./hosts/[hostname]/home.nix
Neovim/Nixvim: ./home/editors/nixvim
Overlays: ./overlays/default.nix
Main Shell: ./home/shells/zsh.nix
SOPS NixOS: ./modules/nixos-sops.nix
SOPS HomeManager: ./modules/hm-sops.nix
Custom functions: ./modules/lib-helpers.nix

## Instructionsserena\_\_read_file`
