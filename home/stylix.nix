{ ... }: {
  stylix = {
    enable = true;
    enableReleaseChecks = false;
    autoEnable = true;
    targets = {
      ghostty.enable = false;
      bat.enable = false;
      tmux.enable = false;
      neovim = {
        enable = false;
        # plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          numberLine = true;
          signColumn = true;
        };
      };
      starship.enable = false;
      wofi.enable = false;
      fzf.enable = false;
      hyprland.enable = false;
      vscode.enable = false;
      kitty.enable = true;
    };
    base16Scheme = ../assets/base16_themes/catppuccin-macchiato.yaml;
    image =
      ../assets/wallpapers/astronaut_jellyfish.jpg; # ../../assets/base16_themes/cupcake.yaml;

    targets.qt.platform = lib.mkForce "qtct";
    polarity = "dark";
    targets.font-packages.enable = true;

    icons = {
      enable = true;
      package = pkgs.juno-theme;
      dark = "Juno-ocean";
      light = "Juno-mirage";
    };

    # rose-pine-cursor , bibata-cursors, phinger-cursors-dark
    cursor = {
      name = "Rose Pine";
      size = 40;
      package = pkgs.rose-pine-cursor;
    };

    opacity = {
      applications = 1.5;
      desktop = 1.5;
      popups = 0.8;
      terminal = 1.0;
    };

    fonts = {
      sansSerif = {
        # package = pkgs.aleo-fonts;
        # name = "Aleo";
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      serif = {
        # package = pkgs.noto-fonts-cjk-sans;
        # name = "Noto Sans CJK JP";
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF Bold";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 10;
        desktop = 12;
        popups = 14;
        terminal = 14;
      };
    };
  };
}
