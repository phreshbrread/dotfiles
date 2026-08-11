############################
## VIRTUAL MACHINE MODULE ##
############################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    vm-module.enable = lib.mkEnableOption "Enables virtual machine support";
  };

  config = lib.mkIf config.vm-module.enable {
    programs.virt-manager.enable  = true;
    users.groups.libvirtd.members = [ "brad" ];
    systemd.services.libvirt-guests.environment.ON_SHUTDOWN = lib.mkForce "shutdown";
    virtualisation = {
      spiceUSBRedirection.enable = true;
      libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      };
    };
  };
}
