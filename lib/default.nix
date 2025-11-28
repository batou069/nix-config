# lib/default.nix
{ inputs, ... }:
let
  lib = inputs.nixpkgs.lib;
in
lib
  // rec {
  # System types to support.
  supportedSystems = [ "x86_64-linux" ];

  # Helper function to generate an attrset for each system.
  forAllSystems = lib.genAttrs supportedSystems;

  # Define our custom helpers in one place
  lib-helpers = system: import ../modules/lib-helpers.nix { inherit inputs system; };

  # Function to generate the configured nixpkgs set for a given system
  mkPkgs = system:
    let
      helpers = lib-helpers system;
    in
    import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = import ../overlays/default.nix {
        inherit inputs system;
        inherit (helpers) libOverlay libPkg libPkgs libVimPlugin mkVimPlugin;
      };
    };

  # Generate pkgs for all supported systems
  pkgsBySystem = forAllSystems mkPkgs;

  # --- BUILDER FUNCTIONS ---

  # Builder for NixOS systems
  buildNixosSystem =
    { system
    , host
    , username
    , modules ? [ ]
    , specialArgs ? { }
    , inputs
    , # Add inputs as a direct argument
    }:
    let
      pkgs = pkgsBySystem.${system};
      helpers = lib-helpers system;
    in
    lib.nixosSystem {
      specialArgs =
        specialArgs
        // {
          inherit
            inputs
            username
            host
            system
            ;
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config = pkgs.config;
            overlays = pkgs.overlays;
          };
          dotfiles = inputs.dotfiles-src;
          libOverlay = helpers.libOverlay;
          libPkg = helpers.libPkg;
        };
      modules =
        modules
        ++ [
          ../modules/nixos-sops.nix
          # Set nixpkgs.pkgs to use our pre-configured pkgs with overlays
          # Note: External modules (stylix, NUR) may add their own overlays
          { nixpkgs.pkgs = pkgs; }
          inputs.musnix.nixosModules.musnix
          inputs.hyprland.nixosModules.default
          inputs.disko.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          inputs.nur.modules.nixos.default
          inputs.stylix.nixosModules.stylix
          ../hosts/${host}/config.nix
        ];
    };

  # Builder for standalone Home Manager configurations
  buildHomeConfiguration =
    { system
    , username
    , modules ? [ ]
    , extraSpecialArgs ? { }
    , inputs
    , # Add inputs as a direct argument
    }:
    let
      pkgs = pkgsBySystem.${system};
      helpers = lib-helpers system;
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs-unstable {
        inherit system;
        config = pkgs.config;
        overlays = pkgs.overlays;
      };
      extraSpecialArgs =
        extraSpecialArgs
        // {
          inherit
            inputs
            system
            username
            ;
          dotfiles = inputs.dotfiles-src;
          libOverlay = helpers.libOverlay;
          libPkg = helpers.libPkg;
        };
      modules =
        [
          # 1. Load sops configuration first
          ../modules/hm-sops.nix
          # 2. Load the sops-nix module itself
          inputs.sops-nix.homeManagerModules.sops
          # 3. Load other common modules
          inputs.nur.modules.homeManager.default
          inputs.nix-doom-emacs-unstraightened.homeModule
        ]
        # 4. Finally, load the host-specific modules (like home.nix)
        ++ modules;
    };
}
