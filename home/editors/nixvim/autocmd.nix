{ ... }: {
  programs.nixvim = {
    extraConfigLua = ''
      group = group,
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })
    '';
  };
}
