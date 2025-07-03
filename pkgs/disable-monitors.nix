{...}: {
  services.pipewire.wireplumber.extraConfig = {
    "policy.rules" = [
      {
        matches = [{"node.name" = "~.*monitor$";}];
        actions = {"update-props" = {"node.hidden" = true;};};
      }
    ];
  };
}
