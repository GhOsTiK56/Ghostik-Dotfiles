{ ... }:

{
  programs.git = {
    enable = true;

    settings.user = {
      name = "Ghostik";
      email = "ghostik.tech@gmail.com";
    };
  };

  programs.mpv = {
    enable = true;

    config = {
      hwdec = "auto";
      vo = "gpu";
      gpu-context = "wayland";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}