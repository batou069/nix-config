{
  inputs = {
    dotfiles-src = {
      url = "path:/home/lf/dotfiles";
      flake = false;
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix/release-25.05";
    # ags = {
    #   url = "github:aylur/ags/v1";
    #   # url = "github:aylur/ags";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
    hyprland.url = "github:hyprwm/Hyprland/v0.50.0";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins/v0.50.0";
      inputs.hyprland.follows = "hyprland";
    };
    # hypr-dynamic-cursors = {
    #   url = "github:VirtCode/hypr-dynamic-cursors";
    #   inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    # };
    hy3 = {
      url = "github:outfoxxed/hy3/hl0.50.0";
      inputs.hyprland.follows = "hyprland";
    };
    # pyprland.url = "github:hyprland-community/pyprland";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    # hyprpanel = {
    #   url = "github:Jas-SinghFSU/HyprPanel";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser = {
    #   url = "github:benjaminkitt/zen-browser-flake";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Vicinae
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
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
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # mango = {
    #   url = "github:DreamMaoMao/mangowc";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-mcp-servers = {
      url = "github:cameronfyfe/nix-mcp-servers";
    };
    hyprviz.url = "github:timasoft/hyprviz";
    serena = {
      url = "github:oraios/serena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule

        (import ./modules/import-tree.nix inputs.nixpkgs.lib ./home)

        ./modules/per-system.nix
        ./modules/nixos-hosts.nix
      ];

      systems = [ "x86_64-linux" ];
    };
}
