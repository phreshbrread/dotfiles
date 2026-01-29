##########################
## DESKTOP NIXOS CONFIG ##
##########################

{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Enable modules
  desktop-pkgs.enable = true; # Desktop package set
  systemd-boot-module.enable = true;
  hyprland-module.enable = true;
  vm-module.enable = true; # VM support

  # Set hostname
  networking.hostName = "pheg-nixos-desktop";

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable desktop environments
  services = {
    displayManager = {
      sddm.enable = true; # Use SDDM as display manager
      autoLogin.user = "brad";
    };

    desktopManager = {
      # KDE Plasma
      plasma6.enable = true;

      # COSMIC
      cosmic.enable = true;
      cosmic.xwayland.enable = true;
    };
  };

  # OpenRGB udev rules
  services.udev.packages = with pkgs; [
    openrgb-with-all-plugins
  ];

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "brad";
    dataDir = "/home/brad";
  };

  # Define user account
  users.users.brad = {
    isNormalUser = true;
    description = "Brad";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
      "audio"
      "adbusers"
    ];
  };

  # Hamachi
  services.logmein-hamachi.enable = true;
  programs.haguichi.enable = true;

  # Enable programs
  programs = {
    gamemode.enable = true;
    kdeconnect.enable = true;

    # OBS + Plugins
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = [ pkgs.obs-studio-plugins.droidcam-obs ];
    };

    # Steam
    steam = {
      enable = true;
      protontricks.enable = true;
    };

    # Thunderbird
    thunderbird = {
      enable = true;
      package = pkgs.thunderbird-latest;
    };
  };

  # Realtime permissions
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
  ];

  # Declare flatpaks
  services.flatpak.packages = [
    "com.dec05eba.gpu_screen_recorder"
    "com.steamgriddb.SGDBoop"
    "com.usebottles.bottles"
    "fm.reaper.Reaper"
    "fr.handbrake.ghb"
    "io.github.aandrew_me.ytdn"
    "io.github.shiiion.primehack"
    "io.github.streetpea.Chiaki4deck"
    "io.github.tntwise.REAL-Video-Enhancer"
    "net.rpcs3.RPCS3"
    "org.jdownloader.JDownloader"
    "org.openrgb.OpenRGB"
    "org.polymc.PolyMC"
    "nl.hjdskes.gcolor3"
    "net.shadps4.shadPS4"
  ];

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
