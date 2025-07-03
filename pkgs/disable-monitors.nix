{...}: {
  services.pipewire.wireplumber.extraConfig = {
    "monitor" = {
      "rules" = [
        {
          matches = [{"node.name" = "~alsa_output.*.monitor";}];
          actions = {
            update-props = {"node.hidden" = true;};
          };
        }
      ];
    };
  };
}
