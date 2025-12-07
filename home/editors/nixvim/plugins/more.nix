{ ... }: {
  programs.nixvim = {
    plugins = {
      yanky = {
        enable = true;
        # enableTelescope = true;
      };

      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
            tab_char = "│";
          };
          exclude = {
            filetypes = [
              "help"
              "dashboard"
              "neo-tree"
              "Trouble"
              "trouble"
              "notify"
              "toggleterm"
            ];
          };
        };
      };
      harpoon = {
        enable = false;
        enableTelescope = true;
      };

      todo-comments = {
        enable = true;
        settings = {
          signs = true;
        };
      };
      lazydev = {
        enable = true; # autoEnableSources not enough
        settings = {
          library = [
            {
              path = "\${3rd}/luv/library";
              words = [ "vim%.uv" ];
            }
          ];
        };
      };
    };
  };
}
