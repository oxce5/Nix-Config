{inputs, ...}: {
  unify.modules.workstation.home = {
    hostConfig,
    pkgs,
    ...
  }: {
    home.packages = with inputs; [kopuz.packages.${pkgs.stdenv.hostPlatform.system}.default];
  };
}
