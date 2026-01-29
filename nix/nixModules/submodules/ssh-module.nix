################
## SSH MODULE ##
################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    ssh-module.enable = lib.mkEnableOption "Enables OpenSSH + authorized keys";
  };

  config = lib.mkIf config.ssh-module.enable {
    # Enable OpenSSH
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        AllowUsers = [ "brad" ];
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "yes";
      };
    };

    # Authorised SSH keys
    users.users.brad.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4CrQpgClN88TzMPVCkACe0r6n3kwPttU8b2ir5C9oa u0_a329@localhost" # Mobile phone
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBno6ku/9vynuqpYNH1OLx1hZ1X0qciMycvzd5YM/aW8 brad@brad-nixos-macbook" # Macbook
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBsOBvqJxsicqpr4wDYLwR9s2VezX0r84vRpsSM/I0Oe brad@pheg-nixos-desktop" # Desktop
    ];
  };
}
