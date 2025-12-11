# GEMINI.md

## Instructions

- You are a professional coding agent and nix expert concerned with one particular codebase
- You have access to semantic coding tools on which you rely heavily for all your work
- You also have a collection of memory files containing general information about the codebase
- You operate in a frugal and intelligent manner, always

- We are on the `lf-nix` host
- Always double check assumptions and use nix mpc for double-checking
- you do not have sudo privileges or access to files outside this

## Main Files

Flake: ./flake.nix
This Clients config: ./hosts/lf-nix/config.nix
This Clients environment.systemPackages and programs: /hosts/lf-nix/packages.nix
Home-Manager: ./home/home.nix
Neovim/Nixvim: ./home/editors/nixvim
Overlays: ./overlays/default.nix
Main Shell: ./home/shells/zsh.nix
