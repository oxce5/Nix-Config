{
  description = "oxce5's Nix Config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs-fix-nvidia.url = "github:nixos/nixpkgs/d3f05ad2d8df25c226e58754239235acf9a11357";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    chaotic-nyx.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Note: Currently pinned to 25.05
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    matugen.url = "github:/InioX/Matugen";
    niri-unstable.url = "github:YaLTeR/niri";
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.niri-unstable.follows = "niri-unstable";
    };
    swww.url = "github:LGFae/swww";

    omarchy.url = "github:henrysipp/omarchy-nix";
    omarchy.inputs.nixpkgs.follows = "nixpkgs";
    omarchy.inputs.home-manager.follows = "home-manager";

    viu.url = "github:viu-media/viu";
    zen-browser.url = "github:0xc000022070/zen-browser-flake/1.15t-1755743862";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nvf.url = "github:notashelf/nvf";
    impermanence.url = "github:nix-community/impermanence";
    ignis = {
      url = "github:ignis-sh/ignis";
      inputs.nixpkgs.follows = "nixpkgs-unstable";  # recommended
    };
    elyprism-launcher.url = "github:elyprismlauncher/elyprismlauncher/0488e68254273905d886d5e784c5504028685281";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    nixosConfigurations = {
      overlord = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
        ./machines/overlord
        ];
      };

      # nixos-anywhere --flake .#homelab --generate-hardware-config nixos-generate-config ./machines/homelab/hardware-configuration.nix nixos@<hostname>
      # homelab = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = {inherit inputs outputs;};
      #   modules = [
      #     disko.nixosModules.disko
      #     ./machines/homelab
      #   ];
      # };
    };
  };
}
