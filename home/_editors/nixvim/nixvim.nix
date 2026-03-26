{ libPkg
, inputs
, pkgs
, ...
}: {
  programs.nixvim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    # package = libPkg inputs.neovim-nightly;

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
    extraConfigLua = ''
      -- Register is-not? predicate missing in Neovim 0.11+ (nvim-treesitter compat)
      vim.treesitter.query.add_predicate("is-not?", function(match, _, _, predicate, metadata)
        local id = predicate[2]
        local node = match[id]
        if not node then return true end
        local prop = predicate[3]
        local props = (metadata and metadata[id] and metadata[id].props) or {}
        return props[prop] ~= true
      end, { force = true })
    '';
  };
}
