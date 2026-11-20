{ config, lib, pkgs-stable, ... }:
{
  # Modules
  systemdBoot.enable = true;
  ssh.enable         = true;

  # Hostname
  networking.hostName = "bignuts";

  # TZ
  time.timeZone = "Australia/Melbourne";

  # User
  users.users.plum = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "server" "video" "render" ];
    linger       = true;
  };

  # Force disable features
  hardware.bluetooth.enable = lib.mkForce false;
  xdg.portal.enable         = lib.mkForce false;
  services.flatpak.enable   = lib.mkForce false;

  # Packages
  environment.systemPackages = with pkgs-stable; [
    neovim
    wget
    git
  ];

  # RTX 2070
  services.xserver.videoDrivers            = [ "nvidia" ];
  hardware.graphics.enable                 = true;
  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open               = false; # For proprietary driver
    nvidiaSettings     = true;
    package            = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Docker
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
      features = {
        cdi = true;
      };
    };
  };
  systemd.services.docker.unitConfig.RequiresMountsFor = [ "/home/plum/media" ];

  # Media drive
  boot.supportedFilesystems = [ "exfat" ];
  fileSystems."/home/plum/media" = {
    device = "/dev/disk/by-uuid/777F-FB5D";
    fsType = "exfat";
    options = [
      "nofail"
      "uid=1000"
      "gid=100"
      "fmask=0113"
      "dmask=0022"
      "iocharset=utf8"
    ];
  };

  networking.firewall = {
    allowedTCPPorts = [
      80    # Nginx
      443   # Nginx
      8096  # Jellyfin
      25566 # Minecraft
      7777  # Terraria
      8090  # qBittorrent
    ];
    allowedUDPPorts = [
      7359  # Jellyfin local discovery
    ];
  };

  # DuckDNS
  services.duckdns = {
    enable = true;
    domains = [ "screamingbird" ];
    tokenFile = "/home/plum/duckdns-token";
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
