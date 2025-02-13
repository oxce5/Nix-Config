{ config, ... }:
let
  # Ensure the path to playit.toml is resolved correctly relative to the current Nix file
  tomlFilePath = builtins.path ./playit.toml;
in
{
  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = "/etc/playit/playit.toml";
  };
}
