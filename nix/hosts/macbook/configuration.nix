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
  macbook-pkgs.enable = true; # Macbook package set
  systemd-boot-module.enable = true;
  hyprland-module.enable = true;
  x-module.enable = true; # X window managers
  vm-module.enable = true; # VM support
  ssh-module.enable = true;
  syncthing-module.enable = true;

  # Set hostname
  networking.hostName = "pheg-nixos-macbook";

  # Set kernel packages
  boot.kernelPackages = pkgs.linuxPackages;

  # Allow insecure broadcom driver
  nixpkgs.config = {
    allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg) [ "broadcom-sta" ];
  };

  # Environment variables
  environment.variables = {
    #GDK_SCALE = "2";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    LIBVA_DRIVER_NAME = "i965";
  };

  # Define user account
  users.users.brad = {
    isNormalUser = true;
    description = "Brad";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  # Intel graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
  hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.intel-vaapi-driver ];

  # Use ly
  services.displayManager.ly.enable = true;

  # Enable COSMIC
  services.desktopManager.cosmic = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable touchpad
  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "flat"; # Disable touchpad acceleration
      naturalScrolling = true;
      disableWhileTyping = true;
    };
  };

  # Declare flatpaks
  services.flatpak.packages = [
    "org.polymc.PolyMC"
    "fr.handbrake.ghb"
    "fm.reaper.Reaper"
    "org.jdownloader.JDownloader"
  ];

  # Enable programs
  programs = {
    kdeconnect.enable = true;
    steam = {
      enable = true;
      protontricks.enable = true;
    };
  };

  # Enable services
  services = {
    tumbler.enable = true;
    gnome.gnome-keyring.enable = true;
    power-profiles-daemon.enable = true;
  };

  # Ignore power key
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  # Initial system state version (no need to change)
  system.stateVersion = "24.11";
}
