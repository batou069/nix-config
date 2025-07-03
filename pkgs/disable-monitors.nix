{pkgs}: {
  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/main.lua.d/51-disable-monitors.lua" ''
      rule = {
        matches = {
          {
            { "node.name", "matches", "alsa_output.*.monitor" },
          },
        },
        actions = {
          update_props = {
            ["node.disabled"] = true,
          },
        },
      }
      table.insert(wireplumber_config.rules,rule)
    '')
  ];
}
