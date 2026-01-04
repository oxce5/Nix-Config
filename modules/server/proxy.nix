{
  unify.modules.proxy.nixos = {config, ...}: {
    networking.firewall.allowedTCPPorts = [
      81
      40000
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
                middlewares = ["authelia-auth"];
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

              anime = {
                entryPoints = ["websecure"];
                rule = "Host(`anime.tilapia-morpho.ts.net`)";
                service = "anime";
                middlewares = ["authelia-auth"];
              };

              uptime = {
                entryPoints = ["websecure"];
                rule = "Host(`uptime.tilapia-morpho.ts.net`)";
                service = "uptime";
                middlewares = ["authelia-auth"];
              };

              ssh = {
                entryPoints = ["websecure"];
                rule = "Host(`ssh.tilapia-morpho.ts.net`)";
                service = "ssh";
              };

              nextcloud = {
                entryPoints = ["websecure"];
                rule = "Host(`nextcloud.tilapia-morpho.ts.net`)";
                service = "nextcloud";
              };

              auth = {
                entryPoints = ["websecure"];
                rule = "Host(`auth.tilapia-morpho.ts.net`)";
                service = "auth";
              };
            };

            services = {
              auth = {
                loadBalancer.servers = [{url = "http://127.0.0.1:9091";}];
              };

              pihole = {
                loadBalancer = {
                  servers = [{url = "http://127.0.0.1:6060";}];
                };
              };

              anime = {
                loadBalancer.servers = [{url = "http://127.0.0.1:43211";}];
              };

              uptime = {
                loadBalancer.servers = [{url = "http://127.0.0.1:40000";}];
              };

              ssh = {
                loadBalancer.servers = [{url = "http://127.0.0.1:9000";}];
              };

              nextcloud = {
                loadBalancer.servers = [{url = "http://127.0.0.1:12800";}];
              };

              n8n = {
                loadBalancer = {
                  servers = [{url = "http://127.0.0.1:5678";}];
                };
              };

              sillytavern = {
                loadBalancer = {
                  servers = [{url = "http://127.0.0.1:8000";}];
                };
              };
            };

            middlewares = {
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
