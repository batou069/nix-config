{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix/release-25.05";
    ags = {
      # url = "github:aylur/ags/v1";
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };
    disko.url = "github:nix-community/disko";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    sops-nix.url = "github:Mic92/sops-nix";
    flake-utils.url = "github:numtide/flake-utils";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claudia = {
      url = "github:getAsterisk/claudia/218ecfb8b2069b69e4c40734e178e2a6af9fced7";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    };
    pyprland.url = "github:hyprland-community/pyprland";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    # catppuccin.url = "github:catppuccin/nix";
    # neovim = {
    #   url = github:neovim/neovim/contrib;
    # };
    # gemini-cli = {
    #   url = "github:novel2430/gemini-cli";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    # ags,
    disko,
    sops-nix,
    nur,
    stylix,
    mcp-servers-nix,
    # catppuccin,
    hyprland,
    pyprland,
    ...
  }: let
    # Function to generate a NixOS system configuration
    mkNixosSystem = {
      system,
      host,
      username,
    }:
      nixpkgs.lib.nixosSystem {
        # Pass all flake inputs to modules via specialArgs.
        # This is the standard way to make them available where needed.
        specialArgs = {inherit inputs username host system;};

        modules = [
          # Now, import all necessary modules.
          # They can access the inputs via the `inputs` argument
          # that specialArgs provides.
          disko.nixosModules.default
          sops-nix.nixosModules.sops # Corrected module name
          # nur.nixosModules.nur
          nur.modules.nixos.default
          # nur.legacyPackages."${system}".repos.7mind.ibkr-tws
          stylix.nixosModules.stylix
          # Your custom host and user configurations
          ./hosts/${host}/config.nix
          ./hosts/${host}/sops.nix
          # catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          # Pass the final pkgs set to Home Manager modules.
          ({ pkgs, nixpkgs-unstable, ... }: {
            home-manager = {
              useGlobalPkgs = false;
              useUserPackages = true;
              backupFileExtension = "backup";
              # Pass final pkgs and other inputs to Home Manager modules.
              extraSpecialArgs = { inherit inputs username system pkgs nixpkgs-unstable; };
              users.${username} = {
                imports = [
                  ./pkgs/home.nix
                  # catppuccin.homeManagerModules.catppuccin
                ];
              };
            };
          })
        ];
      };
  in {
    nixosConfigurations = {
      "lf-nix" = mkNixosSystem {
        system = "x86_64-linux";
        host = "lf-nix";
        username = "lf";
      };

      "viech" = mkNixosSystem {
        system = "x86_64-linux";
        host = "viech";
        username = "lf";
      };
    };
  };
}
