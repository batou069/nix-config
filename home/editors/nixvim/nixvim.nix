{ libPkg
, inputs
, ...
}: {
  programs.nixvim = {
    enable = true;
    package = libPkg inputs.neovim-nightly;

    defaultEditor = true;

    performance = { byteCompileLua.enable = true; };

    vimAlias = true;
    viAlias = true;
    extraConfigLuaPre = ''
      vim.loader.enable()

      require("mcphub").setup({
        auto_approve = true,
        mcp_request_timeout = 120000,
      })
    '';
    luaLoader.enable = true;
    extraPlugins = [ (libPkg inputs.mcp-hub-nvim) ];
  };
}
