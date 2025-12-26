{ ... }: {
  services = {
    espanso = {
      enable = true;
      configs = {
        vscode = {
          filter_title = "Visual Studio Code$";
          backend = "Clipboard";
        };
      };
      matches = {
        default = {
          matches = [
            {
              trigger = ":nrs";
              replace = "nix nixos-rebuild switch --flake $N";
            }
            {
              trigger = ":lf";
              replace = "Laurent Flaster";
            }
            {
              trigger = ":now";
              replace = "{{currentdate}} {{currenttime}}";
            }
            {
              trigger = ":code";
              replace = ''```\n$|$```'';
            }

            {
              trigger = ":rebuild";
              replace = "sudo nixos-rebuild switch --flake $N#lf-nix -vv";
            }
          ];
        };
        global_vars = {
          global_vars = [
            {
              name = "currentdate";
              type = "date";
              params = { format = "%d/%m/%Y"; };
            }
            {
              name = "currenttime";
              type = "date";
              params = { format = "%R"; };
            }
          ];
        };
      };
    };
  };
}
