{ inputs, ... }: {
  exports.perSystem =
    { config
    , pkgs
    , ...
    }:
    let
      pkgs-unfree = import inputs.nixpkgs {
        system = pkgs.system;
        config.allowUnfree = true;
      };
    in
    {
      packages = {
        vscode-fhs = pkgs-unfree.vscode-fhs;
      };

      # Configure treefmt-nix
      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          # FOR NIX
          alejandra.enable = true;
          deadnix.enable = true;
          nixpkgs-fmt.enable = true;

          # For Python files
          # ruff.enable = true;
          ruff.check = true;
          ruff.format = true;
          # For Shell scripts
          shfmt.enable = true;
          # For Markdown, JSON, YAML, etc.
          prettier.enable = true;
          # For SQL & co
          sqlfluff.enable = true;
          # Lua
          stylua.enable = true;
          # Fish
          fish_indent.enable = true;
          # Dockerfiles
          dockfmt.enable = true;
        };
        settings.formatter.ruff-check.priority = 1;
        settings.formatter.ruff-format.priority = 2;
      };

      devShells.default = pkgs.mkShell {
        name = "nix-config-shell";
        inputsFrom = [ config.treefmt.package ];
        packages = [ pkgs.pre-commit ];
        shellHook = ''
          echo "Welcome to the Nix config dev shell!"

          menu() {
            echo "Available commands:"
            echo "  run        # Start the server (not implemented)"
            echo "  run-tests  # Run all tests (not implemented)"
            echo "  lint       # Format and check code"
            echo "  typecheck  # Check types (not implemented)"
          }

          lint() {
            treefmt
          }

          echo "Run 'menu' to see available commands."
        '';
      };
    };
}
