{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.noctalia.nixosModules.default];
  services.noctalia-shell.enable = true;
}
