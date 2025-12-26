{ pkgs, ... }:
let
  # customWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
  #   mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
  # });
  tclint-dummy = pkgs.writeShellScriptBin "tclint" "exit 0";
in
{
  home.packages = [
    pkgs.home-manager
    pkgs.tree-sitter
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [ fzf nix-search-tv ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
      excludeShellChecks = [ "SC2016" ];
    })
    pkgs.treefmt
    pkgs.spotify-player
    # customWaybar
    # pkgs.blender # 3D creation suite
    pkgs.fpp
    pkgs.igrep # Improved grep with context and file filtering
    # pkgs.base16-shell-preview # Set of shell scripts to change terminal colors using
    # pkgs.base16-schemes # Collection of base16 color schemes
    pkgs.manix
    pkgs.rmpc
    pkgs.rtaudio # Real-time audio I/O library
    pkgs.erdtree # Visualize directory structure as a tree
    pkgs.cmake
    pkgs.meld
    pkgs.normcap
    pkgs.repgrep # A more powerful ripgrep with additional features
    pkgs.ripgrep-all
    pkgs.alejandra
    pkgs.pre-commit
    # pkgs.nodejs # Provides npm
    pkgs.kdePackages.okular
    # pkgs.vgrep # User-friendly pager for grep/git-grep/ripgrep
    # xonsh # Python-ish, BASHwards-compatible shell
    pkgs.vimPluginsUpdater
    pkgs.vimgolf # Interactive Vim golf game, train you vim skills
    # pkgs.rofi-obsidian # Rofi plugin to quickly open Obsidian notes
    # pkgs.rofi-rbw-wayland # Rofi-frontend for Bitwarden
    pkgs.wtype
    # pkgs.rbw
    # pkgs.alsa-ucm-conf # maybe this fixed sound issue?
    # pkgs.tradingview
    # pkgs.neovide
    pkgs.appimage-run
    pkgs.codex # Claude Assistant CLI
    pkgs.claudia
    pkgs.tealdeer
    pkgs.statix # Lints and suggestions for the Nix programming language
    # nur.repos.novel2430.zen-browser-bin # Zen Browser
    # nur.repos."7mind".ibkr-tws     # Interactive Brokers TWS
    # pkgs.nur.repos.k3a.ib-tws
    # pkgs.nur.repos.clefru.ib-tws
    pkgs.nixdoc
    pkgs.glow # Beautiful terminal markdown viewer
    pkgs.gum # Terminal-based GUI toolkit
    # pkgs.keepassxc # Password manager
    # pkgs.keepmenu # Menu for KeePassXC
    # pkgs.git-credential-keepassxc # Credential helper for Git
    pkgs.libnotify
    pkgs.papirus-icon-theme
    pkgs.pcmanfm-qt
    # pkgs.pnpm # npm package manager
    pkgs.git-filter-repo
    pkgs.sof-tools
    # pkgs.faiss
    # (pkgs.callPackage ./ipython-ai.nix { inherit pkgs; }).out

    pkgs.dosbox-staging

    pkgs.dosbox-x

    pkgs.google-chrome

    pkgs.antigravity-fhs

    pkgs.ghostscript
    pkgs.tectonic
    pkgs.mermaid-cli
    pkgs.cliphist

    tclint-dummy
  ];
}
