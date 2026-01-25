{
  unify.modules.workstation.nixos = {
    hostConfig,
    pkgs,
    ...
  }: {
    users.users.${hostConfig.primaryUser}.extraGroups = ["adbusers"];
    environment.systemPackages = with pkgs; [android-tools];
  };
}
