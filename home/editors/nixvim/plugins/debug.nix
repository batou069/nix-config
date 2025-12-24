{ ... }: {
  programs.nixvim = {
    plugins = {
      dap.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
    };
    keymaps =
      let
        dap = "require'dap'";
        ui = "require'dapui'";
      in
      [
        # Debug Lifecycle
        {
          mode = "n";
          key = "<leader>dd";
          action.__raw = "function() ${dap}.continue() end";
          options.desc = "Start/Continue";
        }
        {
          mode = "n";
          key = "<leader>dt";
          action.__raw = "function() ${dap}.terminate() end";
          options.desc = "Terminate";
        }
        {
          mode = "n";
          key = "<leader>dr";
          action.__raw = "function() ${dap}.repl.toggle() end";
          options.desc = "Toggle REPL";
        }
        {
          mode = "n";
          key = "<leader>dl";
          action.__raw = "function() ${dap}.run_last() end";
          options.desc = "Run Last";
        }

        # Breakpoints
        {
          mode = "n";
          key = "<leader>db";
          action.__raw = "function() ${dap}.toggle_breakpoint() end";
          options.desc = "Toggle Breakpoint";
        }
        {
          mode = "n";
          key = "<leader>dB";
          action.__raw = "function() ${dap}.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
          options.desc = "Conditional Breakpoint";
        }

        # Stepping
        {
          mode = "n";
          key = "<leader>di";
          action.__raw = "function() ${dap}.step_into() end";
          options.desc = "Step Into";
        }
        {
          mode = "n";
          key = "<leader>do";
          action.__raw = "function() ${dap}.step_over() end";
          options.desc = "Step Over";
        }
        {
          mode = "n";
          key = "<leader>dO";
          action.__raw = "function() ${dap}.step_out() end";
          options.desc = "Step Out";
        }
        {
          mode = "n";
          key = "<leader>dj";
          action.__raw = "function() ${dap}.down() end";
          options.desc = "Stack Down";
        }
        {
          mode = "n";
          key = "<leader>dk";
          action.__raw = "function() ${dap}.up() end";
          options.desc = "Stack Up";
        }

        # UI & Hover
        {
          mode = "n";
          key = "<leader>du";
          action.__raw = "function() ${ui}.toggle() end";
          options.desc = "Toggle Debug UI";
        }
        {
          mode = "n";
          key = "<leader>dh";
          action.__raw = "function() require('dap.ui.widgets').hover() end";
          options.desc = "Hover Value";
        }
        {
          mode = "n";
          key = "<leader>d?";
          action.__raw = "function() ${ui}.eval(nil, { enter = true }) end";
          options.desc = "Evaluate Expression";
        }
      ];
  };
}
