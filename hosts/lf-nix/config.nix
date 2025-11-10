{ config
, pkgs
, pkgs-unstable
, host
, username
, options
, inputs
, lib
, ...
}:
let
  inherit (import ./variables.nix) keyboardLayout;
in
{
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages.nix
    ./clickcapital-parser.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    # ../../pkgs/disable-monitors.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];

  # Silence the specialArgs warning by explicitly disabling the conflicting options.
  nixpkgs.config.allowUnfree = lib.mkForce false;
  nixpkgs.overlays = lib.mkForce [ ];

  security.sudo.wheelNeedsPassword = false; # Allow sudo without password for wheel group
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
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      # "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
      # "vt.default_red=48,231,166,229,140,244,129,181,98,231,166,229,140,244,129,165"
      # "vt.default_grn=52,130,209,200,170,184,200,191,104,130,209,200,170,184,200,173"
      # "vt.default_blu=70,132,137,144,238,228,190,226,128,132,137,144,238,228,190,206"
    ];

    extraModprobeConfig = ''
      options snd_sof_intel_hda_common dmic_num=4
      options btusb rtk_enable=1
      options rtw88_core disable_lps_deep=Y
      options rtw88_pci disable_aspm=Y
    '';

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "usbhid" "sd_mod" "sdhci_pci" ];
      kernelModules = [ "kvm-intel" ];
    };
    # extraModulePackages = [config.boot.kernelPackages.cpufreqtools];
    # Needed For Some Steam Games
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
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
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    plymouth = {
      enable = true;
    };
  };

  time.hardwareClockInLocalTime = true;
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
    xserver = {
      enable = lib.mkForce false; # Disable X11 entirely - was just false
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };

    # Cron Job for old Swing Trade Newsletter
    # cron = {
    #   enable = true;
    #   systemCronJobs = [
    #     "0 9 * * * lf $ /home/lf/repos/clickcapitalparser/process_alerts.py"
    #     # removed `{pkgs.python3}/bin/python3`
    #   ];
    # };

    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        };
      };
    };

    smartd = {
      enable = true;
      autodetect = true;
    };

    gvfs.enable = true;
    # tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    pulseaudio.enable = false; #unstable
    udev.enable = true;

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

    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "${config.users.users.${username}.home}";
      configDir = "${config.users.users.${username}.home}/.config/syncthing";
      relay.enable = true;
    };

    telegraf = {
      enable = true;
      extraConfig = {
        inputs = {
          cpu = {
            percpu = true;
            totalcpu = true;
          };
          mem = { };
          disk = { };
          diskio = { };
          net = { };
          system = { };
          processes = { };
          swap = { };
          internal = { };
        };
        outputs = {
          http = {
            url = "http://127.0.0.1:8181/api/v3/write_lp?db=nixos_metrics";
            method = "POST";
            data_format = "influx";
            headers = {
              "Authorization" = "Token ${config.sops.secrets."influxdb".path}";
            };
          };
        };
      };
    };
    grafana = {
      enable = true;
      # Optional: Configure it to start automatically on your local machine
      settings.server.root_url = "http://localhost:3000";
      settings.security.admin_user = "admin";
      settings.security.admin_password = "Token ${config.sops.secrets."influxdb".path}";
    };
  };

  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
    enable = false;
    cpuFreqGovernor = "powersave"; # or "performance" or "schedutil";
  };

  # Extra Logitech Support
  hardware = {
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true;
  };

  hardware.enableRedistributableFirmware = true;

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
  security.pam.services.hyprlock = { };
  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    extraOptions = ''
      access-tokens = github.com=${config.sops.secrets.github_pat.path}
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    optimise.automatic = true;
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
    extraPackages = [ pkgs.docker-buildx ];
  };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Enable Wayland Ozone platform for Electron apps
      NIXOS_WAYLAND = "1"; # Force Wayland
      ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Or "AUTO"
      # ELECTRON_ENABLE_WAYLAND = "1";
      NH_FLAKE = "${config.users.users.lf.home}/nix";
      ZSH_AI_COMMANDS_OPENAI_API_KEY = config.sops.secrets."api_keys/openai".path;
      OPENAI_API_KEY = config.sops.secrets."api_keys/openai".path;
      GEMINI_API_KEY = config.sops.secrets."api_keys/gemini".path;
      ANTHROPIC_API_KEY = config.sops.secrets."api_keys/anthropic".path;
      INFLUX_TOKEN = config.sops.secrets."influxdb".path;
    };
    variables = {
      # Make the fzf shell integration available to all users.
      # This path is determined by a system package (`pkgs.fzf`).
      FZF_SHELL_DIR = "${pkgs.fzf}/share/fzf";
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };

  programs = {
    hyprland = {
      # let
      # Create a pristine pkgs set without any overlays to avoid conflicts from NUR.
      # pkgs-pristine = import inputs.nixpkgs {
      # system = pkgs.system;
      # config.allowUnfree = true; # Keep this for consistency
      # };
      # Define plugins in a let block for clarity and robustness
      # plugin-pkgs = with inputs; [
      # hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
      # hyprland-plugins.packages.${pkgs.system}.hyprbars
      # hyprland-plugins.packages.${pkgs.system}.hyprscrolling
      # hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers
      # hy3.packages.${pkgs.system}.hy3
      # ];
      # in {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      xwayland.enable = true;
      withUWSM = false;
      # plugins = plugin-pkgs;
    };
    # Zsh configuration
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
      pkgs-unstable.maple-mono.NF
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
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-monochrome-emoji
      noto-fonts-color-emoji
      # Niche/Specific Fonts
      minecraftia
    ];
    /*
       fontconfig = {
      defaultFonts = {
      serif = [
      "Maple Mono NF Italic"
      "Noto Serif"
      ];

      sansserif = [
      "Maple Mono NF Italic"
      ];

      monospace = [
      "Maple Mono NF Italic"
      "Cascadia Code NF"
      ];
      };

      allowBitmaps = false;
      };
    */
  };

  stylix = {
    enable = true;
    autoEnable = true;
    # targets.hyprland.enable = false;
    enableReleaseChecks = true;
    # image = "/home/lf/Pictures/wallpapers/City-Night.png";
    base16Scheme = ./schemes/flat.yaml;
    polarity = "dark"; # "light", "dark", "either"
    overlays.enable = true;
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };

    # icons = {
    # enable = true;
    # package = pkgs.colloid-icon-theme;
    # };
    cursor = {
      name = "phinger-cursors-dark";
      size = 32;
      package = pkgs.phinger-cursors;
    };
    # opacity = {
    #   applications = 1.0;
    #   desktop = 1.0;
    #   popups = 1.0;
    #   terminal = 0.75;
    # };
    fonts = {
      sansSerif = {
        # package = pkgs.aleo-fonts;
        # name = "Aleo";
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "Fantasqeue";
      };

      serif = {
        # package = pkgs.noto-fonts-cjk-sans;
        # name = "Noto Sans CJK JP";
        package = pkgs-unstable.maple-mono.NF;
        name = "Maple Mono NF";
      };

      monospace = {
        package = pkgs.cascadia-code;
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        desktop = 12;
        popups = 14;
        terminal = 14;
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [8086 3000];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  home-manager.sharedModules = [
    inputs.zen-browser.homeModules.default
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
