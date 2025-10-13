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
      # inputs.niri-flake.overlays.niri
      outputs.overlays.unstable-packages
      # outputs.overlays.winboat-overlay
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "mbedtls-2.28.10"
      ];
    };
  };
  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = [pkgs.sops pkgs.btop];

  # sops configuration
  sops.defaultSopsFile = ../../secrets/example.yaml;
  sops.age.keyFile = "/home/henry/.config/sops/age/keys.txt";
}
