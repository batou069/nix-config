{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # stylix.url = "github:nix-community/stylix/release-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixCats = {
         url = "github:BirdeeHub/nixCats-nvim/";
         inputs.nixpkgs.follows = "nixpkgs";
      };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral"; # Refers to the main branch and is updated to the latest commit when you use "nix flake update"
      # url = "github:cynicsketch/nix-mineral/v0.1.6-alpha" # Refers to a specific tag and follows that tag until you change it
      # url = "github:cynicsketch/nix-mineral/cfaf4cf15c7e6dc7f882c471056b57ea9ea0ee61" # Refers to a specific commit and follows that until you change it
      flake = false;
    };
    nix-software-center.url = "github:snowfallorg/nix-software-center";
  };

#   outputs = inputs @ {
#     self,
#     nixpkgs,
#     home-manager,
#     ags,
#     #"nixosModules.default = ./systemCat.nix";,
#     ...
#   }: let
#     system = "x86_64-linux";
#     host = "lf-nix";
#     username = "lf";

#     pkgs = import nixpkgs { inherit system; config = { allowUnfree = 
#       true;  };
#     };

#     homeManagerUserModule = {
#       home-manager.useGlobalPkgs = true;
#       home-manager.useUserPackages = true;
#       home-manager.users.${username} = import ./hosts/lf-nix/home.nix;
#       home-manager.extraSpecialArgs = {inherit inputs username;};
#       home-manager.backupFileExtension = "backup";
#       };
#   in {
#     nixosConfigurations = {
#       "${host}" = nixpkgs.lib.nixosSystem {
#         specialArgs = {
#           inherit system;
#           inherit inputs;
#           inherit username;
#           inherit host;
#         };
#         modules = [
#           ./hosts/lf-nix/config.nix
#           home-manager.nixosModules.home-manager
#           homeManagerUserModule
#         ];
#       };
#     };

#     homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
#       inherit pkgs;
#       modules = [
#         ./hosts/lf-nix/home.nix
#         {
#           home.username = username;
#           home.homeDirectory = "/home/${username}";
#           home.stateVersion = "25.05";
#         }
#       ];
#       extraSpecialArgs = {inherit inputs username;};
#     };
#   };
# }

outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, ags, nixCats, firefox-addons, nix-mineral, nix-software-center, ... }: let
    system = "x86_64-linux";
    host = "lf-nix";
    username = "lf";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    unstablePkgs = import nixpkgs-unstable { inherit system; };
    nvimConfigDir = "${builtins.getEnv "HOME"}/dotfiles/nvim/.config/nvim";
  in {
    packages.${system} = {
      my-nvim = nixCats.packages.${system}.nixCats {
        inherit pkgs;
        packageName = "my-nvim";
        neovim-unwrapped = pkgs.neovim-unwrapped;
        configDir = nvimConfigDir;
        extraPackages = with pkgs; [
          ripgrep # For telescope
          fd # For telescope
          python3 # Python provider and plugins like leetcode.nvim
          nodejs_20 # Node provider (use nodejs_20 for 25.05 compatibility)
          # Language servers for LSP support
          lua-language-server # For Lua development
          pyright # For Python (if used)
          # Add dependencies for specific plugins if available in 25.05
          obsidian # For obsidian.nvim (if it requires the Obsidian CLI)
          tree-sitter # For treesj.nvim and nvim-treesitter
          # Add more dependencies as needed (e.g., for golf.nvim if Go-related)
          go # Optional: for golf.nvim if it requires Go
        ];
        categories = {
          myConfig = {
            enable = true;
            # Rely on LazyVim's plugin manager, so no plugins listed here
            plugins = [];
            # Point to your LazyVim init.lua
            init = {
              enable = true;
              src = "${nvimConfigDir}/lazyvim/init.lua"; # Path to your init.lua
            };
            # Load your custom config and plugin files
            extraLua = ''
              -- Load custom config files
              require('config.autocmds')
              require('config.keymaps')
              require('config.lazy')
              require('config.options')
              -- Load custom plugins
        #      require('plugins.alpha')
        #      require('plugins.background')
              require('plugins.changes') -- Overrides LazyVim plugin settings
        #      require('plugins.comment-boxes')
        #      require('plugins.comment')
        #      require('plugins.cssview')
        #      require('plugins.golf')
        #      require('plugins.leetcode')
        #      require('plugins.mini-ai-surround')
        #      require('plugins.obsidian')
        #      require('plugins.rainbow-delimiters')
        #      require('plugins.treesj')
        #      require('plugins.yanky')
            '';
            pre = ''
              require('lazyvim.config').init()
              vim.opt.rtp:prepend('${nvimConfigDir}')
              dofile('${nvimConfigDir}/lazyvim/init.lua')
            '';            
          };
        };
      };
    };
    nixosConfigurations."${host}" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system inputs username host; };
      modules = [
        ./hosts/lf-nix/config.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = {
            imports = [ ./hosts/lf-nix/home.nix ];
          };
          home-manager.extraSpecialArgs = { inherit inputs username; };
        }
      ];
    };
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs username; };
      modules = [
        ./hosts/lf-nix/home.nix
        {
          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "25.05";
          home-manager.backupFileExtension = "backup"; 
        }
      ];
    };
  };
}
