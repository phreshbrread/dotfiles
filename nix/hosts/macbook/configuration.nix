##########################
## MACBOOK NIXOS CONFIG ##
##########################

{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable modules
  macbook-pkgs.enable        = true; # Macbook package set
  systemd-boot-module.enable = true;
  hyprland-module.enable     = true;
  x-module.enable            = true; # X window managers
  vm-module.enable           = true; # VM support
  ssh-module.enable          = true;
  syncthing-module.enable    = true;
  gaming-module.enable       = true;
  openbox-module.enable      = true;

  # Set kernel packages
  boot.kernelPackages = pkgs.linuxPackages;

  # Network
  networking = {
    hostName                    = "fentbook";
    networkmanager.wifi.backend = "iwd";
    wireless.iwd = {
      settings = {
        Network.EnableIPv6      = true;
        #Settings.Autoconnect    = true;
      };
    };
  };

  # Environment variables
  environment.variables = {
    GDK_SCALE                   = "1";
    GDK_DPI_SCALE               = "0.5";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    _JAVA_OPTIONS               = "-Dsun.java2d.uiScale=2";
    PROTON_USE_WINED3D          = "1";
  };

  # Define user account
  users.users.brad = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  # Intel graphics
  hardware.graphics = {
    enable      = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
  hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.intel-vaapi-driver ];

  # LXQT
  services.xserver.desktopManager.lxqt.enable = true;

  # Use ly
  services.displayManager.ly.enable = true;

  # Enable touchpad
  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile       = "flat"; # Disable touchpad acceleration
      naturalScrolling   = true;
      disableWhileTyping = true;
    };
  };

  # Declare flatpaks
  services.flatpak.packages = [
    "org.polymc.PolyMC"
    "fm.reaper.Reaper"
    "org.jdownloader.JDownloader"
  ];

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Ignore power key
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  # Initial system state version (no need to change)
  system.stateVersion = "24.11";
}
