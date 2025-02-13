
{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs and utilities
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module"; 
    nix-minecraft.url = "github:Infinidoge/nix-minecraft"; 
    # Community repositories
    # nur = {
    #   url = "github:nix-community/NUR";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    
    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other flakes
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { 
    self,
    nixpkgs, 
    home-manager,
    nur,
    zen-browser,
    playit-nixos-module,
    nix-minecraft,
    ... 
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME: Replace with your hostname
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        # > Our main nixos configuration file <
        modules = [ 
        ./nixos/configuration.nix 
        playit-nixos-module.nixosModules.default
        ];
      };
    };

    # Home Manager configuration
    homeConfigurations = {
      "oxce5@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}

