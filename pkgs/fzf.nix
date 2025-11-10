{ pkgs
, config
, ...
}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = false; # We will set FZF_DEFAULT_OPTS manually
    package = pkgs.fzf;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--preview"
      "${config.home.homeDirectory}/.local/bin/lessfilter.sh {}"
      "--preview-window"
      "right:60%:wrap"
      "--height"
      "80%"
      "--layout"
      "reverse"
      "--border"
      "rounded"
      "--prompt"
      "  "
      "--marker"
      " "
      "--info=inline"
      "--bind"
      "ctrl-r:reload(${pkgs.fd}/bin/fd --type f --hidden --follow --exclude .git)"
      "--bind"
      "ctrl-/:change-preview-window(60%|30%|hidden|)"
      "--bind"
      "ctrl-a:select-all"
      "--bind"
      "ctrl-k:kill-line"
      "--bind"
      "ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)"
      "--border-label='╢ FZF ╟'"
      "--ghost='Search ...'"
      "--cycle"
      "padding='10%,0%,0%,0%'"
      "margin='10%,30%,0%,0%'"
      "--color"
      "preview-fg:#ddc8c8"
    ];
    tmux.enableShellIntegration = true;
  };
}
