{
  description = "0xCE5's Nix Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
    omarchy-nix = {
        url = "github:henrysipp/omarchy-nix";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fastanime.url = "github:Benexl/FastAnime";
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nvf.url = "github:notashelf/nvf";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-autobahn.url = "github:Lassulus/nix-autobahn";
    impermanence.url = "github:nix-community/impermanence";

    zaphkiel.url = "github:Rexcrazy804/Zaphkiel";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    elyprism-launcher.url = "github:elyprismlauncher/elyprismlauncher/0488e68254273905d886d5e784c5504028685281";
    ghostty = {
      url = "github:ghostty-org/ghostty/fde50e0f1c7b902c6c96344fd94b46ad509179b5";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
      omanixConfig = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
        ];
      };

    in
    {
      nixosConfigurations.overlord = omanixConfig;
    };
}
