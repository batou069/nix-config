# This is a NixOS module that configures the home-manager service for a specific user.
{ username, ... }: {
  home-manager.users.${username} = {
    # This is where we import all the modules for this user's Home Manager configuration.
    imports = [
      ../default/home.nix
      ../../home/home-manager.nix
      ../../home/systemd.nix
      ../../home/xdg.nix
      ../../home/sessionvariables.nix
      ../../home/packages.nix
      ../../home/stylix.nix
      ../../home/desktops
      ../../home/ai
      ../../home/cli
      ../../home/code
      ../../home/editors
      ../../home/gui
      ../../home/services
      ../../home/shells
      ../../home/tui
      ../../home/anime-downloader.nix
      ../../home/fontconfig.nix
      ../../home/gemini.nix
      ../../home/gtk.nix
      ../../home/kde.nix
      ../../home/lessfilter.nix
      ../../home/local-ai.nix
      ../../home/mcp.nix
      ../../home/mpd.nix
      ../../home/retroarch.nix
      ../../home/home-manager.nix
    ];
  };
}
