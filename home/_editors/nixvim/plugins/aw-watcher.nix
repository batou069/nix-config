{ ... }: {
  programs.nixvim.plugins.aw-watcher = {
    enable = true;
    autoLoad = true;
  };
}
