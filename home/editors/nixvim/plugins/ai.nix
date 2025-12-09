{ pkgs, ... }: {
  programs.nixvim.plugins = {
    codecompanion = {
      enable = true;
    };
    copilot-chat = {
      enable = true;
    };
    avante = {
      enable = true;
      # Use the package from flake input (via overlay)
      package = pkgs.vimPlugins.avante-nvim;
      settings = {
        provider = "gemini";
        providers = {
          gemini = {
            model = "gemini-2.0-flash-exp";
            endpoint = "https://generativelanguage.googleapis.com/v1beta";
            # You'll need to set the GOOGLE_API_KEY environment variable
            api_key_name = "GEMINI_API_KEY";
          };
        };
      };
    };
    sidekick = {
      enable = false;
      package = pkgs.vimPlugins.sidekick-nvim;
    };
    # opencode = {
    # settings = {
    #   # Assuming the zen opencode api is compatible with the openai format
    #   # and you have a local server running.
    #   # You may need to adjust the host and port.
    #   host = "127.0.0.1";
    #   port = 8080; # Default port, change if needed
    #   prompts = {
    #     explain = {
    #       prompt = "Explain the following code block";
    #       description = "Explain the code";
    #     };
    #     refactor = {
    #       prompt = "Refactor the following code block";
    #       description = "Refactor the code";
    #     };
    #   };
    # };
    # };
    wtf = {
      enable = false;
      settings = {
        # Using phind as a default search engine for diagnostics
        search_engine = "phind";
      };
    };
    copilot-cmp.enable = false;
  };

  # Extra plugins from flake inputs (not built-in to nixvim)
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    # minuet-ai-nvim  # AI completion - uncomment to enable
    # vim-translator  # Translation plugin - uncomment to enable
    # nui-nvim        # UI library (dependency for some plugins) - uncomment if needed
  ];
}
