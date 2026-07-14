##########################
## DESKTOP NIXOS CONFIG ##
##########################

{ config, pkgs, lib, ... }:

{
  # Enable modules
  desktop-pkgs.enable        = true; # Desktop package set
  systemd-boot-module.enable = true;
  hyprland-module.enable     = true;
  vm-module.enable           = true; # VM support
  ssh-module.enable          = true;
  syncthing-module.enable    = true;
  gaming-module.enable       = true;

  # Set hostname
  networking.hostName = "pheg-nixos-desktop";

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 7d";
  };

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings.Autologin = {
      Session = "hyprland.desktop";
      User    = "brad";
    };
  };

  # Exclude KDE packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    kate
    konsole
  ];

  services.hardware.openrgb = {
    enable      = true;
    package     = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

  # Define user account
  users.users.brad = {
    isNormalUser = true;
    shell        = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
      "audio"
      "adbusers"
      "i2c"
    ];
  };

  # Hamachi
  services.logmein-hamachi.enable = true;
  programs.haguichi.enable        = true;

  # Enable programs
  programs = {
    kdeconnect.enable  = true;
    obs-studio.enable  = true;
    thunderbird.enable = true;
  };

  security = {
    # Realtime permissions
    pam.loginLimits = [{
      domain = "@audio";
      item   = "rtprio";
      type   = "-";
      value  = "95";
    } {
      domain = "@audio";
      item   = "memlock";
      type   = "-";
      value  = "unlimited";
    }];
  };

  # Declare flatpaks
  services.flatpak.packages = [
    "com.dec05eba.gpu_screen_recorder"
    "com.steamgriddb.SGDBoop"
    "com.usebottles.bottles"
    "fm.reaper.Reaper"
    "io.github.shiiion.primehack"
    "io.github.streetpea.Chiaki4deck"
    "io.github.tntwise.REAL-Video-Enhancer"
    "net.rpcs3.RPCS3"
    "org.jdownloader.JDownloader"
    "org.polymc.PolyMC"
    "nl.hjdskes.gcolor3"
    "net.shadps4.shadPS4"
    "org.gnome.Brasero"
  ];

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
