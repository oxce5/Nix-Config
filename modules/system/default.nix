{inputs, ...}: {
  imports = [
    # ./example.nix - add your modules here
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.sops-nix.nixosModules.sops

    ./aagl.nix
    ./hardware.nix
    ./services.nix
    ./network.nix
    ./steam.nix
    ./programs.nix
    ./nvidia.nix
    ./virtualization.nix
  ];

  environment.localBinInPath = true;
  nix.settings.accept-flake-config = true;
}
