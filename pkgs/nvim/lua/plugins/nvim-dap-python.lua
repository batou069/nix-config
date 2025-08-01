return   {
  "mfussenegger/nvim-dap-python",
  keys = {
    { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
    { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
  },
  config = function()
      require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/etc/profiles/per-user/lf/bin/python"))
  end,
}
