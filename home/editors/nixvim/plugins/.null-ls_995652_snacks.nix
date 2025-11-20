{ lib
, config
, ...
}: {
  # This wrapper is NECESSARY to scope the options correctly for nixvim.
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        snackline = { enabled = true; };
        indent = {
          indent = { enabled = false; };
          chunk = {
            enabled = true;
            only_current = true;

            char = {
              arrow = "─";
              corner_top = "╭";
              corner_bottom = "╰";
            };
            hl = "SnacksIndentScope";
          };
        };
      };
    };

    # The paths here must be the FULL path from the top of the config.
    highlight = (lib.mkIf (config.programs.nixvim.plugins.snacks.enable
      && lib.hasAttr "indent" config.programs.nixvim.plugins.snacks.settings)) {
      SnacksIndent = { fg = "#141414"; };
    };
  };
}
