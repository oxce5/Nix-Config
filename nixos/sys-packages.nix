{ config, pkgs, nur, inputs, ...}:

{
  # builtins.fetchTarball = {
  # # Get the revision by choosing a version from https://github.com/nix-community/NUR/commits/master
  # url = "https://github.com/nix-community/NUR/archive/3a6a6f4da737da41e27922ce2cfacf68a109ebce.tar.gz";
  # # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
  # sha256 = "04387gzgl8y555b3lkz9aiw9xsldfg4zmzp930m62qw8zbrvrshd";
  # };
  # nixpkgs.config.packageOverrides = pkgs: {
  #     nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
  #       inherit pkgs;
  #     };
  #   };
  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
      };
    };
    cudaSupport = true;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wl-clipboard
     kitty
     wget
     git
     gh
     curl
     python3
     cloudflare-warp
     nginx
     android-tools
     nodejs
     platformio
     wine
     brightnessctl
     cudaPackages.cuda_opencl
     cudaPackages.cudatoolkit
     ocl-icd
     nvidia-vaapi-driver
     pavucontrol 

     ];
}
