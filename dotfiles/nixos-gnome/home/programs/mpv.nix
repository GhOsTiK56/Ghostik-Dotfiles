{ ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      # Let mpv automatically choose the best available hardware decoder.
      hwdec = "auto";

      # Use GPU rendering.
      vo = "gpu";

      # Use the native Wayland rendering backend.
      gpu-context = "wayland";
    };
  };
}