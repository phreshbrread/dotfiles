{ pkgs, lib, config, ... }:
let cfg = config.virtualMachines; in {
  options.virtualMachines.enable = lib.mkEnableOption "Enable VM support";

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable  = true;
    users.groups.libvirtd.members = [ "brad" ];
    systemd.services.libvirt-guests.environment.ON_SHUTDOWN = lib.mkForce "shutdown";
    virtualisation = {
      spiceUSBRedirection.enable = true;
      libvirtd = {
        enable = true;
        qemu.vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };

    environment.systemPackages = [ pkgs.virtiofsd ];
  };
}
