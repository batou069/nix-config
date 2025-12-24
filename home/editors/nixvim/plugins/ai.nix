{ pkgs, ... }: {
  programs.nixvim.extraConfigLuaPre = ''
    vim.env["CODECOMPANION_TOKEN_PATH"] = vim.fn.expand("~/.config")
  '';

  programs.nixvim.plugins = {
    codecompanion = {
      enable = true;
      settings = {
        interactions = {
          chat = {
            adapter = "copilot";
          };
          inline = {
            adapter = "copilot";
          };
        };
        opts = {
          log_level = "DEBUG";
        };
      };
    };
    copilot-chat = {
      enable = true;
    };
    avante = {
      enable = true;
      package = pkgs.vimPlugins.avante-nvim;
      settings = {
        provider = "gemini";
        providers = {
          gemini = {
            model = "gemini-2.0-flash-exp";
            endpoint = "https://generativelanguage.googleapis.com/v1beta";
            api_key_name = "GEMINI_API_KEY";
          };
        };
      };
    };
    sidekick = {
      enable = false;
      package = pkgs.vimPlugins.sidekick-nvim;
    };
    wtf = {
      enable = false;
      settings = {
        search_engine = "phind";
      };
    };
    copilot-cmp.enable = false;
  };

  # Extra plugins from flake inputs
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    # minuet-ai-nvim
    # vim-translator
    # nui-nvim
  ];

  programs.nixvim.keymaps = [
    # Avante
    {
      mode = "n";
      key = "<leader>aa";
      action = "<cmd>AvanteAsk<CR>";
      options = {
        desc = "Avante Ask";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ac";
      action = "<cmd>AvanteChat<CR>";
      options = {
        desc = "Avante Chat";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ae";
      action = "<cmd>AvanteEdit<CR>";
      options = {
        desc = "Avante Edit";
        silent = true;
      };
    }

    # Copilot Chat
    {
      mode = "n";
      key = "<leader>cc";
      action = "<cmd>CopilotChatToggle<CR>";
      options = {
        desc = "Copilot Chat";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<leader>ce";
      action = "<cmd>CopilotChatExplain<CR>";
      options = {
        desc = "Copilot Explain";
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<leader>cf";
      action = "<cmd>CopilotChatFix<CR>";
      options = {
        desc = "Copilot Fix";
        silent = true;
      };
    }
  ];
}
