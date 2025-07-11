{
  config,
  pkgs,
  host,
  username,
  options,
  lib,
  inputs,
  nixpkgs-unstable,
  # system,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    # ../../pkgs/disable-monitors.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];

  nixpkgs.overlays = [
    inputs.mcp-servers-nix.overlays.default
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (prev) system;
        config.allowUnfree = true;
      };
      claudia = inputs.claudia.packages.${prev.system}.default;
      # ags = inputs.ags.packages.${prev.system}.default;
      firefox-addons = inputs.firefox-addons.packages.${prev.system};
    })
    #     (final: prev: {
    #       nur =
    #         prev.nur
    #         // {
    #           repos =
    #             prev.nur.repos
    #             // {
    #               k3a =
    #                 prev.nur.repos.k3a
    #                 // {
    #                   ib-tws = prev.nur.repos.k3a.ib-tws.overrideAttrs (old: {
    #                     buildInputs = (old.buildInputs or []) ++ [ prev.openjfx pkgs.bash pkgs.findutils ];
    #                     installPhase = ''
    #                       runHook preInstall
    #                       # create main startup script
    #                       mkdir -p $out/bin
    #                       cat > $out/bin/ib-tws <<EOF
    # #!${pkgs.bash}/bin/sh
    # # get script name
    # PROG=\$(basename "\$0")
    # # Load system-wide settings and per-user overrides
    # IB_CONFIG_DIR="\$HOME/.\$PROG"
    # JAVA_GC="-Xmx4G -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:ParallelGCThreads=20 -XX:ConcGCThreads=5 -XX:InitiatingHeapOccupancyPercent=70"
    # JAVA_UI_FLAGS="-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on -Dsun.awt.nopixfmt=true -Dsun.java2d.noddraw=true -Dswing.boldMetal=false -Dsun.locale.formatasdefault=true"
    # JAVA_LOCALE_FLAGS="-Dsun.locale.formatasdefault=true"
    # JAVA_FLAGS="\$JAVA_GC \$JAVA_UI_FLAGS \$JAVA_LOCALE_FLAGS --add-opens=java.desktop/javax.swing=ALL-UNNAMED \$JAVA_EXTRA_FLAGS"
    # [ -f "\$HOME/.config/\$PROG.conf" ] && . "\$HOME/.config/\$PROG.conf"
    # CLASS="jclient.LoginFrame"
    # [ "\$PROG" = "ib-gw" ] && CLASS="ibgateway.GWClient"
    # cd "$out/share/${old.pname}/jars"
    # "${prev.jdk17}/bin/java" -cp "*" \$JAVA_FLAGS \$CLASS \$IB_CONFIG_DIR
    # EOF
    #                       chmod +x $out/bin/ib-tws

    #                       # create symlink for the gateway
    #                       ln -s $out/bin/ib-tws "$out/bin/ib-gw"

    #                       # copy files
    #                       mkdir -p $out/share/${old.pname}
    #                       cp -R jars $out/share/${old.pname}
    #                       install -Dm644 .install4j/tws.png $out/share/pixmaps/${old.pname}.png

    #                       # Copy JavaFX jars to where the application expects them
    #                       find ${prev.openjfx} -name "*.jar" -exec cp {} $out/share/${old.pname}/jars/ \;

    #                       runHook postInstall
    #                     '';
    #                   });
    #                 };
    #             };
    #         };
    #     })
  ];

  nixpkgs.config.allowUnfree = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen; # Performance geared
    # kernelPackages = pkgs.linuxPackages_latest; # Best Balance
    # kernelPackages = pkgs.linuxPackages_testing; # Bleeding edge

    kernelParams = [
      # "snd-intel-dspcfg.dsp_driver=0"
      # "snd-intel-dspcfg.dsp_driver=1"
      # "snd-intel-dspcfg.dsp_driver=2"
      "snd-intel-dspcfg.dsp_driver=3"
      "sof-transport-ipc=3"
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      # "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
      "vt.default_red=48,231,166,229,140,244,129,181,98,231,166,229,140,244,129,165"
      "vt.default_grn=52,130,209,200,170,184,200,191,104,130,209,200,170,184,200,173"
      "vt.default_blu=70,132,137,144,238,228,190,226,128,132,137,144,238,228,190,206"
    ];

    extraModprobeConfig = ''
      options snd_sof_intel_hda_common dmic_num=4
      options btusb rtk_enable=1
    '';

    #   options available for the snd_hda_intel driver:
    #  * `auto`: This is the default setting. The driver attempts to automatically detect the hardware configuration. It's the baseline and the first thing to
    #    try if you haven't.
    #  * `dell-headset-multi`: This is the option you've already tried. It's designed for modern Dell laptops that have a single 4-pin audio jack that can
    #    handle both a headset and a microphone.
    #  * `dell-vostro`: Since you have a Dell Vostro laptop, this is a very strong candidate to try. It's specifically tailored for Vostro models.
    #  * `headset-mic`: A more generic version of dell-headset-multi, for non-Dell laptops with a single combined headset/microphone jack. It's less likely to
    #    be better than the Dell-specific ones, but it's an option.
    #  * `laptop-amic` / `laptop-dmic`: These are generic options for laptops with analog (amic) or digital (dmic) microphones. Modern laptops often have
    #    digital microphone arrays, so laptop-dmic could be relevant if the issue is primarily with the internal microphone.

    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "uas" "usbhid" "sd_mod" "sdhci_pci"];
      kernelModules = ["kvm-intel"];
    };
    extraModulePackages = [];
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5;

    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    plymouth.enable = true;
  };

  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    timeServers =
      options.networking.timeServers.default
      ++ [
        "pool.ntp.org"
      ];
  };

  # Set your time zone.
  # services.automatic-timezoned.enable = true; #based on IP location

  #https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "Asia/Jerusalem"; # Set local timezone

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };

    # unison = {
    #   enable = true;
    #   profiles = {
    #     org = {
    #       src = "/home/moredhel/org";
    #       dest = "/home/moredhel/org.backup";
    #       extraArgs = "-batch -watch -ui text -repeat 60 -fat";
    #     };
    #   };
    # };

    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet
          --time --cmd Hyprland";
        };
      };
    };

    smartd = {
      enable = true;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    pulseaudio.enable = false; #unstable
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;
    rpcbind.enable = false;
    nfs.server.enable = false;
    openssh.enable = true;
    flatpak.enable = true;
    blueman.enable = true;

    #hardware.openrgb.enable = true;
    #hardware.openrgb.motherboard = "amd";

    fwupd.enable = false;
    upower.enable = true;
    gnome.gnome-keyring.enable = true;

    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};

    #ipp-usb.enable = true;

    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };
  };

  # systemd.services = {
  #    # Service to clone your private GitLab repository
  #    initial-clone-gitlab = {
  #      description = "Initial clone of private GitLab repository";
  #      wants = [ "network-online.target" ];
  #      after = [ "network-online.target" ];
  #      # ADD THIS BLOCK: Make commands available to the script
  #      path = [
  #        pkgs.gitFull      # Provides 'git'
  #        pkgs.util-linux   # Provides 'runuser'
  #      ];
  #      script = ''
  #        if [ ! -d "/home/${username}/git/laurent.flaster" ]; then
  #          mkdir -p /home/${username}/git
  #          chown ${username} /home/${username}/git
  #          runuser -u ${username} -- git clone https://git.infinitylabs.co.il/ilrd/ramat-gan/ai3/laurent.flaster.git /home/${username}/git/laurent.flaster
  #        fi
  #      '';
  #      serviceConfig = {
  #        Type = "oneshot";
  #        RemainAfterExit = true;
  #        User = "root";
  #      };
  #    };

  # Service to clone your Obsidian Brain repository
  #   initial-clone-brain = {
  #     description = "Initial clone of Obsidian Brain repository";
  #     wants = ["network-online.target"];
  #     after = ["network-online.target"];
  #     # ADD THIS BLOCK: Make commands available to the script
  #     path = [
  #       pkgs.gitFull # Provides 'git'
  #       pkgs.util-linux # Provides 'runuser'
  #     ];
  #     script = ''
  #       if [ ! -d "/home/${username}/Obsidian/brain" ]; then
  #         mkdir -p /home/${username}/Obsidian
  #         chown ${username} /home/${username}/Obsidian
  #         runuser -u ${username} -- git clone https://github.com/batou069/brain.git /home/${username}/Obsidian/brain
  #       fi
  #     '';
  #     serviceConfig = {
  #       Type = "oneshot";
  #       RemainAfterExit = true;
  #       User = "root";
  #       PrivateTmp = false;
  #       ProtectHome = false;
  #     };
  #   };
  # };
  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware = {
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true;
  };

  hardware.enableRedistributableFirmware = true;

  #  hardware.graphics = {
  #    enable = true;
  #  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # Security / Polkit
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
       polkit.addRule(function(action, subject) {
         if (
           subject.isInGroup("users")
             && (
               action.id == "org.freedesktop.login1.reboot" ||
               action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
               action.id == "org.freedesktop.login1.power-off" ||
               action.id == "org.freedesktop.login1.power-off-multiple-sessions"
             )
           )
         {
           return polkit.Result.YES;
         }
      })
    '';
  };
  # security.pam.services.swaylock = {
  #   text = ''
  #     auth include login
  #   '';
  # };
  security.pam.services.hyprlock = {};
  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = false;
    autoPrune.enable = true;
    enableOnBoot = true;
  };

  console.keyMap = "${keyboardLayout}";

  # environment.systemPackages = with pkgs; [
  #   pulseaudio
  # ];

  # For Electron apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Enable Wayland Ozone platform for Electron apps
    ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Or "AUTO"
    # You might also try:
    ELECTRON_ENABLE_WAYLAND = "1";
    NH_FLAKE = "/home/lf/nix";
  };

  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh.enable = false;

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = "";
    };
  };

  #  niri.enable = true;

  systemd.services.user-session-env = {
    script = ''
          export OPENAI_API_KEY="$(cat
      ${config.sops.secrets."api_keys/openai".path})"
          export GEMINI_API_KEY="$(cat
      ${config.sops.secrets."api_keys/gemini".path})"
          export ANTHROPIC_API_KEY="$(cat
      ${config.sops.secrets."api_keys/anthropic".path})"
    '';
  };

  # environment.variables.FZF_SHELL_DIR = "${pkgs.fzf}/share/fzf";
  # qt.platformTheme.name = "kvantum";
  # qt.style = "kvantum";
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      # General Purpose / Sans-Serif Fonts
      # dejavu_fonts
      ibm-plex
      inter
      roboto
      aleo-fonts

      # Monospace / Programming Fonts
      fira-code
      jetbrains-mono
      hackgen-nf-font
      roboto-mono
      terminus_font
      victor-mono
      nerd-fonts.im-writing
      nerd-fonts.fantasque-sans-mono
      maple-mono.NF
      recursive
      cascadia-code

      # Icon / Symbol Fonts
      font-awesome
      fira-code-symbols
      material-icons
      powerline-fonts
      symbola

      # Noto Fonts
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-monochrome-emoji
      noto-fonts-color-emoji
      # Niche/Specific Fonts
      minecraftia
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP"
          "Noto Serif"
        ];

        sansSerif = [
          "Noto Sans CJK JP"
          "Noto Sans"
        ];

        monospace = [
          "Noto Sans Mono CJK JP"
          "Noto Sans Mono"
        ];
      };

      allowBitmaps = false;
    };
  };

  stylix = {
    enable = true;
    enableReleaseChecks = true;
    base16Scheme = ./schemes/phd.yaml;
    polarity = "dark";
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
    targets.nixvim.enable = false;
    # targets.firefox.profileNames = ["default"];
    cursor = lib.mkDefault {
      name = "catppuccin-mocha-blue-cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
      size = 24;
    };
    opacity = {
      applications = 0.95;
      desktop = 0.95;
      popups = 1.0;
      terminal = 0.95;
    };
    # overlays.enable = true;
    fonts = {
      serif = {
        # package = pkgs.aleo-fonts;
        # name = "Aleo";
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF Italic";
      };

      sansSerif = {
        # package = pkgs.noto-fonts-cjk-sans;
        # name = "Noto Sans CJK JP";
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF Italic";
      };

      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF Italic";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 13;
        desktop = 10;
        popups = 12;
        terminal = 14;
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
