{ ... }: {
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings = {
        preset = "modern";
        notify = false;
        win = {
          border = "single";
          padding = [ 1 2 ];
          title = true;
          title_pos = "center";
        };
        spec = [
          {
            __unkeyed-1 = "<leader>f";
            group = "Find/Search";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>e";
            group = "Explorer";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "Window";
            icon = "wm";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "Tabs";
            icon = "tab";
          }
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffers";
            icon = "buff";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "Code";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>gh";
            group = "Hunks";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "Debug";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>a";
            group = "AI";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>u";
            group = "UI";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "System";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>q";
            group = "Quit";
            icon = " ";
          }
        ];
      };
    };
  };
}
