
{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs and utilities
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
    playit-nixos-module.url = "github:pedorich-n/playit-nixos-module"; 
    nix-minecraft.url = "github:Infinidoge/nix-minecraft"; 
    # Community repositories
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other flakes
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    catppuccin.url = "github:catppuccin/nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # Anime Games Launcher
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
    aagl.inputs.nixpkgs.follows = "nixpkgs"; # Name of nixpkgs input you want to use
  };

  outputs = { 
    self,
    nixpkgs, 
    home-manager,
    nur,
    zen-browser,
    playit-nixos-module,
    spicetify-nix,
    aagl,
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

        nur.modules.nixos.default
        ({ pkgs, ... }: {
           environment.systemPackages = [ pkgs.nur.repos.ataraxiasjel.waydroid-script ];
        })

        {
          imports = [ aagl.nixosModules.default ];
          nix.settings = aagl.nixConfig; # Set up Cachix
          programs.anime-game-launcher.enable = false; # Adds launcher and /etc/hosts rules
          programs.anime-games-launcher.enable = false;
          programs.honkers-railway-launcher.enable = true;
          programs.honkers-launcher.enable = false;
          programs.wavey-launcher.enable = false;
          programs.sleepy-launcher.enable = true;
        }
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

