{ pkgs, ... }:

{
  # Enable redistributable firmware, including AMD CPU microcode support.
  hardware.enableRedistributableFirmware = true;

  # Basic accelerated graphics support.
  # 32-bit support is important for Steam and other 32-bit applications.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Firmware update support through LVFS.
  services.fwupd.enable = true;

  # OpenRGB background service and device access.
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb;
  };

  # I2C access used by OpenRGB for supported motherboard and memory devices.
  boot.kernelModules = [
    "i2c-dev"
    "i2c-piix4"
  ];
}