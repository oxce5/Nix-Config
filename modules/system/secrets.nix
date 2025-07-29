{...}: {
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/oxce5/.config/sops/age/keys.txt";
    secrets."aria2_rpc" = {};
  };
}
