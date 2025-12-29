{ ... }: {
  programs.nixvim = {
    plugins = {
      smear-cursor.enable = true;
      smear-cursor.autoLoad = true;
      smear-cursor.settings = {
        distance_stop_animating = 0.5;
        hide_target_hack = false;
        stiffness = 0.8;
        trailing_stiffness = 0.5;
        smear_between_buffers = true;
      };
    };
  };
}
