{ pkgs
, inputs
, lib
, ...
}: {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    inputs.catppuccin.homeModules.catppuccin
  ];
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      flavour = [ "macchiato" ];
      accents = [ "lavender" ];
    })
    gnome-text-editor
    kde-rounded-corners
    kdePackages.kcalc
    kdePackages.krohnkite
    kdotool
    libnotify
    # tela-circle-icon-theme
  ];

  services = {
    # gpg-agent = {
    #   pinentry.package = lib.mkForce pkgs.kwalletcli;
    #   extraConfig = "pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet";
    # };
    kdeconnect = {
      enable = true;
    };
  };

  programs.plasma = {
    enable = true;
    workspace = {
      theme = "default";
      colorScheme = "CatppuccinMacchiatoLavender"; # Matches your previous installation
      iconTheme = "kora";
      # cursorTheme = "Breeze_Snow";
      lookAndFeel = "org.kde.breezedark.desktop";
      # wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Patak/contents/images/1080x1920.png"; # Optional example
    };
    shortcuts = {
      "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Alt+Shift";

      # Touchpad
      kcm_touchpad."Toggle Touchpad" = [ "Touchpad Toggle" "Meta+Ctrl+Zenkaku Hankaku" ];

      # Audio
      kmix.decrease_volume = "Volume Down";
      kmix.increase_volume = "Volume Up";
      kmix.mute = "Volume Mute";

      # Session
      ksmserver."Lock Session" = [ "Meta+L" "Screensaver" ];
      ksmserver."Log Out" = "Ctrl+Alt+Del";

      # Window Management (KWin)
      kwin."Kill Window" = "Meta+Ctrl+Esc";
      kwin."Overview" = "Meta+W";
      kwin."Show Desktop" = "Meta+D";
      kwin."Window Close" = "Alt+F4";
      kwin."Window Maximize" = "Meta+PgUp";
      kwin."Window Minimize" = "Meta+PgDown";

      # Tiling (Krohnkite mappings you had)
      kwin.KrohnkiteFloatAll = "Meta+Shift+F";
      kwin.KrohnkiteFocusDown = "Meta+J";
      kwin.KrohnkiteFocusLeft = "Meta+H";
      kwin.KrohnkiteFocusUp = "Meta+K";
      kwin.KrohnkiteFocusPrev = "Meta+\\";
      kwin.KrohnkiteMonocleLayout = "Meta+M";
      kwin.KrohnkiteSetMaster = "Meta+Return";
      kwin.KrohnkiteToggleFloat = "Meta+F";

      # Desktop Switching
      kwin."Switch One Desktop Down" = "Meta+Ctrl+Down";
      kwin."Switch One Desktop Up" = "Meta+Ctrl+Up";
      kwin."Switch One Desktop to the Left" = "Meta+Ctrl+Left";
      kwin."Switch One Desktop to the Right" = "Meta+Ctrl+Right";

      # App Launching
      plasmashell."activate application launcher" = "Alt+F1";
      plasmashell."activate task manager entry 1" = "Meta+1";
      plasmashell."activate task manager entry 2" = "Meta+2";
      plasmashell."activate task manager entry 3" = "Meta+3";
      plasmashell."activate task manager entry 4" = "Meta+4";
      plasmashell."activate task manager entry 5" = "Meta+5";
      # ... add 6-9 if you use them ...

      # Vicinae
      "services/vicinae.desktop".close = "Meta+Alt+Space";
      "services/vicinae.desktop".open = "Meta+Space";
    };
    configFile = {
      # Mouse/Touchpad speed
      kcminputrc."Libinput/10182/3395/VEN_27C6:00 27C6:0D43 Mouse".PointerAcceleration = 0.200;
      kcminputrc."Libinput/10182/3395/VEN_27C6:00 27C6:0D43 Touchpad".NaturalScroll = true;

      # Dolphin (File Manager) settings
      dolphinrc.General.ViewPropsTimestamp = "2025,11,24,3,59,27.047";
      dolphinrc."KFileDialog Settings"."Places Icons Static Size" = 22;

      # Window Rules / Effects
      kwinrc.Windows.FocusPolicy = "FocusFollowsMouse";
      kwinrc.Plugins.wobblywindowsEnabled = true;
      kwinrc.Plugins.krohnkiteEnabled = true; # I set this to TRUE because you have shortcuts for it!
      kwinrc.Plugins.magiclampEnabled = true;
    };
  };

  qt.platformTheme.name = lib.mkForce "kde";
}
