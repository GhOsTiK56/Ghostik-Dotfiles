{ ... }:

{
  hardware.i2c.enable = true;
  boot.kernelModules = [ "i2c-piix4" ];
  services.hardware.openrgb.enable = true;
}
