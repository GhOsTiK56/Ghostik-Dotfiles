{ pkgs, ... }:

{
  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = true;

  # 1. Включаем системный сервис OpenRGB 
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa.opencl
      libva
    ];
  };

  # 2. Добавляем пользователя в группу i2c (нужно для управления RGB плашек RAM и материнской платы)
  users.users.ghostik.extraGroups = [ "i2c" ];

  # 3. Подгружаем модуль ядра i2c-dev
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
}