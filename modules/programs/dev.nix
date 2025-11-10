{
  unify.modules.workstation = {
    nixos = {
      pkgs,
      hostConfig,
      ...
    }: {
      virtualisation.docker.enable = true;
      users.users.${hostConfig.primaryUser}.extraGroups = ["docker"];
    };
    home = {pkgs, ...}: {
      home.packages = with pkgs; [
        # Dev
        lazyjj
        lazygit
        jq

        devenv
        uv

        just
      ];
    };
  };
}
