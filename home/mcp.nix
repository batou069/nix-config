{ config
, inputs
, pkgs
, ...
}: {
  programs.mcp = {
    enable = true;
    servers =
      let
        mcp-pkgs = inputs.nix-mcp-servers.packages.${pkgs.system};
      in
      {
        # --- Servers from the cameronfyfe package set ---
        fetch = {
          command = "${mcp-pkgs.mcp-server-fetch}/bin/mcp-server-fetch";
        };
        "sequential-thinking" = {
          command = "bash";
          args = [
            "-c"
            "${pkgs.nodejs}/bin/npx -y @modelcontextprotocol/server-sequential-thinking"
          ];
        };
        filesystem = {
          command = "${mcp-pkgs.mcp-server-filesystem}/bin/mcp-server-filesystem";
          args = [
            "${config.home.homeDirectory}/nix"
            "${config.home.homeDirectory}/git"
            "/nix"
          ];
        };
        git = {
          command = "${mcp-pkgs.mcp-server-git}/bin/mcp-server-git";
          args = [
            "--repository"
            "${config.home.homeDirectory}/nix"
          ]; # Set a default repository
        };
        github = {
          command = "bash";
          args = [
            "-c"
            "GITHUB_TOKEN=$(cat /run/secrets/api_keys/github_mcp 2>/dev/null || echo '') ${mcp-pkgs.github-mcp-server}/bin/github-mcp-server"
          ];
        };
        "brave-search" = {
          command = "${mcp-pkgs.mcp-server-brave-search}/bin/mcp-server-brave-search";
        };

        # --- Custom MCP Servers ---
        nixos = {
          command = "${inputs.mcp-nixos.packages.${pkgs.system}.mcp-nixos}/bin/mcp-nixos";
        };

        # --- Servers from your main nixpkgs ---
        context7 = {
          command = "${pkgs.context7-mcp}/bin/context7-mcp";
        };
        serena = {
          command = "bash";
          args = [
            "-c"
            "${inputs.serena.packages.${pkgs.system}.serena}/bin/serena start-mcp-server --project \"${config.home.homeDirectory}/nix\""
          ];
        };
        tavily = {
          command = "${pkgs.tavily-mcp}/bin/tavily-mcp";
        };

        # --- Special case for memory server with the stderr fix ---
        memory = {
          command = "bash";
          args = [
            "-c"
            # We wrap the command to discard the noisy status message
            "${mcp-pkgs.mcp-server-memory}/bin/mcp-server-memory 2>/dev/null"
          ];
        };
      };
  };
}
