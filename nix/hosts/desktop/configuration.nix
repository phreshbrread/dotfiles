##########################
## DESKTOP NIXOS CONFIG ##
##########################

{ config, pkgs, lib, ... }:

{
  # Enable modules
  desktop-pkgs.enable    = true; # Desktop package set
  systemdBoot.enable     = true;
  virtualMachines.enable = true;
  ssh.enable             = true;
  syncthing.enable       = true;
  gaming.enable          = true;
  devTools.enable        = true;
  reaper.enable          = true;

  # Set hostname
  networking.hostName = "pheg-nixos-desktop";

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable Nix-LD
  programs.nix-ld.enable = true;

  # Ethernet IP forwarding
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };
  networking.firewall.trustedInterfaces = [ "enp8s0" ];

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 7d";
  };

  # Plasma
  services = {
    displayManager.plasma-login-manager.enable = true;
    desktopManager.plasma6.enable = true;
  };
  # Extra Plasma packages
  environment.systemPackages = with pkgs; [
    kdePackages.kcalc

    # Oxygen theme
    kdePackages.oxygen
    kdePackages.oxygen-icons
    kdePackages.oxygen-sounds
  ];

  # Exclude KDE packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    kate
    konsole
  ];

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
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
      "input"
    ];
  };

  # Hamachi
  services.logmein-hamachi.enable = true;
  programs.haguichi.enable        = true;

  # Enable programs
  programs = {
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
    "io.github.shiiion.primehack"
    "io.github.streetpea.Chiaki4deck"
    "io.github.tntwise.REAL-Video-Enhancer"
    "net.rpcs3.RPCS3"
    "org.jdownloader.JDownloader"
    "org.polymc.PolyMC"
    "nl.hjdskes.gcolor3"
    "net.shadps4.shadPS4"
    "org.gnome.Brasero"
    "com.fightcade.Fightcade"
    "dev.eden_emu.eden"
  ];

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
