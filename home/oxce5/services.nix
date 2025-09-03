{...}:

{
  services = {
    batsignal = { 
      enable = true; 
      extraArgs = [
        "-p" "-e" "-m 10"
        "-P AC Adapter plugged in."
        "-U AC Adapter plugged out."
        "-w 30" "-c 20" "-d 10"
        "-D 'notify-send \"system will suspend in 1 min unless charger plugged\"; sleep 60; grep -q 1 /sys/class/power_supply/ACAD/online || systemctl suspend'"
      ];
    };
    clipse.enable = true;
  };
}
