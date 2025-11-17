{ lib
, pkgs-unstable
, ...
}: {
  programs.nixvim.plugins = {
    sidekick = {
      enable = false;
      package = pkgs-unstable.vimPlugins.sidekick-nvim;
    };
    avante = {
      enable = false;
      settings = {
        provider = "gemini";
        providers = {
          gemini = {
            model = "gemini-pro";
            endpoint = "https://generativelanguage.googleapis.com/v1beta";
            # You'll need to set the GOOGLE_API_KEY environment variable
            api_key = lib.nixvim.mkRaw "vim.env.GOOGLE_API_KEY";
          };
        };
      };
    };
    # opencode = {
    # enable = true;
    # package = pkgs-unstable.vimPlugins.opencode-nvim;
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
}
