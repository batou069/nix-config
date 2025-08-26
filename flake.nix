{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix/release-25.05";
    ags = {
      url = "github:aylur/ags/v1";
      # url = "github:aylur/ags";
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
    # hyprpanel = {
    #   url = "github:Jas-SinghFSU/HyprPanel";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    flake-parts.url = "github:hercules-ci/flake-parts";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #plugins list
    avante-nvim = {
      url = "github:yetone/avante.nvim";
      flake = false;
    };
    minuet-ai-nvim = {
      url = "github:milanglacier/minuet-ai.nvim";
      flake = false;
    };
    blink-cmp.url = "github:saghen/blink.cmp";
    vim-translator = {
      url = "github:voldikss/vim-translator";
      flake = false;
    };
    none-ls-nvim = {
      url = "github:nvimtools/none-ls.nvim";
      flake = false;
    };
    nui-nvim = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    # emacs-overlay = {
    #   url = "github:nix-community/emacs-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # doom-emacs = {
    #   url = "github:nix-community/nix-doom-emacs";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ags,
    disko,
    sops-nix,
    nur,
    stylix,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {pkgs, ...}: let
        pkgs-unfree = import inputs.nixpkgs {
          system = pkgs.system;
          config.allowUnfree = true;
        };
      in {
        packages = {
          vscode-fhs = pkgs-unfree.vscode-fhs;
        };
      };

      flake = let
        mkNixosSystem = {
          system,
          host,
          username,
        }:
          nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs username host system;};

            modules = [
              disko.nixosModules.default
              sops-nix.nixosModules.sops
              nur.modules.nixos.default
              stylix.nixosModules.stylix
              ./hosts/${host}/config.nix
              ./hosts/${host}/sops.nix
              home-manager.nixosModules.home-manager
              ({
                pkgs,
                nixpkgs-unstable,
                ...
              }: {
                home-manager = {
                  useGlobalPkgs = false;
                  useUserPackages = true;
                  backupFileExtension = "backup";
                  extraSpecialArgs = {inherit inputs username system pkgs nixpkgs-unstable;};
                  users.${username} = {
                    imports = [
                      ./pkgs/home.nix
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
    };
}
