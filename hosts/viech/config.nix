{ 
  config,
  pkgs,
  host,
  username,
  options,
 # lib,
  inputs,
 # system,
  ...}: let
  
  inherit (import ./variables.nix) keyboardLayout;

  in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
    # ./disko.nix
  ];

  # BOOT related stuff
  boot = {
    #kernelPackages = pkgs.linuxPackages_zen; # Performance geared
    kernelPackages = pkgs.linuxPackages_latest; # Best Balance
    #kernelPackages = pkgs.linuxPackages_lts # Most Stable 

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog" 
      "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
 	  ];

    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};

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
    timeServers = options.networking.timeServers.default ++ [
       "pool.ntp.org" ];
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet
          --time --cmd Hyprland";
        };
      };
    };

    
    smartd = {
      enable = false;
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
        extraConfig = {
           pipewire = {
             "context.properties" = {
               "default.clock.rate"          = 48000;
               "default.clock.allowed-rates" = [ 44100 48000
                88200 96000 176400 192000 352800 384000 705600 
                768000 ];
               "default.clock.quantum"       = 1024;
               "default.clock.min-quantum"   = 1024;
               "default.clock.max-quantum"   = 1024;
             };
           };
          };
          wireplumber.extraConfig = {
                "51-disable-suspend" = {
                  "monitor.session.rule.suspend-node.disabled" = true;
                };
              };
            };
	



    #pulseaudio.enable = false; #unstable
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
    flatpak.enable = false;
	
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

  systemd.services = {
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
    initial-clone-brain = {
      description = "Initial clone of Obsidian Brain repository";
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      # ADD THIS BLOCK: Make commands available to the script
      path = [
        pkgs.gitFull      # Provides 'git'
        pkgs.util-linux   # Provides 'runuser'
      ];
      script = ''
        if [ ! -d "/home/${username}/Obsidian/brain" ]; then
          mkdir -p /home/${username}/Obsidian
          chown ${username} /home/${username}/Obsidian
          runuser -u ${username} -- git clone https://github.com/batou069/brain.git /home/${username}/Obsidian/brain
        fi
      '';
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
        PrivateTmp = false;
        ProtectHome = false;
      };
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
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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

  # For Electron apps to use wayland
	environment.sessionVariables = {
	  NIXOS_OZONE_WL = "1"; # Enable Wayland Ozone platform for Electron apps
	  ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Or "AUTO"
	  # You might also try:
	  # ELECTRON_ENABLE_WAYLAND = "1";
	};

   programs = {
   # Zsh configuration
     zsh = {
     	enable = true;
 	enableCompletion = true;
         ohMyZsh.enable = false;
       
         autosuggestions.enable = false;
         syntaxHighlighting.enable = false;
         promptInit = "";
       };
    };
 
  environment.variables.FZF_SHELL_DIR = "${pkgs.fzf}/share/fzf";

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
