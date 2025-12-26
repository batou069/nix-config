{ pkgs, ... }: {
  services = {
    tomat = {
      enable = true;
      package = pkgs.tomat;
    };
  };
}
