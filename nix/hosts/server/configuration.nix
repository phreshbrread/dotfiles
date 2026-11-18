{ config, lib, pkgs-stable, ... }:

{
  # Modules
  systemdBoot.enable = true;
  #ssh.enable         = true;

  # Hostname
  networking.hostName = "bignuts";

  # TZ
  time.timeZone = "Australia/Melbourne";

  # User
  users.users.plum = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "server" ];
  };

  # Disable bluetooth
  hardware.bluetooth.enable = false;

  # Disable XDG portals
  xdg.portal.enable = false;

  # Disable flatpak
  services.flatpak.enable = false;

  # Packages
  environment.systemPackages = with pkgs-stable; [
    neovim
    wget
    git
  ];

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  systemd.services.docker.unitConfig.RequiresMountsFor = [ "/media" ];

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
  };

  networking.firewall = {
    allowedTCPPorts = [
      80    # Nginx
      443   # Nginx
      25566 # Minecraft
      7777  # Terraria
    ];
    allowedUDPPorts = [
      7359  # Jellyfin local discovery
    ];
  };

  # DuckDNS
  services.duckdns = {
    enable = true;
    domains = [ "screamingbird" ];
    tokenFile = "/duckdns-token"; # TODO: Regen duckdns token
  };

  # Nginx
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."screamingbird.duckdns.org" = {
      # Automatically handle SSL certs with Let's Encrypt
      enableACME = true;
      forceSSL = true;

      # Reverse proxy
      locations."/" = {
        proxyPass = "http://localhost:8096"; # Jellyfin port
        proxyWebsockets = true;
      };
    };
  };

  # Let's Encrypt
  security.acme = {
    acceptTerms = true;
    defaults.email = "crustydog9@gmail.com";
  };

  # Initial install version
  system.stateVersion = "26.11";
}
