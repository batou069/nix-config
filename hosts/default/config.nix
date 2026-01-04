# common not-core
{ inputs, ... }: {
  # Extra Logitech Support
  hardware = {
    logitech = {
      wireless = {
        enable = true;
        enableGraphical =
          true;
      };
    };
    # Bluetooth
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

  musnix = {
    enable = true;

    # DEFINITELY KEEP FALSE for simple playback
    # Prevents long compile times and potential instability
    kernel.realtime = false;

    # OPTIONAL: Useful tool to check if your system is bottlenecking audio
    rtcqs.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [8086 3000];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  home-manager = {
    backupFileExtension = "backup";
    sharedModules = [ inputs.zen-browser.homeModules.default ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
