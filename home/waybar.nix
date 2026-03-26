{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    # style = {
    #   ''
    #       asd
    #   '';
    # };
    settings = {
      "mainBar" = {
        layer = "top";
        position = "top";
        width = 1050;
        margin-top = 3;
        modules-left = [
          "clock"
          "custom/weather"
        ];

        modules-center = [
          "niri/workspaces"
        ];

        modules-right = [
          "custom/menu"
          "tray"
          "group/notify"
          "mpris"
          "network"
          "bluetooth"
          "backlight"
          "pulseaudio"
          "battery"
          "custom/power"
        ];
      };
      temperature = {
        interval = 10;
        tooltip = true;
        hwmon-path = [
          "/sys/class/hwmon/hwmon1/temp1_input"
          "/sys/class/thermal/thermal_zone0/temp"
        ];
        critical-threshold = 82;
        format-critical = "{temperatureC}°C {icon}";
        format = "{temperatureC}°C {icon}";
        format-icons = [
          "󰈸"
        ];
        on-click-right = "$HOME/.config/hypr/scripts/WaybarScripts.sh --nvtop";
      };

      backlight = {
        interval = 2;
        align = 0;
        rotate = 0;
        format-icons = [
          ""
          ""
          ""
          "󰃝"
          "󰃞"
          "󰃟"
          "󰃠"
        ];
        format = "{icon}";
        tooltip-format = "backlight {percent}%";
        icon-size = 10;
        on-click = "";
        on-click-middle = "";
        on-click-right = "";
        on-update = "";
        on-scroll-up = "$HOME/.config/hypr/scripts/Brightness.sh --inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Brightness.sh --dec";
        smooth-scrolling-threshold = 1;
      };

      "backlight#2" = {
        device = "intel_backlight";
        format = "{icon} {percent}%";
        format-icons = [ ";" "" ];
      };

      battery = {
        # #interval = 5;
        align = 0;
        rotate = 0;
        # #bat = BAT1;
        # #adapter = ACAD;
        full-at = 100;
        design-capacity = false;
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-alt-click = "click";
        format-full = "{icon} Full";
        format-alt = "{icon} {time}";
        format-icons = [
          "󰂎"
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
        format-time = "{H}h {M}min";
        tooltip = true;
        tooltip-format = "{timeTo} {power}w";
        on-click-middle = "$HOME/.config/hypr/scripts/ChangeBlur.sh";
        on-click-right = "$HOME/.config/hypr/scripts/Wlogout.sh";
      };

      bluetooth = {
        format = "";
        format-disabled = "󰂳";
        format-connected = "󰂱 {num_connections}";
        tooltip-format = " {device_alias}";
        tooltip-format-connected = "{device_enumerate}";
        tooltip-format-enumerate-connected = " {device_alias} 󰂄{device_battery_percentage}%";
        tooltip = true;
        on-click = "blueman-manager";
      };

      clock = {
        interval = 1;
        # #format =  { =%I =%M %p}; # AM PM format
        format = " { =%H =%M =%S}";
        format-alt = " { =%H =%M   %Y; %d %B; %A}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{ =%V}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
      };

      actions = {
        on-click-right = "mode";
        on-click-forward = "tz_up";
        on-click-backward = "tz_down";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };

      "clock#2" = {
        # #format = " { =%I =%M %p}";
        format = "  { =%H =%M}";
        format-alt = "{ =%A  |  %H =%M  |  %e %B}";
        tooltip-format = " <big>{ =%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "clock#3" = {
        # #format = { =%I =%M %p - %d/%b}; #for AM/PM
        format = "{ =%H =%M - %d/%b}";
        tooltip = false;
      };

      "clock#4" = {
        interval = 60;
        # #format = { =%B | %a %d; %Y | %I =%M %p}; # AM PM format
        format = "{ =%B | %a %d; %Y | %H =%M}"; # 24H
        format-alt = "{ =%a %b %d; %G}";
        tooltip-format = "<big>{ =%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "clock#5" = {
        # #format = { =%A; %I =%M %P}; # AM PM format
        format = "{ =%a %d | %H =%M}";
        format-alt = "{ =%A; %d %B; %Y (%R)}";
        tooltip-format = "<big>{ =%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
      };

      cpu = {
        format = "{usage}% 󰍛";
        interval = 1;
        min-length = 5;
        format-alt-click = "click";
        format-alt = "{icon0}{icon1}{icon2}{icon3} {usage =>2}% 󰍛";
        format-icons = [
          "▁"
          "▂"
          "▃"
          "▄"
          "▅"
          "▆"
          "▇"
          "█"
        ];
        on-click-right = "gnome-system-monitor";
      };

      disk = {
        interval = 30;
        # #format = 󰋊;
        path = "/";
        # #format-alt-click = click;
        format = "{percentage_used}% 󰋊";
        # #tooltip = true;
        tooltip-format = "{used} used out of {total} on {path} ({percentage_used}%)";
      };

      "hyprland/language" = {
        format = "Lang = {}";
        format-en = "US";
        format-tr = "Korea";
        keyboard-name = "at-translated-set-2-keyboard";
        on-click = "hyprctl switchxkblayout $SET_KB next";
      };

      "hyprland/submap" = {
        format = "<span style=\italic\>  {}</span>"; # Icon = expand-arrows-alt
        tooltip = false;
      };

      "hyprland/window" = {
        format = { };
        max-length = 25;
        separate-outputs = true;
        offscreen-css = true;
        offscreen-css-text = "(inactive)";
        rewrite = {
          "(.*) — Mozilla Firefox" = " $1";
          "(.*) - fish" = "> [$1]";
          "(.*) - zsh" = "> [$1]";
          "(.*) - $term" = "> [$1]";
        };
      };

      idle_inhibitor = {
        tooltip = true;
        tooltip-format-activated = "Idle_inhibitor active";
        tooltip-format-deactivated = "Idle_inhibitor not active";
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = " ";
        };
      };

      keyboard-state = {
        #numlock = true;
        capslock = true;
        format = {
          numlock = "N {icon}";
          capslock = "󰪛 {icon}";
        };
        format-icons = {
          locked = "";
          unlocked = "";
        };
      };

      memory = {
        interval = 10;
        format = "{used =0.1f}G 󰾆";
        format-alt = "{percentage}% 󰾆";
        format-alt-click = "click";
        tooltip = true;
        tooltip-format = "{used =0.1f}GB/{total =0.1f}G";
        on-click-right = "$HOME/.config/hypr/scripts/WaybarScripts.sh --btop";
      };

      mpris = {
        interval = 10;
        format = "{player_icon}";
        format-paused = "{status_icon} <i>{dynamic}</i>";
        on-click-middle = "playerctl play-pause";
        on-click = "playerctl previous";
        on-click-right = "playerctl next";
        scroll-step = 5.0;
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --dec";
        smooth-scrolling-threshold = 1;
        tooltip = true;
        tooltip-format = "{status_icon} {dynamic}\nLeft Click = previous\nMid Click = Pause\nRight Click = Next";
        player-icons = {
          chromium = "";
          default = "";
          firefox = "";
          kdeconnect = "";
          mopidy = "";
          mpv = "󰐹";
          spotify = "";
          vlc = "󰕼";
        };
        status-icons = {
          paused = "󰐎";
          playing = "";
          stopped = "";
        };
        # ignored-players = [firefox]
        max-length = 30;
      };

      network = {
        format = "{ifname}";
        format-wifi = "{icon}";
        format-ethernet = "󰌘";
        format-disconnected = "󰌙";
        tooltip-format = "{ipaddr}  {bandwidthUpBits}  {bandwidthDownBits}";
        format-linked = "󰈁 {ifname} (No IP)";
        tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
        tooltip-format-ethernet = "{ifname} 󰌘";
        tooltip-format-disconnected = "󰌙 Disconnected";
        max-length = 30;
        format-icons = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
        on-click-right = "$HOME/.config/hypr/scripts/WaybarScripts.sh --nmtui";
      };

      "network#speed" = {
        interval = 1;
        format = "{ifname}";
        format-wifi = "{icon}  {bandwidthUpBytes}  {bandwidthDownBytes}";
        format-ethernet = "󰌘  {bandwidthUpBytes}  {bandwidthDownBytes}";
        format-disconnected = "󰌙";
        tooltip-format = "{ipaddr}";
        format-linked = "󰈁 {ifname} (No IP)";
        tooltip-format-wifi = "{essid} {icon} {signalStrength}%";
        tooltip-format-ethernet = "{ifname} 󰌘";
        tooltip-format-disconnected = "󰌙 Disconnected";
        min-length = 24;
        max-length = 24;
        format-icons = [
          "󰤯"
          "󰤟"
          "󰤢"
          "󰤥"
          "󰤨"
        ];
      };

      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile = {profile}\nDriver = {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon} 󰂰 {volume}%";
        format-muted = "󰖁";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            "󰕾"
            ""
          ];
          ignored-sinks = [
            "Easy Effects Sink"
          ];
        };
        scroll-step = 5.0;
        on-click = "$HOME/.config/hypr/scripts/Volume.sh --toggle";
        on-click-right = "pavucontrol -t 3";
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --dec";
        tooltip-format = "{icon} {desc} | {volume}%";
        smooth-scrolling-threshold = 1;
      };

      "pulseaudio#1" = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon} {volume}%";
        format-bluetooth-muted = " {icon}";
        format-muted = "󰸈";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        on-click = "pamixer --toggle-mute";
        on-click-right = "pavucontrol -t 3";
        tooltip = true;
        tooltip-format = "{icon} {desc} | {volume}%";
      };

      "pulseaudio#microphone" = {
        format = "{format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        on-click = "$HOME/.config/hypr/scripts/Volume.sh --toggle-mic";
        on-click-right = "pavucontrol -t 4";
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --mic-inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --mic-dec";
        tooltip-format = "{source_desc} | {source_volume}%";
        scroll-step = 5;
      };

      tray = {
        icon-size = 20;
        spacing = 4;
      };

      wireplumber = {
        format = "{icon} {volume} %";
        format-muted = " Mute";
        on-click = "$HOME/.config/hypr/scripts/Volume.sh --toggle";
        on-click-right = "pavucontrol -t 3";
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --dec";
        format-icons = [
          ""
          ""
          "󰕾"
          ""
        ];
      };

      "wlr/taskbar" = {
        format = "{icon} {name}";
        icon-size = 16;
        all-outputs = false;
        tooltip-format = "{title}";
        on-click = "activate";
        on-click-middle = "close";
        ignore-list = [
          "wofi"
          "rofi"
          "kitty"
          "kitty-dropterm"
        ];
      };

      "hyprland/workspaces" = {
        active-only = false;
        all-outputs = true;
        format = "{icon}";
        show-special = false;
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        persistent-workspaces = {
          "*" = 5;
        };
        format-icons = {
          active = "";
          default = "";
        };
      };
      # ROMAN Numerals style
      "hyprland/workspaces#roman" = {
        active-only = false;
        all-outputs = true;
        format = "{icon}";
        show-special = false;
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        persistent-workspaces = {
          "*" = 5;
        };
        format-icons = {
          "1" = "I";
          "2" = "II";
          "3" = "III";
          "4" = "IV";
          "5" = "V";
          "6" = "VI";
          "7" = "VII";
          "8" = "VIII";
          "9" = "IX";
          "10" = "X";
        };
      };
      # PACMAN Style
      "hyprland/workspaces#pacman" = {
        active-only = false;
        all-outputs = true;
        format = "{icon}";
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        show-special = false;
        persistent-workspaces = {
          "*" = 5;
        };
        format-icons = {
          active = "<span font='12'>󰮯</span>";
          empty = "<span font='8'></span>";
          default = "󰊠";
        };
      };
      # Kanji / Japanese style
      "hyprland/workspaces#kanji" = {
        disable-scroll = true;
        show-special = false;
        all-outputs = true;
        format = "{icon}";
        persistent-workspaces = {
          "*" = 5;
        };
        format-icons = {
          "1" = "一";
          "2" = "二";
          "3" = "三";
          "4" = "四";
          "5" = "五";
          "6" = "六";
          "7" = "七";
          "8" = "八";
          "9" = "九";
          "10" = "十";
        };
      };
      # for Camilla or Spanish
      "hyprland/workspaces#cam" = {
        active-only = false;
        all-outputs = true;
        format = "{icon}";
        show-special = false;
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        persistent-workspaces = {
          "*" = 5;
        };
        format-icons = {
          "1" = "Uno";
          "2" = "Due";
          "3" = "Tre";
          "4" = "Quattro";
          "5" = "Cinque";
          "6" = "Sei";
          "7" = "Sette";
          "8" = "Otto";
          "9" = "Nove";
          "10" = "Dieci";
        };
      };

      #  NUMBERS and ICONS style
      "hyprland/workspaces#4" = {
        # format = "{name}";
        format = "{name} {icon} ";
        #format =  {icon} ;
        show-special = false;
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        all-outputs = true;
        sort-by-number = true;
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "7" = "";
          "8" = "";
          "9" = "";
          "10" = 10;
          "focused" = "";
          "default" = ";";
        };
      };
      # numbers styles
      ":" = {
        active-only = false;
        all-outputs = true;
        format = "{icon}";
        show-special = false;
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        persistent-workspaces = {
          "*" = 5;
        };
        format-icons = {
          "1" = 1;
          "2" = 2;
          "3" = 3;
          "4" = 4;
          "5" = 5;
          "6" = 6;
          "7" = 7;
          "8" = 8;
          "9" = 9;
          "10" = 10;
        };
      };
      # NUMBERS and ICONS style with window rewrite
      "hyprland/workspaces#rw" = {
        disable-scroll = true;
        all-outputs = true;
        warp-on-scroll = false;
        sort-by-number = true;
        show-special = false;
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
        persistent-workspaces = {
          "*" = 5;
        };
        format = "{icon} {windows}";
        format-window-separator = "";
        window-rewrite-default = "";
        window-rewrite = {
          "title<.*amazon.*>" = "";
          "title<.*reddit.*>" = "";

          "class<firefox|org.mozilla.firefox|librewolf|floorp|mercury-browser|[Cc]achy-browser>" = "";
          "class<zen>" = "󰰷";
          "class<waterfox|waterfox-bin>" = "";
          "class<microsoft-edge>" = "";
          "class<Chromium|Thorium|[Cc]hrome>" = "";
          "class<brave-browser>" = "🦁";
          "class<tor browser>" = " ";
          "class<firefox-developer-edition>" = "🦊";

          "class<kitty|konsole>" = "";
          "class<kitty-dropterm>" = " ";
          "class<com.mitchellh.ghostty>" = "";
          "class<org.wezfurlong.wezterm>" = "";

          "class<[Tt]hunderbird|[Tt]hunderbird-esr>" = "";
          "class<eu.betterbird.Betterbird>" = "";
          "title<.*gmail.*>" = "󰊫";

          "class<[Tt]elegram-desktop|org.telegram.desktop|io.github.tdesktop_x64.TDesktop>" = " ";
          "class<discord|[Ww]ebcord|Vesktop>" = " ";
          "title<.*whatsapp.*>" = "";
          "title<.*zapzap.*>" = "";
          "title<.*messenger.*>" = "";
          "title<.*facebook.*>" = "";

          "title<.*ChatGPT.*>" = "󰚩";
          "title<.*deepseek.*>" = "󰚩";
          "title<.*qwen.*>" = "󰚩";
          "class<subl>" = "󰅳";
          "class<slack>" = "";

          "class<mpv>" = "";
          "class<celluloid|Zoom>" = "";
          "class<Cider>" = "󰎆";
          "title<.*Picture-in-Picture.*>" = "";
          "title<.*youtube.*>" = "";
          "class<vlc>" = "󰕼";
          "title<.*cmus.*>" = " ";
          "class<[Ss]potify>" = " ";

          "class<virt-manager>" = "";
          "class<.virt-manager-wrapped>" = "";
          "class<virtualbox manager>" = "💽";
          "title<virtualbox>" = "💽";
          "class<remmina>" = "🖥️";

          "class<VSCode|code-url-handler|code-oss|codium|codium-url-handler|VSCodium>" = "󰨞";
          "class<dev.zed.Zed>" = "󰵁";
          "class<codeblocks>" = "󰅩";
          "title<.*github.*>" = "";
          "class<mousepad>" = "";
          "class<libreoffice-writer>" = "";
          "class<libreoffice-startcenter>" = "󰏆";
          "class<libreoffice-calc>" = "";
          "title<.*nvim ~.*>" = "";
          "title<.*vim.*>" = "";
          "title<.*nvim.*>" = "";
          "title<.*figma.*>" = "";
          "title<.*jira.*>" = "";
          "class<jetbrains-idea>" = "";

          "class<obs|com.obproject.Studio>" = "";
          "class<polkit-gnome-authentication-agent-1>" = "󰒃";
          "class<nwg-look>" = " ";
          "class<[Pp]avucontrol|org.pulseaudio.pavucontrol>" = "󱡫";
          "class<steam>" = "";
          "class<thunar|nemo>" = "󰝰";
          "class<Gparted>" = "";
          "class<gimp>" = "";
          "class<emulator>" = "📱";
          "class<android-studio>" = " ";
          "class<org.pipewire.Helvum>" = "󰓃";
          "class<localsend>" = "";
          "class<PrusaSlicer|UltiMaker-Cura|OrcaSlicer>" = "󰹛";
        };
      };
      "custom/weather" = {
        format = "{}";
        format-alt = "{alt} = {}";
        format-alt-click = "click";
        interval = 3600;
        return-type = "json";
        exec = "$HOME/.config/hypr/UserScripts/Weather.py";
        #exec = $HOME/.config/hypr/UserScripts/Weather.sh;
        #exec-if = ping wttr.in -c1;
        tooltip = true;
      };

      "custom/file_manager" = {
        format = "";
        on-click = "$HOME/.config/hypr/scripts/WaybarScripts.sh --files";
        tooltip = true;
        tooltip-format = "File Manager";
      };

      "custom/tty" = {
        format = " ";
        on-click = "$HOME/.config/hypr/scripts/WaybarScripts.sh --term";
        tooltip = true;
        tooltip-format = "Launch Terminal";
      };

      "custom/browser" = {
        format = "";
        on-click = "xdg-open https =#";
        tooltip = true;
        tooltip-format = "Launch Browser";
      };

      "custom/settings" = {
        format = "";
        on-click = "$HOME/.config/hypr/scripts/Kool_Quick_Settings.sh";
        tooltip = true;
        tooltip-format = "Launch KooL Hyprland Settings Menu";
      };

      "custom/cycle_wall" = {
        format = "";
        on-click = "$HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
        on-click-right = "$HOME/.config/hypr/UserScripts/WallpaperRandom.sh";
        on-click-middle = "$HOME/.config/hypr/scripts/WaybarStyles.sh";
        tooltip = true;
        tooltip-format = "Left Click = Wallpaper Menu\nMiddle Click = Random wallpaper\nRight Click = Waybar Styles Menu";
      };

      "custom/hint" = {
        format = "󰺁 HINT!";
        on-click = "$HOME/.config/hypr/scripts/KeyHints.sh";
        on-click-right = "$HOME/.config/hypr/scripts/KeyBinds.sh";
        tooltip = true;
        tooltip-format = "Left Click = Quick Tips\nRight Click = Keybinds";
      };

      "custom/dot_update" = {
        format = "󰁈";
        on-click = "$HOME/.config/hypr/scripts/KooLsDotsUpdate.sh";
        tooltip = true;
        tooltip-format = "Check KooL Dots update\nIf available";
      };

      # Hypridle inhibitor
      "custom/hypridle" = {
        format = "󱫗";
        return-type = "json";
        escape = true;
        exec-on-event = true;
        interval = 60;
        exec = "$HOME/.config/hypr/scripts/Hypridle.sh status";
        on-click = "$HOME/.config/hypr/scripts/Hypridle.sh toggle";
        on-click-right = "hyprlock";
      };

      "custom/keyboard" = {
        exec = "cat $HOME/.cache/kb_layout";
        interval = 1;
        format = " {}";
        on-click = "$HOME/.config/hypr/scripts/SwitchKeyboardLayout.sh";
      };

      "custom/light_dark" = {
        format = "󰔎";
        on-click = "$HOME/.config/hypr/scripts/DarkLight.sh";
        on-click-right = "$HOME/.config/hypr/scripts/WaybarStyles.sh";
        on-click-middle = " $HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
        tooltip = true;
        tooltip-format = "Left Click = Switch Dark-Light Themes\nMiddle Click = Wallpaper Menu\nRight Click = Waybar Styles Menu";
      };

      "custom/lock" = {
        format = "󰌾";
        on-click = "$HOME/.config/hypr/scripts/LockScreen.sh";
        tooltip = true;
        tooltip-format = "󰷛 Screen Lock";
      };

      "custom/menu" = {
        format = "";
        on-click = "pkill rofi || rofi -show drun -modi run;drun;filebrowser;window";
        on-click-middle = "$HOME/.config/hypr/UserScripts/WallpaperSelect.sh";
        on-click-right = "$HOME/.config/hypr/scripts/WaybarLayout.sh;";
        tooltip = true;
        tooltip-format = "Left Click = Rofi Menu\nMiddle Click = Wallpaper Menu\nRight Click = Waybar Layout Menu";
      };
      # This is a custom cava visualizer
      "custom/cava_mviz" = {
        exec = "$HOME/.config/hypr/scripts/WaybarCava.sh";
        format = { };
      };

      "custom/playerctl" = {
        format = "<span>{}</span>";
        return-type = "json";
        max-length = 25;
        exec = "playerctl -a metadata --format '{\text\ = \{{artist}}  {{markup_escape(title)}}\; \tooltip\ = \{{playerName}}  = {{markup_escape(title)}}\; \alt\ = \{{status}}\; \class\ = \{{status}}\}' -F";
        on-click-middle = "playerctl play-pause";
        on-click = "playerctl previous";
        on-click-right = "playerctl next";
        scroll-step = 5.0;
        on-scroll-up = "$HOME/.config/hypr/scripts/Volume.sh --inc";
        on-scroll-down = "$HOME/.config/hypr/scripts/Volume.sh --dec";
        smooth-scrolling-threshold = 1;
      };

      "custom/power" = {
        format = "⏻";
        on-click = "$HOME/.config/hypr/scripts/Wlogout.sh";
        on-click-right = "$HOME/.config/hypr/scripts/ChangeBlur.sh";
        tooltip = true;
        tooltip-format = "Left Click = Logout Menu\nRight Click = Change Blur";
      };

      "custom/reboot" = {
        format = "󰜉";
        on-click = "systemctl reboot";
        tooltip = true;
        tooltip-format = "Left Click = Reboot";
      };

      "custom/quit" = {
        format = "󰗼";
        on-click = "hyprctl dispatch exit";
        tooltip = true;
        tooltip-format = "Left Click = Exit Hyprland";
      };

      "custom/swaync" = {
        tooltip = true;
        tooltip-format = "Left Click = Launch Notification Center\nRight Click = Do not Disturb";
        format = "{} {icon}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "sleep 0.1 && swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };
      # NOTE =! This is mainly for Arch and Arch Based Distros  depend = pacman-contrib
      # Other Distro dont have notifications but can use to check for update for any other distro
      "custom/updater" = {
        format = " {}";
        exec = "checkupdates | wc -l";
        exec-if = "[[ $(checkupdates | wc -l) ]]";
        interval = 43200; # (Arch Linux will try to check 12 hrs interval only
        on-click = "$HOME/.config/hypr/scripts/Distro_update.sh";
        tooltip = true;
        tooltip-format = "Left Click = Update System\nArch (w/ notification)\nFedora; OpenSuse; Debian/Ubuntu click to update";
      };
      # Separators
      "custom/separator#dot" = {
        format = "";
        interval = "once";
        tooltip = false;
      };
      "custom/separator#dot-line" = {
        format = "";
        interval = "once";
        tooltip = false;
      };
      "custom/separator#line" = {
        format = "|";
        interval = "once";
        tooltip = false;
      };
      "custom/separator#blank" = {
        format = "";
        interval = "once";
        tooltip = false;
      };
      "custom/separator#blank_2" = {
        format = "";
        interval = "once";
        tooltip = false;
      };
      "custom/separator#blank_3" = {
        format = "";
        interval = "once";
        tooltip = false;
      };
      "custom/arrow1" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow2" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow3" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow4" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow5" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow6" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow7" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow8" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow9" = {
        format = "";
        tooltip = false;
      };

      "custom/arrow10" = {
        format = "";
        tooltip = false;
      };
      "group/app_drawer" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "custom/menu";
          transition-left-to-right = true;
        };
      };
      "group/motherboard" = {
        orientation = "horizontal";
      };

      "group/mobo_drawer" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "cpu";
          transition-left-to-right = true;
        };
      };
      "group/laptop" = {
        orientation = "inherit";
      };
      "group/audio" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "pulseaudio";
          transition-left-to-right = true;
        };
      };

      "group/connections" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "bluetooth";
          transition-left-to-right = true;
        };
      };

      "group/status" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "custom/power";
          transition-left-to-right = false;
        };
      };
      "group/notify" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "custom/swaync";
          transition-left-to-right = false;
        };
      };

      "group/power" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 500;
          children-class = "drawer-child";
          transition-left-to-right = false;
        };
      };
      # groups for vertical
      "group/power#vert" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 300;
          children-class = "not-memory";
          transition-left-to-right = false;
        };
      };

      "niri/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "I";
          "2" = "II";
          "3" = "III";
          "4" = "IV";
          "5" = "V";
          "6" = "VI";
          "7" = "VII";
          "8" = "VIII";
          "9" = "IX";
          "10" = "X";
          active = "";
          default = "";
        };
      };
    };
  };
}
