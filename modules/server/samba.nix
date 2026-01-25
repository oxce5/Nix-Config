{
  unify.modules.sync.nixos = {pkgs, ...}: {
    services = {
      samba = {
        enable = true;
        openFirewall = true;
        settings = {
          global = {
            "workgroup" = "WORKGROUP";
            "server string" = "smbchimera";
            "netbios name" = "smbchimera";
            #"use sendfile" = "yes";
            #"max protocol" = "smb2";
            # note: localhost is the ipv6 localhost ::1
            # "hosts allow" = "192.168.0. 127.0.0.1 localhost";
          };
          "public" = {
            "path" = "/mnt/ChimeraNAS/Public";
            "browseable" = "yes";
            "read only" = "no";
            "guest ok" = "yes";
            "create mask" = "0644";
            "directory mask" = "0755";
            "force user" = "smbpublic";
            "force group" = "samba";
          };
          "private" = {
            "path" = "/mnt/ChimeraNAS/Private";
            "browseable" = "yes";
            "read only" = "no";
            "guest ok" = "no";
            "create mask" = "0644";
            "directory mask" = "0755";
            "force user" = "smbprivate";
            "force group" = "sync";
          };
        };
      };

      samba-wsdd = {
        enable = true;
        openFirewall = true;
      };

      avahi = {
        publish.enable = true;
        publish.userServices = true;
        # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
        nssmdns4 = true;
        # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
        enable = true;
        openFirewall = true;
      };
      syncthing = {};
    };

    networking = {
      firewall.enable = true;
      firewall.allowPing = true;
    };
  }
}
