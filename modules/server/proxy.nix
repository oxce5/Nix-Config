{
  unify.modules.proxy.nixos = {config, ...}: {
    networking.firewall.allowedTCPPorts = [
      81
    ];
    services = {
      tailscale.permitCertUid = "traefik";

      traefik = {
        enable = true;
        staticConfigOptions = {
          entryPoints = {
            web = {
              address = ":80";
              asDefault = true;
              http.redirections.entrypoint = {
                to = "websecure";
                scheme = "https";
              };
            };

            websecure = {
              address = ":443";
              asDefault = true;
              http.tls.certResolver = "tailscale";
            };
          };
          certificatesResolvers = {
            tailscale.tailscale = {};
          };
          log = {
            level = "INFO";
            filePath = "${config.services.traefik.dataDir}/traefik.log";
            format = "json";
          };
          api = {
            dashboard = true;
            insecure = true;
          };
        };
        dynamicConfigOptions = {
          http = {
            routers = {
              pihole = {
                entryPoints = ["websecure"];
                rule = "Host(`pihole.tilapia-morpho.ts.net`)";
                service = "pihole";
                middlewares = ["authelia-auth" ];
              };

              n8n = {
                entryPoints = ["websecure"];
                rule = "Host(`n8n.tilapia-morpho.ts.net`)";
                service = "n8n";
                middlewares = ["authelia-auth"];
              };

              sillytavern = {
                entryPoints = ["websecure"];
                rule = "Host(`sillytavern.tilapia-morpho.ts.net`)";
                service = "sillytavern";
                middlewares = ["authelia-auth"];
              };

              auth = {
                entryPoints = ["websecure"];
                rule = "Host(`auth.tilapia-morpho.ts.net`)";
                service = "auth";
              };
            };

            services = {
              auth = {
                loadBalancer.servers = [{ url = "http://127.0.0.1:9091"; }];
              };

              pihole = {
                loadBalancer = {
                  servers = [{ url = "http://127.0.0.1:6060"; }];
                };
              };

              n8n = {
                loadBalancer = {
                  servers = [{ url = "http://127.0.0.1:5678"; }];
                };
              };

              sillytavern = {
                loadBalancer = {
                  servers = [{ url = "http://127.0.0.1:8000"; }];
                };
              };
            };

            middlewares = {
              strip-pihole = {
                stripPrefix = {
                  prefixes = ["/pihole"];
                };
              };

              strip-n8n = {
                stripPrefix = {
                  prefixes = ["/n8n"];
                };
              };

              authelia-auth = {
                forwardAuth = {
                  address = "http://127.0.0.1:9091/api/verify?rd=https://auth.tilapia-morpho.ts.net";
                  trustForwardHeader = true;
                  authResponseHeaders = [
                    "Remote-User"
                    "Remote-Groups"
                    "Remote-Name"
                    "Remote-Email"
                    "Remote-Preferred-Username"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
