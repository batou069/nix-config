{
  pkgs,
  lib,
  username,
  ...
}: {
  # Home Manager version
  home.stateVersion = "24.11";

  # Enable automatic backup of conflicting files
  home.backupFileExtension = "backup";

  # User information
  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [
    ./home/bat.nix
    ./home/lsd.nix
    ./home/fzf.nix
  ];

  fonts.fontconfig.enable = true;
  fonts.packages = lib.flatten [
    (with pkgs; [
      # General Purpose / Sans-Serif Fonts
      dejavu_fonts
      ibm-plex
      inter
      roboto
    ])

    (with pkgs; [
      # Monospace / Programming Fonts
      fira-code
      jetbrains-mono
      hackgen-nf-font
      maple-mono.NF
      roboto-mono
      terminus_font
      victor-mono
    ])

    # Nerd Fonts (patched fonts with icons)
    (with pkgs.nerd-fonts; [ # This 'with' applies only to this list
      im-writing
      blex-mono
      fantasque-sans-mono
    ])

    (with pkgs; [
      # Icon / Symbol Fonts
      font-awesome
      fira-code-symbols
      material-icons
      powerline-fonts
      symbola
    ])

    (with pkgs; [
      # Noto Fonts
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-monochrome-emoji
    ])

    (with pkgs; [
      # Niche/Specific Fonts
      minecraftia
    ])
  ];
  
  # User-specific packages
  home.packages = with pkgs; [
    lsd
    eza
    fd
    ripgrep
    repgrep
    ripgrep-all
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
        ]))
  ];

  home.file.".pre-commit-config.yaml" = {
    source = ../../.pre-commit-config.yaml; # Path to the file in your dotfiles
    target = ".pre-commit-config.yaml";
  };

  # programs.neovim = {
  #   enable = true;
  #   withPython3 = true;
  #   defaultEditor = true;
  # };
}