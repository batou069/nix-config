{ pkgs-unstable, ... }: {
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;
    enableMcpIntegration = true;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      permissions = {
        edit = "ask";
        bash = "ask";
        webfetch = "allow";
        doom_loop = "ask";
        external_directory = "ask";
      };
      plugins = [ "opencode-skills" ];
      autoupdate = false;
      tui = {
        scroll_acceleration.enabled = true;
        scroll_speed = 3;
      };
      formatters = {
        ruff = {
          disabled = false;
          command = "ruff ";
          extensions = "py";
        };
        tools = {
          read = true;
          grep = true;
          glob = true;
          bash = true;
          edit = true;
          write = true;
          list = true;
          patch = true;
          todowrite = true;
          todoread = true;
          webfetch = true;
        };
        model = "google/gemini-3-pro-preview";
      };
      # theme = "catppuccin";
    };
  };
}
