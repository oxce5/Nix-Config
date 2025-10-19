{
  unify = {
    nixos =
      { config, pkgs, hostConfig, ... }:
      {
        programs.nh = {
          enable = true;
          package = pkgs.nh;
          clean.enable = true;
          clean.extraArgs = "--keep-since 4d --keep 5";
          flake = "/home/${hostConfig.primaryUser}/.flake";
        };
      };
    home =
      { pkgs, config, ... }:
      {
        home.sessionVariables.FLAKE = "${config.home.homeDirectory}/.flake";
      };
  };
}
