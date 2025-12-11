{ config
, pkgs
, host
, username
, options
, inputs
, lib
, libPkgs
, ...
}:
let
  inherit (import ./variables.nix) keyboardLayout;
in
{
  # Register flake inputs for nix commands
  nix.registry =
    lib.mapAttrs (_: flake: { inherit flake; })
      (lib.filterAttrs (_: lib.isType "flake") inputs)
    // {
      # Add nixpkgs to the registry
      nixpkgs = { flake = inputs.nixpkgs; };
    };

  # Add inputs to legacy channels
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  imports = [
    ./kde.nix
    ./hardware.nix
    ./users.nix
    ./packages.nix
    # ./clickcapital-parser.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    # "${inputs.nix-mineral}/nix-mineral.nix"
  ];

  drivers.intel.enable = true;

  # nixpkgs.pkgs is set via readOnlyPkgs in lib/default.nix
  # The pkgs is pre-configured with allowUnfree and overlays there

  security.sudo.wheelNeedsPassword =
    false; # Allow sudo without password for wheel group
  boot = {
    # kernelPackages = pkgs.linuxPackages_zen; # Performance geared
    kernelPackages = pkgs.linuxPackages_latest; # Best Balance
    # kernelPackages = pkgs.linuxPackages_testing; # Bleeding edge

    kernelParams = [
      # silent
      "quiet"
      "loglevel=3"
      "splash"
      "boot.shell_on_fail"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      "snd-intel-dspcfg.dsp_driver=3"
      "sof-transport-ipc=3"
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      # "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
      "vt.default_red=36,237,166,238,138,245,139,184,91,237,166,238,138,245,139,165"
      "vt.default_grn=39,135,218,212,173,189,213,192,96,135,218,212,173,189,213,173"
      "vt.default_blu=58,150,149,159,244,230,202,224,120,150,149,159,244,230,202,203"
    ];

    extraModprobeConfig = ''
      options snd_sof_intel_hda_common dmic_num=4
      options btusb rtk_enable=1
      options rtw88_core disable_lps_deep=Y
      options rtw88_pci disable_aspm=Y
    '';

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "uas"
        "usbhid"
        "sd_mod"
        "sdhci_pci"
      ];
      kernelModules = [ "kvm-intel" ];
    };
    # extraModulePackages = [config.boot.kernelPackages.cpufreqtools];
    # Needed For Some Steam Games
    # kernel.sysctl = {
    #   "vm.max_map_count" = 2147483642; # try 262144, 1048576 or disable block
    # };

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot.enable = true;
    loader.grub.enable = false;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 10;

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
      mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
      magicOrExtension = "\\x7fELF....AI\\x02";
    };

    plymouth = { enable = true; };
  };

  time.hardwareClockInLocalTime = true;
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  };

  # Set your time zone.
  # services.automatic-timezoned.enable = true; #based on IP location

  #https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "Asia/Jerusalem"; # Set local timezone

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # extraLocales = [ "he_IL.UTF-8/UTF-8" ];

    extraLocaleSettings = {
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
  };

  systemd.tmpfiles.rules = [
    # -----------------------------------------------------------
    # Core Shells
    # -----------------------------------------------------------

    # 1. /bin/bash (The most common hardcoded shebang)
    "L+ /bin/bash - - - - ${pkgs.bash}/bin/bash"

    # 2. /bin/sh (The default POSIX shell)
    # NOTE: On NixOS, 'sh' is often linked to the simpler 'dash' for performance,
    # but we can link it directly to bash if you prefer, or the coreutils 'sh'.
    # If you don't know 'dash', linking to bash is generally safe.
    "L+ /bin/sh - - - - ${pkgs.bash}/bin/sh"

    # 3. /usr/bin/zsh (If you have scripts using #!/usr/bin/zsh)
    "L+ /usr/bin/zsh - - - - ${pkgs.zsh}/bin/zsh"

    # -----------------------------------------------------------
    # Common Interpreters and Utilities
    # -----------------------------------------------------------

    # 4. /usr/bin/env (Crucial for the #!/usr/bin/env shebang style)
    "L+ /usr/bin/python - - - - ${pkgs.python312}/bin/python"
    "L+ /usr/bin/python3 - - - - ${pkgs.python312}/bin/python3"
    "L+ /usr/bin/python3.12 - - - - ${pkgs.python312}/bin/python3.12" # Optional, but safer
  ];
  programs.localsend.enable = true;

  # Services to start
  services = {
    openssh = {
      enable = true;
      authorizedKeysFiles = [ config.sops.secrets."ssh_keys/github".path ];
    };
    logind = {
      settings.Login = {
        HandleLidSwitch = "sleep";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
      };
    };
    power-profiles-daemon.enable = false;
    fprintd.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_MIN_FREQ_ON_BAT = 400000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 3000000;

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        PLATFORM_PROFILE_ON_AC = "low-power";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        USB_EXCLUDE_BTUSB = 1;
        USB_AUTOSUSPEND = 0;
        USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN = 1;

        AMDGPU_ABM_LEVEL_ON_AC = 0;
        AMDGPU_ABM_LEVEL_ON_BAT = 3;

        DISK_IOSCHED = [ "none" ];
        DISK_APM_LEVEL_ON_BAT = "1 1";

        SATA_LINKPWR_ON_BAT = "min_power";
        PCIE_ASPM_ON_AC = "performance";
        PCIE_ASPM_ON_BAT = "powersupersave";

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        WIFI_PWR_ON_BAT = "on";

        SOUND_POWER_SAVE_ON_BAT = 0;
        SOUND_POWER_SAVE_CONTROLLER = "N";

        # Battery charge thresholds for on-road usage
        START_CHARGE_THRESH_BAT0 = 85;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };
    xserver = {
      enable = lib.mkForce false; # Disable X11 entirely - was just false
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };

    # Cron Job for Swing Trade Newsletter parser
    # cron = {
    #   enable = true;
    #   systemCronJobs = [
    #     "0 9 * * * lf $ /home/lf/repos/clickcapitalparser/process_alerts.py"
    #     # removed `{pkgs.python3}/bin/python3`
    #   ];
    # };

    greetd = {
      enable = lib.mkDefault true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    # colormix doom dummy durfile gameoflife Matrix

    # displayManager.ly = {
    #   enable = true;
    #   settings = { animation = "doom"; };
    # };
    # smartd = {
    #   enable = true;
    #   autodetect = true;
    # };

    gvfs.enable = true;
    # tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    pulseaudio.enable = false; # unstable
    udev.enable = true;

    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;
    rpcbind.enable = false;
    nfs.server.enable = false;

    flatpak.enable = true;
    blueman.enable = true;

    #hardware.openrgb.enable = true;
    #hardware.openrgb.motherboard = "amd";

    fwupd.enable = false;
    upower.enable = lib.mkForce true;
    gnome.gnome-keyring.enable = true;

    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "${config.users.users.${username}.home}";
      configDir = "${config.users.users.${username}.home}/.config/syncthing";
      relay.enable = true;
    };

    # telegraf = {
    #   enable = true;
    #   extraConfig = {
    #     inputs = {
    #       cpu = {
    #         percpu = true;
    #         totalcpu = true;
    #       };
    #       mem = { };
    #       disk = { };
    #       diskio = { };
    #       net = { };
    #       system = { };
    #       processes = { };
    #       swap = { };
    #       internal = { };
    #     };
    #     outputs = {
    #       http = {
    #         url = "http://127.0.0.1:8181/api/v3/write_lp?db=nixos_metrics";
    #         method = "POST";
    #         data_format = "influx";
    #         headers = {
    #           "Authorization" = "Token ${config.sops.secrets."influxdb".path}";
    #         };
    #       };
    #     };
    #   };
    # };
    # grafana = {
    #   enable = true;
    #   # Optional: Configure it to start automatically on your local machine
    #   settings.server.root_url = "http://localhost:3000";
    #   settings.security.admin_user = "admin";
    #   settings.security.admin_password = "Token ${config.sops.secrets."influxdb".path}";
    # };
  };

  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  # powerManagement = {
  #   enable = false;
  #   cpuFreqGovernor = "powersave"; # or "performance" or "schedutil";
  # };

  # Extra Logitech Support
  hardware = {
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true;
  };

  # Bluetooth
  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = false;
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
    polkit = {
      enable = true;
      extraConfig = ''
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
    pam.services.hyprlock = { };
  };

  musnix = {
    enable = true;

    # DEFINITELY KEEP FALSE for simple playback
    # Prevents long compile times and potential instability
    kernel.realtime = false;

    # OPTIONAL: Useful tool to check if your system is bottlenecking audio
    rtcqs.enable = true;
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://hyprland.cachix.org" "https://numtide.cachix.org" ];
      extra-substituters = [ "https://vicinae.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      extra-trusted-public-keys = [ "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6ZZcQjb41X0iXVXeHigGmycPPE=" "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];

      extraOptions = ''
        # access-tokens = github.com=${
          config.sops.secrets."api_keys/github_mcp".path
        }
        !include ${config.sops.secrets."github_pat".path}
      '';
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      optimise.automatic = true;
    };
  };

  # Virtualization / Containers
  virtualisation = {
    libvirtd.enable = false;
    podman = {
      enable = false;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = false;
    };

    docker = {
      enable = true;
      rootless.enable = false;
      autoPrune.enable = true;
      enableOnBoot = true;
      extraPackages = [ pkgs.docker-buildx ];
    };
  };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Enable Wayland Ozone platform for Electron apps
      NIXOS_WAYLAND = "1"; # Force Wayland
      ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Or "AUTO"
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      # QT_QPA_PLATFORM_THEME = "qt6ct";
      # ELECTRON_ENABLE_WAYLAND = "1";
      NH_FLAKE = "${config.users.users.lf.home}/nix";
      INFLUX_TOKEN = config.sops.secrets."influxdb".path;
    };
    variables = {
      # Make the fzf shell integration available to all users.
      # This path is determined by a system package (`pkgs.fzf`).
      FZF_SHELL_DIR = "${pkgs.fzf}/share/fzf";
      # QT_QPA_PLATFORM = "wayland;xcb";
    };
  };

  programs = {
    hyprland = {
      enable = true;
      package = (libPkgs inputs.hyprland).hyprland;
      xwayland.enable = true;
      withUWSM = false;
      extraConfig = ''
        exec-once = wl-paste --type text --watch cliphist store
        exec-once = wl-paste --type image --watch cliphist store
      '';
    }; # Zsh configuration
    zsh = {
      enable = true;
      # enableCompletion = true;
      ohMyZsh.enable = false;
      setOptions = [ "nonomatch" "zle" ];

      # autosuggestions.enable = true;
      # syntaxHighlighting.enable = true;
      # promptInit = "";
    };
    niri.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
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
      # symbola

      # Noto Fonts
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-monochrome-emoji
      noto-fonts-color-emoji
      # Niche/Specific Fonts
      minecraftia
    ];
  };

  stylix = {
    enable = true;
    autoEnable = true;
    # targets.hyprland.enable = false;
    enableReleaseChecks = true;
    base16Scheme = ../../assets/base16_themes/catppuccin-frappe.yaml;
    # image = "/home/lf/Pictures/wallpapers/City-Night.png";

    overlays.enable = true;
    targets.qt.platform = lib.mkForce "qtct";
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [8086 3000];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  home-manager.sharedModules = [ inputs.zen-browser.homeModules.default ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
