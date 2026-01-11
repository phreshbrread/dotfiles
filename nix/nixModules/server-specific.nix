###############################
## SERVER-SPECIFIC OVERRIDES ##
###############################

{ pkgs, ... }:

{
  # Docker
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      userland-proxy = false;
      experimental = true;
      metrics-addr = "0.0.0.0:9323";
      ipv6 = true;
      fixed-cidr-v6 = "fd00::/80";
    };
  };
  users.users.brad.extraGroups = [ "docker" ];
  systemd.services.docker.unitConfig.RequiresMountsFor = [ "/external-drive" ];

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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4CrQpgClN88TzMPVCkACe0r6n3kwPttU8b2ir5C9oa u0_a329@localhost" # Mobile phone
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBno6ku/9vynuqpYNH1OLx1hZ1X0qciMycvzd5YM/aW8 brad@brad-nixos-macbook" # Macbook
  ];

  # Open firewall ports
  networking.firewall = {
    allowedTCPPorts = [
      8096
      8920
      7777
      42000
      42001
    ];
    allowedUDPPorts = [
      7359
      42000
      42001
    ];
  };
}
