{
  pkgs,
  lib,
  libPkgs,
  username,
  config,
  options,
  inputs,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
in {
  # Register flake inputs for nix commands
  nix.registry =
    lib.mapAttrs (_: flake: {inherit flake;})
    (lib.filterAttrs (_: lib.isType "flake") inputs)
    // {
      # Add nixpkgs to the registry
      nixpkgs = {flake = inputs.nixpkgs;};
    };

  # Add inputs to legacy channels
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  drivers.intel.enable = true;

  # nixpkgs.pkgs is set via readOnlyPkgs in lib/default.nix
  # The pkgs is pre-configured with allowUnfree and overlays there

  security = {
    sudo = {
      wheelNeedsPassword = false; # Allow sudo w/o pwd for wheel group
      extraConfig = ''
        Defaults lecture="never"                        # no lectures
        Defaults insults                                # insult when wrong pwd
        Defaults env_keep += "PATH PYTHONPATH TERMINFO" # if certain commands don't work under sudo because they can't find the Nix profile
      '';
    };
    doas = {
      enable = true;
      wheelNeedsPassword = false; # allow doas w/o pwd for wheel group
      extraConfig = ''

        permit keepenv :wheel         # fix for doas kitty env var conflict
        permit persist keepenv :wheel # keep pwd once typed
      '';
    };
  };

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
      # "vt.default_red=36,237,166,238,138,245,139,184,91,237,166,238,138,245,139,165"
      # "vt.default_grn=39,135,218,212,173,189,213,192,96,135,218,212,173,189,213,173"
      # "vt.default_blu=58,150,149,159,244,230,202,224,120,150,149,159,244,230,202,203"
      "vt.default_red=48,231,166,229,140,244,129,181,98,231,166,229,140,244,129,165"
      "vt.default_grn=52,130,209,200,170,184,200,191,104,130,209,200,170,184,200,173"
      "vt.default_blu=70,132,137,144,238,228,190,226,128,132,137,144,238,228,190,206"
    ];

    extraModprobeConfig = ''
      options snd_sof_intel_hda_common dmic_num=4
      options btusb rtk_enable=1
      options rtw88_core disable_lps_deep=Y
      options rtw88_pci disable_aspm=Y

      # claude suggestion to fix trackpad/bt issues
      options hid_magicmouse scroll_acceleration=1 scroll_speed=25
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
      kernelModules = ["kvm-intel" "v4l2loopback" "hid-magicmouse" "hid-apple" "btusb" "uhid"];
    };
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    # extraModulePackages = [config.boot.kernelPackages.cpufreqtools];
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642; # try 262144, 1048576 or disable block
    };

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

    plymouth = {enable = true;};
  };

  time.hardwareClockInLocalTime = true;
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
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
    "L+ /usr/bin/python - - - - ${pkgs.python314}/bin/python"
    "L+ /usr/bin/python3 - - - - ${pkgs.python314}/bin/python3"
    "L+ /usr/bin/python3.14 - - - - ${pkgs.python314}/bin/python3.14" # Optional, but safer
  ];
  programs.localsend.enable = true;

  # Services to start
  services = {
    openssh = {
      enable = true;
      authorizedKeysFiles = [config.sops.secrets."ssh_keys/github".path];
    };

    logind = {
      settings.Login = {
        HandleLidSwitch = "hybernate";
        HandleLidSwitchExternalPower = "sleep";
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

        DISK_IOSCHED = ["none"];
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
    udev = {
      enable = true;
      extraRules = ''
        SUBSYSTEM=="usb", ATTR{idVendor}=="17e", MODE="0666", GROUP="adbusers"
      '';
    };

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
    pam.services.hyprlock = {};
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      # --- Performance & UI Responsiveness ---
      max-jobs = 3; # Build 3 things at once
      cores = 0; # Let each job use all cores (throttled by priority)
      # daemon-build-users-priority = 10; # "Nice" level: Stay out of the way of my browser
      connect-timeout = 5;

      # --- Hygiene ---
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];

      # --- Binary Caches (Consolidated) ---
      # substituters = ["https://hyprland.cachix.org" "https://numtide.cachix.org"];
      substituters = [
        "https://cache.nixos.org" # Always keep the default
        "https://hyprland.cachix.org"
        "https://numtide.cachix.org"
        "https://vicinae.cachix.org"
        "https://cache.numtide.com"

        "https://cachix.cachix.org"
        "https://fencer.cachix.org"
        "https://ghcide-nix.cachix.org/"
        "https://hercules-ci.cachix.org/"
        "https://mpickering.cachix.org/"
        "https://nix-community.cachix.org"
        "https://nix-linter.cachix.org"
        "https://nixfmt.cachix.org"
        "https://pre-commit-hooks.cachix.org"
        "https://static-haskell-nix.cachix.org"
        "https://iammrinal0.cachix.org"


      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="

        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "fencer.cachix.org-1:Uc3oXF1AHnhrc7kwEAY+NHNH7BvkngdBiFLHPDCUVwA="
        "ghcide-nix.cachix.org-1:ibAY5FD+XWLzbLr8fxK6n8fL9zZe7jS+gYeyxyWYK5c="
        "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0="
        "mpickering.cachix.org-1:COxPsDJqqrggZgvKG6JeH9baHPue8/pcpYkmcBPUbeg="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-linter.cachix.org-1:BdTne5LEHQfIoJh4RsoVdgvqfObpyHO5L0SCjXFShlE="
        "nixfmt.cachix.org-1:uyEQg16IhCFeDpFV07aL+Dbmh18XHVUqpkk/35WAgJI="
        "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
        "static-haskell-nix.cachix.org-1:Q17HawmAwaM1/BfIxaEDKAxwTOyRVhPG5Ji9K3+FvUU="
        "iammrinal0.cachix.org-1:uWCwkRYptDrFnr4qxYyYFJZb4+e/QebcODAe8Of/ngc="



      ];
      # extra-substituters = ["https://vicinae.cachix.org" "https://cache.numtide.com"];
      # trusted-substituters = ["https://hyprland.cachix.org"];
      # trusted-public-keys = [
      #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # ];
      # extra-trusted-public-keys = [
      #   "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      #   "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      #   "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      # ];
    };

    # extraOptions had that line before but doesnt work: access-tokens = github.com=${config.sops.secrets."api_keys/github_mcp".path}
    extraOptions = ''
      !include ${config.sops.secrets."github_pat".path}
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # optimise.automatic = true; # may be redundant having auto-optimise-store in nix.settings
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
      extraPackages = [pkgs.docker-buildx];
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
      NH_FLAKE = "${config.users.users.${username}.home}/nix";
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
      setOptions = ["nonomatch" "zle"];

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
}
