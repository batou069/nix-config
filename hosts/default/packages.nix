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
      amp # CLI for Amp, an agentic coding tool in research preview from Sourcegraph
      # claude-code # Agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster
      cli-proxy-api # Unified proxy providing OpenAI/Gemini/Claude/Codex compatible APIs for AI coding CLI tools
      #code # Fork of codex. Orchestrate agents from OpenAI, Claude, Gemini or any provider.
      # codex - OpenAI Codex CLI - a coding agent that runs locally on your computer

      copilot-cli #- GitHub Copilot CLI brings the power of Copilot coding agent directly to your terminal.
      crush #- The glamourous AI coding agent for your favourite terminal
      cursor-agent #- Cursor Agent - CLI tool for Cursor AI code editor
      droid #- Factory AI's Droid - AI-powered development agent for your terminal
      eca #- Editor Code Assistant (ECA) - AI pair programming capabilities agnostic of editor
      forge #- AI-Enhanced Terminal Development Environment - A comprehensive coding agent that integrates AI capabilities with your development environment

      # gemini-cli - AI agent that brings the power of Gemini directly into your terminal

      goose-cli #- CLI for Goose - a local, extensible, open source AI agent that automates engineering tasks
      iflow-cli #- AI coding agent for the terminal with free model access via the iFlow platform
      jules #- Jules, the asynchronous coding agent from Google, in the terminal
      kilocode-cli #- The open-source AI coding agent. Now available in your terminal.
      letta-code #- Memory-first coding agent that learns and evolves across sessions
      mistral-vibe #- Minimal CLI coding agent by Mistral AI - open-source command-line coding assistant powered by Devstral
      nanocoder #- A beautiful local-first coding agent running in your terminal - built by the community for the community ⚒
      oh-my-opencode #- The Best AI Agent Harness - Multi-Model Orchestration for OpenCode
      omp #- A terminal-based coding agent with multi-model support (binary release)

      # opencode - AI coding agent built for the terminal

      pi #- A terminal-based coding agent with multi-model support
      qoder-cli #- Qoder AI CLI tool - Terminal-based AI assistant for code development
      qwen-code #- Command-line AI workflow tool for Qwen3-Coder models

      # AI Assistants
      localgpt #- Local AI assistant with persistent markdown memory, autonomous tasks, and semantic search
      openclaw #- Your own personal AI assistant. Any OS. Any Platform. The lobster way
      picoclaw #- Tiny, fast, and deployable anywhere — automate the mundane, unleash your creativity
      zeroclaw #- Fast, small, and fully autonomous AI assistant infrastructure

      # Claude Code Ecosystem
      auto-claude #- Autonomous multi-agent coding framework powered by Claude AI
      catnip #- Developer environment that's like catnip for agentic programming
      cc-switch-cli #- CLI version of CC Switch - All-in-One Assistant for Claude Code, Codex & Gemini CLI
      ccstatusline #- A highly customizable status line formatter for Claude Code CLI
      claude-code-router #- Use Claude Code without an Anthropics account and route it to another LLM provider
      claude-plugins #- CLI tool for managing Claude Code plugins
      claudebox #- Sandboxed environment for Claude Code
      sandbox-runtime #- Lightweight sandboxing tool for enforcing filesystem and network restrictions
      skills-installer #- Install agent skills across multiple AI coding clients

      # ACP Ecosystem
      claude-code-acp #- An ACP-compatible coding agent powered by the Claude Code SDK (TypeScript)
      codex-acp #- An ACP-compatible coding agent powered by Codex

      # Usage Analytics
      ccusage #- Usage analysis tool for Claude Code
      ccusage-amp #- Usage analysis tool for Amp CLI sessions
      ccusage-codex #- Usage analysis tool for OpenAI Codex sessions
      ccusage-opencode #- Usage analysis tool for OpenCode sessions
      ccusage-pi #- Pi-agent usage tracking for Claude Max

      # Workflow & Project Management
      agent-deck #- Your AI agent command center
      backlog-md #- Backlog.md - A tool for managing project collaboration between humans and AI Agents in a git ecosystem
      beads #- A distributed issue tracker designed for AI-supervised coding workflows
      beads-rust #- Fast Rust port of beads - a local-first issue tracker for git repositories
      beads-viewer #- Graph-aware TUI for the Beads issue tracker
      cc-sdd #- Spec-driven development framework for AI coding agents
      chainlink #- Simple, lean issue tracker CLI designed for AI-assisted development
      openspec #- Spec-driven development for AI coding assistants
      ralph-tui #- AI Agent Loop Orchestrator TUI
      spec-kit #- Specify CLI, part of GitHub Spec Kit. A tool to bootstrap your projects for Spec-Driven Development (SDD)
      vibe-kanban #- Kanban board to orchestrate AI coding agents like Claude Code, Codex, and Gemini CLI
      workmux #- Git worktrees + tmux windows for zero-friction parallel dev

      # Code Review
      coderabbit-cli #- AI-powered code review CLI tool
      tuicr #- Review AI-generated diffs like a GitHub pull request, right from your terminal

      # Utilities
      agent-browser #- Headless browser automation CLI for AI agents
      ck #- Local first semantic and hybrid BM25 grep / search tool for use by AI and humans!
      copilot-language-server #- GitHub Copilot Language Server - AI pair programmer LSP
      entire #- CLI tool that captures AI agent sessions and links them to code changes
      gno #- Local-first knowledge engine with hybrid search, RAG Q&A, and MCP server integration
      handy #- Fast and accurate local transcription app using AI models
      happy-coder #- Happy Coder CLI to connect your local Claude Code to mobile device
      mcporter #- TypeScript runtime and CLI for the Model Context Protocol
      openskills #- Universal skills loader for AI coding agents - install and load Anthropic SKILL.md format skills in any agent
      qmd #- mini cli search engine for your docs, knowledge bases, meeting notes, whatever. Tracking current sota approaches while being all local
      rtk #- CLI proxy that reduces LLM token consumption by 60-90% on common dev commands
      showboat # - Create executable demo documents showing and proving an agent's work
    ]);

  programs = {
    #    adb.enable = true;
    dms-shell = {
      systemd.restartIfChanged = true;
      enableSystemMonitoring = false; # was true — kills sysfs polling
      enableDynamicTheming = false; # was true — kills theme recalculation loop
      enableCalendarEvents = false; # was true — kills network/daemon polling
      enableAudioWavelength = true; # keep — pure audio stream, low overhead
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
