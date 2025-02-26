{ config, pkgs, lib, inputs, ... }: 
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  # Minecraft server settings
  services.minecraft-servers = {
    enable = false;
    eula = true;
    dataDir = "/var/lib/mc-server";

    openFirewall = false;
    servers.fabric = {
      enable = true;
      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_21_4; 

      # symlinks = {
      #   mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
      #     Geyser = pkgs.fetchurl {
      #       url =
      #         "https://cdn.modrinth.com/data/wKkoqHrH/versions/3wFQ2Lyh/geyser-fabric-Geyser-Fabric-2.6.0-b756.jar";
      #       # sha512 =
      #         # "3pafydfzh76l3pr81jlfvhvj4gl3392k9zz8xmi0iwydscsfcphcjhf7qwily3mnarlncxnkkzy7fj5rjkf2rcifwc2rchxlq4c6iyc";
      #     };
      #     Floodgate = pkgs.fetchurl {
      #       url =
      #         "https://cdn.modrinth.com/data/bWrNNfkb/versions/nyg969vQ/Floodgate-Fabric-2.2.4-b43.jar";
      #       # sha512 =
      #         # "0s1ylqq2g2l7dn429x93nv41xdjkfz8dcrhg4mx5xz0qljik7h0bgdswi5c09kdsr393lp2llh9y55ps56gxrllzh2aj3kk6cqy4k9k";
      #     };
      #   });
      # };
    };
  };
}
