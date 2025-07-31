###########################
## EXTRA HARDWARE CONFIG ##
###########################

{ ... }:

{
  # Fix RAM RGB control
  boot.kernelParams = [ "acpi_enforce_resources=lax" ];

  # Mount extra drives
  fileSystems."/mass-storage" = {
    device = "/dev/disk/by-uuid/1f430d6f-a649-4717-ae3f-5e6f98ffbe3f";
    fsType = "btrfs";
    options = [
      "defaults"
      "nofail"
      "rw"
      "exec"
    ];
  };

  fileSystems."/external-drive" = {
    device = "/dev/disk/by-uuid/777F-FB5D";
    fsType = "exfat";
    options = [
      "defaults"
      "nofail"
      "rw"
      "users"
      "uid=1000"
      "gid=100"
      "umask=000"
    ];
  };
}
