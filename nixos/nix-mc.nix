{ config, inputs, pkgs, lib, ... }: 
{
  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = config.age.secrets.playit-secret.path;
  };
  # Minecraft server settings
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = false;
    servers.fabric = {
      enable = true;

      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_21_4 {
        loaderVersion = "0.16.10";
      }; # Specific fabric loader version

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
          Fabric-API = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/P7dR8mSH/versions/3WOjLgFJ/fabric-api-0.116.1%2B1.21.4.jar";
            sha512 =
              "d5e9f87679b5edc9786e651fc481f8861a9cf53ed381890a1cb5e129222d6c5fa99f06045007f8e1fba02da686cdb6db2d99b334a1d23881cb56dfa199932eea";
          };
          Geyser = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/wKkoqHrH/versions/3wFQ2Lyh/geyser-fabric-Geyser-Fabric-2.6.0-b756.jar";
            sha512 =
              "c42d28ff66eb0f918408605538b67148407f958c54f969e907aabb64102d06af1e8ed0315a0bed56114dd79fc5788406472c8884132c932e64cd82e8b906613d";
          };
          Floodgate = pkgs.fetchurl {
            url =
              "https://cdn.modrinth.com/data/bWrNNfkb/versions/nyg969vQ/Floodgate-Fabric-2.2.4-b43.jar";
            sha512 =
              "0d73f7f88429f15989b0e7a33f05c2812d13822fd50e4c1a1793c9e2e65abbbe19cb2ad6bb9a6328e076cadf531261e893a88666be7efbc1b6d7f9534e52b336";
          };
        });
      };
    };
  };
}
