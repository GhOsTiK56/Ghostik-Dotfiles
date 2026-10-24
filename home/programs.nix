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
    vo = "gpu-next";
    gpu-api = "opengl";
    gpu-context = "wayland";
    hwdec = "auto-safe";

    sub-ass-override = "scale";
    blend-subtitles = "yes";
    demuxer-mkv-subtitle-preroll = "yes";

    profile = "high-quality";

    target-prim = "bt.709";
    target-trc = "bt.1886";
    target-peak = 100;
    target-contrast = 1000;

    tone-mapping = "bt.2446a";
    tone-mapping-mode = "hybrid";
    inverse-tone-mapping = "no";

    target-colorspace-hint = "auto";

    osc = "no";
    title-bar = "no";
  };
};

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}