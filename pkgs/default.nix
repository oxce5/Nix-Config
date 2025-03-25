# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, inputs, ags, system, ... }: # Accept all necessary arguments

{
  # ags = pkgs.callPackage ./ags.nix { inherit inputs ags system; };
}
