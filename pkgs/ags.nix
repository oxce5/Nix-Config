{ inputs, pkgs, ags, ... }:

let
  system = "x86_64-linux"; # Define system explicitly
  my-ags-shell = ags.lib.bundle {
    inherit pkgs;
    
    # Source directory containing your AGS configuration and assets
    src = ../assets/ags; # Pointing to your assets directory
    
    # Name of the executable (e.g., `my-ags-shell` will be the command to run it)
    name = "ags-bar";
    
    # Entry point for AGS (adjust based on your setup)
    entry = "app.ts"; # Replace with your actual entry file if different
    
    # Whether to include GTK4 (set to true if your AGS setup uses GTK4)
    gtk4 = false;
    
    # Additional libraries and executables to include in GJS runtime
    extraPackages = with pkgs; [
      inputs.ags.packages.${system}.apps
      inputs.ags.packages.${system}.battery
      inputs.ags.packages.${system}.bluetooth
      inputs.ags.packages.${system}.hyprland
      inputs.ags.packages.${system}.mpris
      inputs.ags.packages.${system}.network
      inputs.ags.packages.${system}.notifd
      inputs.ags.packages.${system}.wireplumber
      fzf
    ];
  };
in
{
  # Export the custom AGS shell as a package
  my-ags-shell = my-ags-shell;
}
