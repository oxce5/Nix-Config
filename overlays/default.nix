# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
# overlays/default.nix
  # Add custom packages
  additions = final: _prev: import ../pkgs { 
    pkgs = final; 
    inherit inputs; 
    ags = inputs.ags; 
    system = final.stdenv.hostPlatform.system; # Derive system from final
  };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # blender = (import (fetchGit {
    #   url = "https://github.com/amarshall/nixpkgs.git";
    #   ref = "blender-4.4"; # Branch name
    #   rev = "442c3a8e4e86f808b8959b1f5fc5d5045491f4f4"; # Pin to a specific commit (see below)
    # }) { inherit (prev) system; }).blender;
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
