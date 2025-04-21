{
  description = "template for hydenix";

  inputs = {
    # User's nixpkgs - for user packages
    nixpkgs.url = "github:NixOS/nixpkgs/42a1c966be226125b48c384171c44c651c236c22";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    jerry.url = "github:justchokingaround/jerry";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nvf.url = "github:notashelf/nvf";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Hydenix and its nixpkgs - kept separate to avoid conflicts
    hydenix = {
      url = "github:richen604/hydenix";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    HOSTNAME = "hydenix";

    hydenixConfig = inputs.hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
      inherit (inputs.hydenix.lib) system;
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix
      ];
    };
  in {
    nixosConfigurations.nixos = hydenixConfig;
    nixosConfigurations.${HOSTNAME} = hydenixConfig;
  };
}
