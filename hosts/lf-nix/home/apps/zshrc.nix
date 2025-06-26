# /home/lf/NixOS-Hyprland/hosts/lf-nix/zshrc.nix
# Declarative Zsh configuration, replacing zinit.

{ config, pkgs, lib, ... }:

# Helper function to shorten fetchFromGitHub calls
let
  fetchPlugin = owner: repo: rev: sha256:
    pkgs.fetchFromGitHub {
      inherit owner repo rev sha256;
    };
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";

    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
    };

    options = [
      "APPEND_HISTORY"
      "SHARE_HISTORY"
      "HIST_IGNORE_SPACE"
      "HIST_IGNORE_ALL_DUPS"
      "HIST_SAVE_NO_DUPS"
      "HIST_FIND_NO_DUPS"
      "AUTO_CD"
      "EXTENDED_HISTORY"
      "LONG_LIST_JOBS"
      "NOTIFY"
      "COMPLETE_IN_WORD"
      "NO_BEEP"
      "NO_SH_WORD_SPLIT"
      "CORRECT"
      "NO_COMPLETE_ALIASES"
      "EXTENDED_GLOB"
      "NULL_GLOB"
      "BRACE_CCL"
      "COMBINING_CHARS"
      "ALWAYS_TO_END"
      "AUTO_LIST"
      "AUTO_PARAM_SLASH"
      "BANG_HIST"
      "HIST_VERIFY"
    ];

    # --- Declarative Plugin Management (replaces Zinit) ---
    # Home Manager fetches and sources these plugins for you.
    plugins = [
      # Plugins available in nixpkgs
      { name = "zsh-autosuggestions"; src = pkgs.zsh-autosuggestions; }
      { name = "zsh-completions"; src = pkgs.zsh-completions; }
      { name = "fast-syntax-highlighting"; src = pkgs.zsh-fast-syntax-highlighting; }
      { name = "forgit"; src = pkgs.forgit; }
      { name = "fzf-tab"; src = pkgs.fzf-tab; }
      { name = "zsh-you-should-use"; src = pkgs.zsh-you-should-use; }
      { name = "zsh-colored-man-pages"; src = pkgs.zsh-colored-man-pages; }
      { name = "zsh-autopair"; src = pkgs.zsh-autopair; }

      # Plugins fetched directly from GitHub (replaces zinit light ...)
      # NOTE: You will need to provide the correct sha256 hashes.
      # The build will fail and show you the expected hash.
      { name = "docker-zsh-completion"; src = fetchPlugin "greymd" "docker-zsh-completion" "03553c1" "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; }
      { name = "zsh-manydots-magic"; src = fetchPlugin "knu" "zsh-manydots-magic" "c2d4832" "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; }
      { name = "zsh-vim-mode"; src = fetchPlugin "softmoth" "zsh-vim-mode" "v0.9.0" "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; }
      { name = "history-search-multi-word"; src = fetchPlugin "zdharma-continuum" "history-search-multi-word" "v1.3" "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; }
    ];

    # --- Aliases ---
    shellAliases = {
      # (Your aliases remain the same as the previous file)
      nix-update = "sudo nixos-rebuild switch --flake ~/NixOS-Hyprland#lf-nix";
      nix-build = "nixos-rebuild build --flake ~/NixOS-Hyprland#lf-nix";
      # ... etc ...
      g = "git";
      gst = "git status";
      cat = "bat --paging=never --style=plain";
      ll = "lsd -lL --group-dirs=first --date=relative";
      ".." = "cd ..";
    };

    # --- Keybindings ---
    bindKeys = {
      "^p" = "history-search-backward";
      "^n" = "history-search-forward";
      "^[[1;5C" = "forward-word";
      "^[[1;5D" = "backward-word";
      "^[[3;5~" = "kill-word";
    };

    # --- initExtra: For zstyle, functions, and sourcing ---
    initExtra = ''
      # Load required Zsh modules
      zmodload -i zsh/complist
      zmodload -i zsh/mathfunc
      zmodload -a zsh/stat zstat
      zmodload -a zsh/zpty zpty

      # --- Replicating OMZ Snippet Functionality ---
      # This 'extract' function replaces the 'OMZP::extract' snippet
      extract () {
        if [ -f "$1" ] ; then
          case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }

      # This widget and keybinding replaces the 'OMZP::sudo' snippet
      sudo-command-line() {
        [[ -z $BUFFER ]] && zle redisplay
        LBUFFER="sudo $LBUFFER"
        zle redisplay
      }
      zle -N sudo-command-line
      bindkey "\e\e" sudo-command-line

      # --- Zstyle Configurations ---
      # (Your zstyle settings remain the same)
      zstyle ':completion:*' use-cache yes
      zstyle ':completion:*' menu select
      # ... etc ...

      # --- Custom Functions ---
      # (Your custom functions remain the same)
      cheat() { curl "cheat.sh/''${*:-}"; }
      mkcd() { mkdir -p "$1" && cd "$1"; }

      # --- Sourcing External Files ---
      [ -f "$HOME/.env" ] && source "$HOME/.env"
      [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
      [ -f "$HOME/scripts/copypath.zsh" ] && source "$HOME/scripts/copypath.zsh"
    '';
  };

  # The command-not-found handler is a separate program in NixOS/Home Manager
  # This replaces the 'OMZP::command-not-found' snippet
  programs.command-not-found.enable = true;
}