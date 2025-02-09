{ config, lib, pkgs, ... }:

{ 
  hardware.pulseaudio.enable = false;  # Disable PulseAudio if you want to use PipeWire
  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true; # This enables PipeWire's PulseAudio replacement
}
