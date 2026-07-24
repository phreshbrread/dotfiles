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

  # Ensure OSS wifi modules don't conflict with proprietary broadcom_sta driver
  boot = {
    extraModulePackages      = [ config.boot.kernelPackages.broadcom_sta ];
    kernelModules            = [ "wl" ];
    blacklistedKernelModules = [ "b43" "bcma" "ssb" "brcmfmac" "brcmsmac" ];
  };

  # Hostname
  networking.hostName = "fentbook";

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

  # Ignore power key
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  # Initial system state version (no need to change)
  system.stateVersion = "24.11";
}
