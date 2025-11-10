{
  unify = {
    modules.workstation.home = {pkgs, ...}: {
      home.packages = with pkgs; [
        imagemagick
        inotify-tools
      ];
    };
    home = {pkgs, ...}: {
      home.packages = with pkgs; [
        file
        git
        gptfdisk
        psutils
        killall
        pciutils
        traceroute
        unrar
        unzip
        usbutils
        wget
        whois
        aria2
        choose
        dua
        dust
        edir
        fd
        duf
        gdu
        gh
        glow
        isd
        btop
        lurk
        mprocs
        (ouch.override {
          enableUnfree = true;
        })
        procs
        progress
        psmisc
        rclone
        ripgrep
        ripgrep-all
        rsync
        sd
        strace
        systeroid
        tcpdump
        try
        waypipe
        xxd
      ];
    };
  };
}
