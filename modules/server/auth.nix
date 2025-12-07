{
  unify.modules.sso.nixos = {
    config,
    pkgs,
    ...
  }: let
    authelia_user = "main";
  in {
    sops.secrets = {
      jwt = {
        owner = "authelia-${authelia_user}";
      };
      sessionSecret = {
        owner = "authelia-${authelia_user}";
      };
      storageEncryption = {
        owner = "authelia-${authelia_user}";
      };
    };

    services.authelia.instances.main = {
      enable = true;

      # Minimal valid settings block
      settings = {
        server.address = "tcp://127.0.0.1:9091";

        log.level = "info";
        theme = "dark";

        session = {
          cookies = [
            {
              domain = "tilapia-morpho.ts.net";
              authelia_url = "https://authenticate.tilapia-morpho.ts.net";
              expiration = "1h";
              name = "authelia_session";
            }
          ];
        };

        storage.local.path = "/var/lib/authelia-main/authelia.db";
        authentication_backend.file.path = "/var/lib/authelia-main/users.yml";
        notifier.filesystem.filename = "/var/lib/authelia-main/notifications/notification.json";

        access_control = {
          default_policy = "deny";
          rules = [
            {
              domain = "*.tilapia-morpho.ts.net";
              policy = "two_factor";
            }
          ];
        };
      };

      # This is the important part for SOPS-managed secrets
      secrets = {
        jwtSecretFile = config.sops.secrets.jwt.path;
        sessionSecretFile = config.sops.secrets.sessionSecret.path;
        storageEncryptionKeyFile = config.sops.secrets.storageEncryption.path;
      };
    };
  };
}
