{
  pkgs,
  username,
  ...
}: {
  # Home Manager version
  home.stateVersion = "24.11";

  # User information
  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [
    ./home/cli.nix
    ./home/vscode.nix
    # ./home/firefox
  ];

  fonts.fontconfig.enable = true;

  # User-specific packages
  home.packages = with pkgs; [
    # --- Fonts ---
    # General Purpose / Sans-Serif Fonts
    dejavu_fonts
    ibm-plex
    inter
    roboto

    # Monospace / Programming Fonts
    fira-code
    jetbrains-mono
    hackgen-nf-font
    roboto-mono
    terminus_font
    victor-mono
    nerd-fonts.im-writing
    nerd-fonts.fantasque-sans-mono

    # Icon / Symbol Fonts
    font-awesome
    fira-code-symbols
    material-icons
    powerline-fonts
    symbola

    # Noto Fonts
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji

    # Niche/Specific Fonts
    minecraftia

    eza
    fd
    # ripgrep
    repgrep
    # ripgrep-all
    alejandra
    pre-commit
    kdePackages.okular
    vgrep # User-friendly pager for grep/git-grep/ripgrep
    xonsh # Python-ish, BASHwards-compatible shell
    (python312.withPackages (
      ps:
        with ps; [
          requests
          pyquery
          jupyterlab
          jupyter
          matplotlib
          numpy
          pandas
          pillow
          plotly
          pytest
          seaborn
          python-dotenv
          regex
          tabulate
          ipykernel
          selenium
          beautifulsoup4
          pika
          pymongo
          lxml
          redis
          aiohttp
          networkx
          python-louvain
          neo4j
          mypy
          mypy-extensions
        ]
    ))
  ];

  home.sessionVariables = {
    P = "$HOME/git/py/";
    C = "$HOME/.config/";
    G = "$HOME/git/";
    R = "$HOME/repos/";
    O = "$HOME/Obsidian/";
    D = "$HOME/dotfiles/";
    N = "$HOME/NixOS-Hyprland/";
    TERM = "xterm-256color";
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  home.file.".pre-commit-config.yaml" = {
    source = ../../.pre-commit-config.yaml; # Path to the file in your dotfiles
    target = ".pre-commit-config.yaml";
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/markdown" = "code.desktop";
        "text/plain" = "code.desktop";
        "text/x-csv" = "code.desktop";
        "text/x-log" = "code.desktop";
        "text/x-patch" = "code.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/mailto" = "firefox.desktop";
        "x-scheme-handler/vscode" = "vscode.desktop";
        "image/jpeg" = "loupe.desktop";
        "image/png" = "loupe.desktop";
        "image/gif" = "loupe.desktop";
        "image/bmp" = "loupe.desktop";
        "image/svg+xml" = "loupe.desktop";
        "application/pdf" = "org.kde.okular.desktop";
        "application/xml" = "code.desktop";
        "application/x-yaml" = "code.desktop";
        "application/json" = "code.desktop";
        "image/avif" = "loupe.desktop";
        "audio/*" = ["vlc.desktop"];
        "video/*" = ["vlc.desktop"];
        # "image/heif" = "org.kde.gwenview.desktop";
        # "image/x-icns" = "loupe.desktop";
        # "inode/directory" = "org.kde.dolphin.desktop";
      };
    };
    userDirs = {
      enable = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      # publicShare = "$HOME/";
      # templates = "$HOME/";
      videos = "$HOME/Videos";
    };

    configFile = {
      "mimeapps.list".force = true;
    };
  };
}
