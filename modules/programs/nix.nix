{inputs, ...}: {
  unify = {
    home = {pkgs, ...}: {
      home.packages = with pkgs; [
        # Nix
        alejandra
        comma
        deadnix
        nix-init
        nix-inspect
        nixos-rebuild-ng
        nix-output-monitor
        nix-tree
        nix-update
        statix
        vulnix
      ];
    };
  };
}
