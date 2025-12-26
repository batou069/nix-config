{ pkgs, ... }: {
  programs.fabric-ai = {
    enable = true;
    package = pkgs.fabric-ai;
    # enableZshIntegration = true;
    enableYtAlias = true;
    enablePatternsAliases = true;
  };
}
