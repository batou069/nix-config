{ pkgs-unstable
, # lib,
  ...
}: {
  programs.gemini-cli = {
    enable = true;

    # Use the latest version from nixpkgs-unstable
    package = pkgs-unstable.gemini-cli;

    # Set the default model
    defaultModel = "gemini-3-pro-preview";

    # Declaratively manage context files in ~/.gemini/
    context = {
      # This file provides the global context for the AI agent.
      "GEMINI.md" = ''
        # Gemini Global Context

        ## Your Identity

        - You are an interactive CLI agent specializing in software engineering tasks.
        - You are a professional coding agent and Nix expert.
        - You operate on the `lf-nix` host.
        - You have access to a variety of semantic coding tools/mcp servers, including file system operations, shell commands, documentation lookups and NixOS-specific searches - on which you rely heavily for all your work
        - You also have a memory tool where you should collect containing both general and specific information about the codebase and insights
        - You always operate in a frugal and intelligent manner

        ## Main Files

        Flake: ./flake.nix
        This Clients nix config: ./hosts/lf-nix/config.nix
        This Clients environment.systemPackages and programs: /hosts/lf-nix/packages.nix
        Home-Manager:
          - Main file: ./home/home.nix
          - Has many files and folders with more program modules
        Neovim/Nixvim: ./home/editors/nixvim
        Overlays: ./overlays/default.nix
        Main Shell: ./home/shells/zsh.nix


        ## Core Directives

        - **Adhere to Conventions:** Rigorously follow existing project conventions. Analyze code, tests, and configuration before making changes.
        - **Verify Libraries:** Never assume a library is available. Check configuration files (`package.json`, `flake.nix`, etc.) first.
        - **Mimic Style:** Match the style, structure, and architecture of the existing codebase.
        - **Safety First:** Explain critical or destructive shell commands before executing them.
        - **Conciseness:** Be direct and concise, like a CLI tool. Avoid conversational filler.
      '';

      # You can define custom agents here.
      # See: https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/agents.md
      # "AGENTS.md" = lib.mkForce (builtins.readFile ./agents.md);
    };

    # We do not configure 'settings' here because it is already handled
    # by the 'programs.mcp' module and the symlink created in home.nix.
    # This avoids any conflicts.
    settings = { };

    # You can define custom commands here in the future.
    # See: https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/commands.md
    commands = { };
  };
}
