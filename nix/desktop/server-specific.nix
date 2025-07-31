###############################
## SERVER-SPECIFIC OVERRIDES ##
###############################

{ ... }:

{
  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # SSH
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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4CrQpgClN88TzMPVCkACe0r6n3kwPttU8b2ir5C9oa u0_a329@localhost"
  ];
}
