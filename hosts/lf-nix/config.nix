{
  config,
  pkgs,
  host,
  username,
  options,
  lib,
  inputs,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    # ../../pkgs/disable-monitors.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];

  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlays.default
    inputs.mcp-servers-nix.overlays.default
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (prev) system;
        config.allowUnfree = true;
      };
    })
    # Second overlay: Add your other packages and jupyter-ai.
    # This one can now safely access `final.unstable`.
    (final: prev: {
      claudia = inputs.claudia.packages.${prev.system}.default;
      ags = inputs.ags.packages.${prev.system}.default;
      firefox-addons = inputs.firefox-addons.packages.${prev.system};
      
    })
  ];

  nixpkgs.config.allowUnfree = true;
  security.sudo.wheelNeedsPassword = false; # Allow sudo without password for wheel group
  boot = {
    # kernelPackages = pkgs.linuxPackages_zen; # Performance geared
    kernelPackages = pkgs.linuxPackages_latest; # Best Balance
    # kernelPackages = pkgs.linuxPackages_testing; # Bleeding edge

    kernelParams = [
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

    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
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

    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
      relay.enable = true;
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
    enable = true;
    cpuFreqGovernor = "schedutil";
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
    extraPackages = [pkgs.docker-buildx];
  };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Enable Wayland Ozone platform for Electron apps
      ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Or "AUTO"
      # You might also try:
      ELECTRON_ENABLE_WAYLAND = "1";
      NH_FLAKE = "/home/lf/nix";
      # variables.FZF_SHELL_DIR = "${pkgs.fzf}/share/fzf";
    };
    variables = {
      FZF_SHELL_DIR = "${pkgs.fzf}/share/fzf";
    };
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
    niri.enable = true;
  };

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
      unstable.maple-mono.NF
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
    enableReleaseChecks = true;
    base16Scheme = ./schemes/catppuccin-frappe.yaml;
    polarity = "dark";
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
    targets.nixvim.enable = false;
    # targets.firefox.profileNames = ["default"];
    cursor = lib.mkDefault {
      name = "catppuccin-mocha-peach-cursors";
      package = pkgs.catppuccin-cursors.mochaPeach;
      size = 24;
    };
    opacity = {
      applications = 1.5;
      desktop = 1.5;
      popups = 1.5;
      terminal = 1.5;
    };
    # overlays.enable = true;
    fonts = {
      serif = {
        # package = pkgs.aleo-fonts;
        # name = "Aleo";
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      sansSerif = {
        # package = pkgs.noto-fonts-cjk-sans;
        # name = "Noto Sans CJK JP";
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      monospace = {
        #        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 9;
        desktop = 9;
        popups = 9;
        terminal = 9;
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
