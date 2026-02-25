{ pkgs
, pkgs-stable
, inputs
, libPkg
, libPkgs
, ...
}:
let
  r-with-packages = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      IRkernel
      tidyverse
      lubridate
      modelr
      caTools
      psych
      # devtools
      sandwich
      lemon
      gridExtra
      arm
      broom
      boot
      RcppEigen
      lme4
    ];
  };
in
{
  environment.systemPackages =
    (with pkgs; [
      (libPkg inputs.quickshell)
      lynx
      gh
      sqlite
      # Qt6 dependencies for quickshell
      qt6.qtbase
      qt6.qtdeclarative
      qt6.qtwayland
      qt6.qtsvg
      qt6.qtmultimedia

      chafa
      viu
      ueberzugpp
      overskride
      ksnip
      ytmdl
      influxdb3
      pstree
      # games

      code-cursor-fhs

      dreamchess
      lc0
      stockfish
      pandoc
      emojify
      oath-toolkit
      smassh
      pastel
      catppuccin-plymouth
      cargo-seek
      # System Packages
      alsa-utils
      isd # interactively interact with systemd
      baobab
      btrfs-progs
      clang

      # (callPackage ../../overlays/wrapped-mcp-server-memory.nix {
      #   original-mcp-server-memory = (libPkgs inputs.nix-mcp-servers).mcp-server-memory;
      # })
      # mcp-server-git
      # tavily-mcp
      # github-mcp-server

      jrnl
      cpufrequtils
      duf # Utility For Viewing Disk Usage In Terminal
      findutils
      ffmpeg
      pkg-config
      gsettings-qt
      git
      git-credential-manager
      killall
      libappindicator
      libnotify
      openssl # required by Rainbow borders
      pciutils
      wget
      xdg-user-dirs
      xdg-utils
      linux-firmware
      d2

      # (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
      # ranger
      (libPkg inputs.zen-browser)
      # Hyprland Stuff
      #ags
      # inputs.ags.packages.${pkgs.system}.default
      nix-your-shell
      btop
      brightnessctl # for brightness control
      cava
      # cliphist
      loupe
      gnome-system-monitor
      grim
      gtk-engine-murrine # for gtk themes
      hypridle
      imagemagick
      inxi

      ijq
      manix
      mediainfo

      libsForQt5.qtstyleplugin-kvantum # kvantum
      networkmanagerapplet
      nwg-displays
      nvtopPackages.full
      pamixer
      pavucontrol
      playerctl
      polkit_gnome
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum # kvantum
      rofi
      slurp
      swaynotificationcenter
      unzip
      wallust
      wl-clipboard
      wlogout
      xarchiver
      yad
      yt-dlp
      stow # Manage dotfiles symlinking
      gnome-font-viewer
      fx
      yq-go
      figlet
      # uv # Python Package Manager & more
      gedit # Editor Gui
      vlc # Video Player
      obsidian
      # rofi-obsidian
      foot # terminal
      calibre # ebooks manager
      # nyxt
      # qutebrowser
      tradingview
      nix-init # create pkg from url
      vulnix # vulnerability scanner

      lazycli
      lazydocker
      lazyjournal
      bitwarden-menu
      chromium
      # lagrange # Gemini browser
      # from ZaneyOS
      zsh-fzf-tab
      appimage-run # Needed For AppImage Support
      hyprpicker # Color Picker
      grimblast # Screenshots
      nix-init # Screenshots
      lshw # Detailed Hardware Information
      ncdu # Disk Usage Analyzer With Ncurses Interface
      picard # For Changing Music Metadata & Getting Cover Art
      usbutils # Good Tools For USB Devices
      # gcr
      # Dev Stuff
      # nh

      androidenv.androidPkgs.platform-tools
      meowpdf

      file-roller

      gnome-calculator
      nautilus

      seahorse
      brightnessctl

      nixfmt
      nixd
      bc
      curl
      glib # for gsettings to work
      fastfetch
      jq
      nwg-look
      swww
      nix-search-tv
      bitwarden-cli
      bitwarden-desktop
      twingate
      hyprls
      pipx
      lm_sensors # Used For Getting Hardware Temps
      sof-firmware
      (libPkg inputs.hyprviz)
      (libPkg inputs.rose-pine-hyprcursor)
      hyprshade
      antigravity
    ])
    ++ (with pkgs-stable; [ ])
    ++ [
      r-with-packages # Add the R environment
    ]
    ++ (with libPkgs inputs.llm-agents; [



      # AI Coding Agents
      amp           # CLI for Amp, an agentic coding tool in research preview from Sourcegraph
      claude-code   # Agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster
      code          # Fork of codex. Orchestrate agents from OpenAI, Claude, Gemini or any provider.
      codex         # OpenAI Codex CLI # a coding agent that runs locally on your computer
      copilot-cli   # GitHub Copilot CLI brings the power of Copilot coding agent directly to your terminal.
      crush         # The glamourous AI coding agent for your favourite terminal
      cursor-agent  # Cursor Agent # CLI tool for Cursor AI code editor
      droid         # Factory AI's Droid # AI-powered development agent for your terminal
      eca           # Editor Code Assistant (ECA) # AI pair programming capabilities agnostic of editor
      forge         # AI-Enhanced Terminal Development Environment # A comprehensive coding agent that integrates AI capabilities with your development environment
      # gemini-cli    # AI agent that brings the power of Gemini directly into your terminal
      goose-cli     # CLI for Goose # a local, extensible, open source AI agent that automates engineering tasks
      jules         # Jules, the asynchronous coding agent from Google, in the terminal
      kilocode-cli  # The open-source AI coding agent. Now available in your terminal.
      letta-code    # Memory-first coding agent that learns and evolves across sessions
      mistral-vibe  # Minimal CLI coding agent by Mistral AI # open-source command-line coding assistant powered by Devstral
      nanocoder     # A beautiful local-first coding agent running in your terminal # built by the community for the community ⚒
      opencode      # AI coding agent built for the terminal
      pi            # A terminal-based coding agent with multi-model support
      qoder-cli     # Qoder AI CLI tool # Terminal-based AI assistant for code development
      qwen-code     # Command-line AI workflow tool for Qwen3-Coder models

      # Claude Code Ecosystem
      catnip              # Developer environment that's like catnip for agentic programming
      ccstatusline        # A highly customizable status line formatter for Claude Code CLI
      # claude-code-npm     # Agentic coding tool (Node.js/npm build for claudebox compatibility)
      claude-code-router  # Use Claude Code without an Anthropics account and route it to another LLM provider
      claude-plugins      # CLI tool for managing Claude Code plugins
      claudebox           # Sandboxed environment for Claude Code
      sandbox-runtime     # Lightweight sandboxing tool for enforcing filesystem and network restrictions
      skills-installer # Install agent skills across multiple AI coding clients
      # ACP Ecosystem
      claude-code-acp # An ACP-compatible coding agent powered by the Claude Code SDK (TypeScript)
      codex-acp       # An ACP-compatible coding agent powered by Codex

      # Usage Analytics
      ccusage           # Usage analysis tool for Claude Code
      ccusage-amp       # Usage analysis tool for Amp CLI sessions
      ccusage-codex     # Usage analysis tool for OpenAI Codex sessions
      ccusage-opencode  # Usage analysis tool for OpenCode sessions
      ccusage-pi        # Pi-agent usage tracking for Claude Max

      # Workflow & Project Management
      backlog-md  # Backlog.md # A tool for managing project collaboration between humans and AI Agents in a git ecosystem
      beads       # A distributed issue tracker designed for AI-supervised coding workflows
      cc-sdd      # Spec-driven development framework for AI coding agents
      chainlink   # Simple, lean issue tracker CLI designed for AI-assisted development
      openspec    # Spec-driven development for AI coding assistants
      spec-kit    # Specify CLI, part of GitHub Spec Kit. A tool to bootstrap your projects for Spec-Driven Development (SDD)
      agent-deck # Your AI agent command center
      vibe-kanban # Kanban board to orchestrate AI coding agents like Claude Code, Codex, and Gemini CLI
      workmux # Git worktrees + tmux windows for zero-friction parallel dev




      # Code Review
      coderabbit-cli  # AI-powered code review CLI tool
      tuicr           # Review AI-generated diffs like a GitHub pull request, right from your terminal

      # Utilities
      agent-browser             # Headless browser automation CLI for AI agents
      ck                        # Local first semantic and hybrid BM25 grep / search tool for use by AI and humans!
      openclaw               # Personal AI assistant with WhatsApp, Telegram, Discord integration
      coding-agent-search       # Unified, high-performance TUI to index and search your local coding agent history
      copilot-language-server   # GitHub Copilot Language Server # AI pair programmer LSP
      handy                     # Fast and accurate local transcription app using AI models
      happy-coder               # Happy Coder CLI to connect your local Claude Code to mobile device
      openskills                # Universal skills loader for AI coding agents # install and load Anthropic SKILL.md format skills in any agent
      qmd                       # mini cli search engine for your docs, knowledge bases, meeting notes, whatever. Tracking current sota approaches while being all local
    ]);

  programs = {

#    adb.enable = true;
    dms-shell = {
      systemd.restartIfChanged = true;
      enableSystemMonitoring = true;
      enableDynamicTheming = true;
      enableCalendarEvents = true;
      enableAudioWavelength = true;
      enable = true;
    };
    zsh.enableCompletion = false;
    bash.blesh.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    zoom-us.enable = true;
    # mangowc.enable = true;

    xonsh = { enable = true; };
    hyprlock.enable = true;

    thunar = {
      enable = true;
      # thunar.
      plugins = with pkgs; [
        xfce4-exo
        mousepad
        thunar-archive-plugin
        thunar-volman
        tumbler
        thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };
    virt-manager.enable = false;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      # dedicatedServer.openFirewall = false;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    firefox.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # services = {
  # aria2 = {
  #   enable = true;
  #   rpcSecretFile = "${config.users.users.${username}.home}/.config/aria2-rpc-secret";
  #   # settings = {
  #   #   dir = "${config.users.users.${username}.home}/Downloads/aria2";
  #   #   enable-rpc = true;
  #   # };
  # };
  # };

  # # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    # wlr.enable = false;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # configPackages =
    # [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    #   config.common.default = "hyprland";
    #   config."org.freedesktop.impl.portal.FileChooser".default = "gtk";
  };
}
