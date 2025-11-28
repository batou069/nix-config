# modules/lib-helpers.nix
#
# Helper functions for working with flake inputs in overlays and modules.
{ system, ... }: {
  # Extract overlay from a flake input (for inputs that provide overlays)
  # Usage: libOverlay inputs.nur
  libOverlay = input:
    input.overlays.default or input.overlay or (_: _: { });

  # Get the default package from a flake input
  # Usage: libPkg inputs.claudia
  libPkg = input:
    input.packages.${system}.default
      or (throw "Flake has no packages.${system}.default");

  # Get all packages for the current system from a flake input
  # Usage: libPkgs inputs.firefox-addons
  libPkgs = input:
    input.packages.${system}
      or (throw "Flake has no packages.${system}");

  # Helper to build a vim plugin from source
  # Usage: mkVimPlugin pkgs "plugin-name" inputs.plugin-source
  mkVimPlugin = pkgs: name: src:
    pkgs.vimUtils.buildVimPlugin {
      pname = name;
      version = "latest";
      inherit src;
    };

  # Smart vim plugin helper - auto-detects input type
  # Usage: libVimPlugin pkgs inputs.some-plugin "some-plugin"
  #
  # Handles:
  # - Flake with packages.${system}.default (like blink-cmp)
  # - Source-only input with flake=false (like avante-nvim, none-ls-nvim)
  libVimPlugin = pkgs: input: name:
    if input ? packages.${system}.default
    then
    # Input is a flake with proper packages output
      input.packages.${system}.default
    else if !(input ? outputs) && input ? outPath
    then
    # Input is source-only (flake = false) - no outputs attr but has outPath
      pkgs.vimUtils.buildVimPlugin
        {
          pname = name;
          version = "latest";
          src = input;
        }
    else throw "Cannot create vim plugin from input '${name}': not a package flake or source-only input";
}
