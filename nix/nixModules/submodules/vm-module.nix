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
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [ "brad" ];
    virtualisation = {
      spiceUSBRedirection.enable = true;
      libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
      };
    };
  };
}
