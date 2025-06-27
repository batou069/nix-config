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
    ./home/bat.nix
    ./home/lsd.nix
    ./home/fzf.nix
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

    lsd
    eza
    fd
    # ripgrep
    repgrep
    # ripgrep-all
    alejandra
    pre-commit
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
}
