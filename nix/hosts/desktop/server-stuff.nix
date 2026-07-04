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

  # Caddy with DuckDNS plugin
  services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/duckdns@v0.5.0" ];
      hash = "sha256-BI72FyEpCKTyQ9lRlVcRsPLSyXlfwdOae57KhVTH/M8=";
    };

    virtualHosts."screamingbird.duckdns.org" = {
      extraConfig = ''
        tls {
          dns duckdns "e877204b-8c9c-4200-877e-bbb4eb2a3cbe"
        }

        reverse_proxy localhost:8096

        encode gzip zstd
        header {
          Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
          X-Content-Type-Options nosniff
          X-Frame-Options DENY
          X-XSS-Protection "0"
        }
      '';
    };
  };

  # Dynamic DNS updater
  systemd.services.duckdns-update = {
    description = "Update DuckDNS IP";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      ${pkgs.curl}/bin/curl "https://www.duckdns.org/update?domains=screamingbird&token=e877204b-8c9c-4200-877e-bbb4eb2a3cbe&ip="
    '';
  };

  systemd.timers.duckdns-update = {
    description = "Run DuckDNS update every 5 minutes";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2min";
      OnUnitActiveSec = "5min";
      Persistent = true;
    };
  };

  # Open firewall ports
  networking.firewall = {
    allowedTCPPorts = [
      # Caddy
      80
      443

      # Minecraft
      25566

      # Terraria
      7777
    ];
    allowedUDPPorts = [
      # Jellyfin local discovery
      7359
    ];
  };
}
