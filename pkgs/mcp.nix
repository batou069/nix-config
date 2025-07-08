{ mkServerModule, ... }:
{
  imports = [
    (mkServerModule { name = "fetch"; })
    (mkServerModule { name = "everything"; })
    (mkServerModule {name = "context7";
          packageName = "context7-mcp";
        })
    (mkServerModule { name = "sequential-thinking"; })
  ];
  mcp-servers.lib.mkConfig pkgs {
    format = "yaml";
    fileName = "config.yaml";

    # Configure built-in modules
    programs = {
      filesystem = {
        enable = true;
        args = [ "/home/lf/Obsidian" ];
      };
    };

    # Add custom MCP servers
    settings.servers = {
      mcp-obsidian = {
        command = "${pkgs.lib.getExe' pkgs.nodejs "npx"}";
        args = [
          "-y"
          "mcp-obsidian"
          "/home/lf/Obsidian"
        ];
      };
    };
  };
}
