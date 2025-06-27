{
  pkgs,
  username,
  ...
}: {
  # Home Manager version
  home.stateVersion = "25.05";

  # User information
  home.username = username;
  home.homeDirectory = "/home/${username}";
# home.backupFileExtension = "backup";  # Add this
  imports = [
    ./home/cli.nix
    ./home/vscode.nix
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
    maple-mono.NF

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
    
    fd
   # repgrep # Interactive replacer for ripgrep that makes it easy to find and replace across files on the command line
   # ripgrep-all # Ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, and more
    alejandra
    pre-commit
    kdePackages.okular
    grip-grab # Fast, more lightweight ripgrep alternative for daily use cases
    vgrep # User-friendly pager for grep/git-grep/ripgrep
    xonsh # Python-ish, BASHwards-compatible shell
    (python312.withPackages (
      ps:
        with ps; [
          requests
          pyquery
          jupyterlab
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
        ]
    ))
  ];

  home.file.".pre-commit-config.yaml" = {
    source = ../../.pre-commit-config.yaml; # Path to the file in your dotfiles
    target = ".pre-commit-config.yaml";
  };

  programs.neovim = {
    enable = true;
    withPython3 = true;
    defaultEditor = true;
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
        "image/avif" = "loupe.desktop";
        # "image/heif" = "org.kde.gwenview.desktop";
        # "image/x-icns" = "loupe.desktop";
        # "inode/directory" = "org.kde.dolphin.desktop";
      };
    };
    userDirs = {
      enable = true;
      desktop = "$HOME/";
      documents = "$HOME/";
      download = "$HOME/downloads";
      music = "$HOME/";
      pictures = "$HOME/";
      publicShare = "$HOME/";
      templates = "$HOME/";
      videos = "$HOME/";
    };

    configFile = {
      "mimeapps.list".force = true;
    };
  };

}

