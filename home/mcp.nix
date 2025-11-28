{ config
, inputs
, pkgs
, ...
}:
let
  # cameronfyfe's nix-mcp-servers - has many server packages
  mcp-pkgs = inputs.nix-mcp-servers.packages.${pkgs.system};
  # natsukium's mcp-servers-nix - has serena and others
  mcp-natsukium = inputs.mcp-servers-nix.packages.${pkgs.system};
in
{
  programs.mcp = {
    enable = true;
    servers = {
      # --- Servers from cameronfyfe's nix-mcp-servers ---
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
          "${config.home.homeDirectory}/.config"
          "${config.home.homeDirectory}/dotfiles"
          "/nix"
        ];
      };
      git = {
        command = "${mcp-pkgs.mcp-server-git}/bin/mcp-server-git";
        args = [
          "--repository"
          "${config.home.homeDirectory}/nix"
        ];
      };
      github = {
        command = "bash";
        args = [
          "-c"
          "export GITHUB_TOKEN=$(cat ${config.sops.secrets."api_keys/github_mcp".path}) && ${mcp-pkgs.github-mcp-server}/bin/github-mcp-server"
        ];
      };
      "brave-search" = {
        command = "${mcp-pkgs.mcp-server-brave-search}/bin/mcp-server-brave-search";
      };
      memory = {
        command = "bash";
        args = [
          "-c"
          # Wrap to discard noisy stderr status messages
          "${mcp-pkgs.mcp-server-memory}/bin/mcp-server-memory 2>/dev/null"
        ];
      };

      # --- Servers from natsukium's mcp-servers-nix ---
      serena = {
        command = "${mcp-natsukium.serena}/bin/serena";
        args = [
          "--project"
          "${config.home.homeDirectory}/nix"
        ];
      };

      # --- Other MCP Servers ---
      nixos = {
        command = "${inputs.mcp-nixos.packages.${pkgs.system}.mcp-nixos}/bin/mcp-nixos";
      };
      context7 = {
        command = "${pkgs.context7-mcp}/bin/context7-mcp";
      };
      tavily = {
        command = "${pkgs.tavily-mcp}/bin/tavily-mcp";
      };
    };
  };
}
