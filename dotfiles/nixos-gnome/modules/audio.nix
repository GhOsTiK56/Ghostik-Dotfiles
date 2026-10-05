{ ... }:

{
  # Allow PipeWire to obtain realtime scheduling privileges.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    # ALSA applications.
    alsa.enable = true;
    alsa.support32Bit = true;

    # PulseAudio compatibility layer.
    pulse.enable = true;
  };
}