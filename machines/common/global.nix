{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  time.timeZone = "Asia/Manila";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs = {
    overlays = [
      # outputs.overlays.additions
      # outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = [pkgs.sops pkgs.btop];

  # sops configuration
  sops.defaultSopsFile = ../../secrets/example.yaml;
  sops.age.keyFile = "/home/henry/.config/sops/age/keys.txt";
}
