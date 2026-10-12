{
  fileSystems."/mnt/Hard" = {
    device = "/dev/disk/by-uuid/64220d8b-2397-409b-80c1-ebc6dee1bdea";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.device-timeout=5s" ];
  };

  fileSystems."/mnt/SATA" = {
    device = "/dev/disk/by-uuid/f341ffd2-442c-4add-90e8-7e5d6d8104ad";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.device-timeout=5s" ];
  };
}