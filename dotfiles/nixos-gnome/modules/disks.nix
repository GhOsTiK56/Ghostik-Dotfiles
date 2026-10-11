{
  fileSystems."/mnt/Hard" = {
    device = "/dev/disk/by-uuid/76ec0dda-3eff-471c-b786-d47bb2a745fb";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.device-timeout=5s" ];
  };

  fileSystems."/mnt/SATA" = {
    device = "/dev/disk/by-uuid/f341ffd2-442c-4add-90e8-7e5d6d8104ad";
    fsType = "ext4";
    options = [ "nofail" "x-systemd.device-timeout=5s" ];
  };
}
