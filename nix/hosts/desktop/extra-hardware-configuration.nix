###########################
## EXTRA HARDWARE CONFIG ##
###########################

{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable accelerated graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Enable swap file
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
      options = [ "discard" ];
    }
  ];

  # Adjust swappiness
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  # Fix RAM RGB control
  boot.kernelParams = [
    "acpi_enforce_resources=lax"
    "systemd.swap=0" # Not for RGB, just disables systemd auto swap gen
  ];
  boot.kernelModules = [
    "i2c-dev"
    "i2c-piix4"
  ];

  # Mount extra drives
  fileSystems."/mass-storage" = {
    device = "/dev/disk/by-uuid/1f430d6f-a649-4717-ae3f-5e6f98ffbe3f";
    fsType = "btrfs";
    options = [
      "defaults"
      "nofail"
      "rw"
      "exec"
      "nodev"
    ];
  };

  fileSystems."/external-drive" = {
    device = "/dev/disk/by-uuid/777F-FB5D";
    fsType = "exfat";
    options = [
      "nofail"
      "nosuid"
      "nodev"
      "rw"
      "uid=1000"
      "gid=100"
      "umask=000"
      "dmask=000"
    ];
  };
}
