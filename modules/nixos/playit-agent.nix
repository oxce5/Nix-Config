{
  services.playit = {
    enable = true;
    user = "playit";
    group = "playit";
    secretPath = "/etc/playit/playit.toml";
  };
}
