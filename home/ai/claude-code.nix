{ pkgs, ... }: {
  programs.claude-code.enable = true;

  home.packages = [
    pkgs.pyright # Python LSP (type checker + intellisense)
  ];

  home.sessionVariables = {
    ENABLE_LSP_TOOL = "1";
  };

  home.file.".claude/lsp.json".source = ./lsp.json;
}
