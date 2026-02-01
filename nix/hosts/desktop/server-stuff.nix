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

  # Open firewall ports
  networking.firewall = {
    allowedTCPPorts = [
      8096
      8920
      7777
    ];
    allowedUDPPorts = [
      7359
    ];
  };
}
