{
  pkgs,
  config,
  username,
  ...
}: {
  # Home Manager version
  home.stateVersion = "24.11";

  # User information
  home.username = username;
  home.homeDirectory = "/home/${username}";
  
  fonts.fontconfig.enable = true;
  # fonts.packages = with pkgs; [
  #   dejavu_fonts
  #   fira-code
  #   fira-code-symbols
  #   font-awesome
  #   hackgen-nf-font
  #   ibm-plex
  #   inter
  #   jetbrains-mono
  #   material-icons
  #   maple-mono
  #   minecraftia
  #   nerd-fonts.im-writing
  #   nerd-fonts.blex-mono
  #   noto-fonts
  #   noto-fonts-emoji
  #   noto-fonts-cjk-sans
  #   noto-fonts-cjk-serif
  #   noto-fonts-monochrome-emoji
  #   powerline-fonts
  #   roboto
  #   roboto-mono
  #   symbola
  #   terminus_font
  #   victor-mono
  #   nerd-fonts.fantasque-sans-mono
  # ];

  imports = [
    ./home/bat.nix
    ./home/lsd.nix
    ./home/fzf.nix
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
    (python312.withPackages (ps:
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
      ]))
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

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    # Define your VS Code settings here
    profiles.default = {
      userSettings = {
        "editor.fontFamily" = "Maple Mono NF";
        "editor.fontVariations" = "Medium Italic";
        "editor.fontLigatures" = "calt";
        "editor.fontSize" = 14;
        "editor.tabSize" = 2;
        "[docker-compose]" = {
          "editor.defaultFormatter" = "KilianJPopp.docker-compose-support";
          "editor.formatOnSave" = true;
        };
        "docker-compose.format.enabled" = true;
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nixd.formatting.command" = ["alejandra"];
        };
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
        };
        "git.openRepositoryInParentFolders" = "always";
        "workbench.iconTheme" = "vscode-icons";
        "vsicons.dontShowNewVersionMessage" = true;
        "workbench.colorTheme" = "Catppuccin Mocha";
        "python.defaultInterpreterPath" = "${pkgs.python312}/bin/python3";
      };
      languageSnippets = {
        python = {
          "AI3 Header" = {
            "body" = [
              "\"\"\""
              "Title = \${1: 'Enter a Title'}"
              "\${2|Exercise,Quiz|} = $3"
              "Description = \${4: 'And now a description'}"
              ""
              "Author = Laurent Flaster"
              "Reviewer = \${6: 'Lucky who?'}"
              ""
              "Infinity Labs R&D AI3"
              "\"\"\""
              ""
              "\${7: import} $0"
            ];
            "description" = ["Insert AI3 Doc string."];
            "prefix" = ["ai3"];
          };
        };
      };
      extensions = with pkgs.vscode-extensions; [
        vscode-icons-team.vscode-icons
        github.copilot
        github.copilot-chat
        ms-python.python
        ms-python.debugpy
        charliermarsh.ruff
        ms-python.pylint
        ms-python.vscode-pylance
        ms-python.mypy-type-checker
        jnoortheen.nix-ide
        kamadorueda.alejandra
        jeff-hykin.better-nix-syntax
        sumneko.lua
        ms-toolsai.jupyter
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-keymap
        ms-azuretools.vscode-docker
        bungcip.better-toml
        zainchen.json
        vscodevim.vim
        visualstudioexptteam.intellicode-api-usage-examples
        tekumara.typos-vscode
        rubymaniac.vscode-paste-and-indent
        richie5um2.snake-trail
        naumovs.color-highlight
        mongodb.mongodb-vscode
        mishkinf.goto-next-previous-member
        catppuccin.catppuccin-vsc
        njpwerner.autodocstring
      ];
    };
  };
  # programs.home-manager.enable = true;
}
