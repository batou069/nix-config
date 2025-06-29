{
  programs.firefox = {
    enable = true;

    profiles = {
      personal = {
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
          privacy-badger
          ghostery
          sponsorblock
          bitwarden
        ];
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
        };
      };
    };
  };
}