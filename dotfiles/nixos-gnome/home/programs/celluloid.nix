{ pkgs, ... }: {

  programs.mpv = {
    enable = true;
    config = {
      # Принудительно задействуем аппаратный декодер
      hwdec = "auto"; # Или "vaapi", если у вас Intel/AMD
      
      # Современный рендерер
      vo = "gpu";
      gpu-context = "wayland"; # Или "auto"
    };
  };
}