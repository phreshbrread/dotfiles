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
  imports = [
    ./hardware-configuration.nix
    ./extra-hardware-configuration.nix
    ./../../nixModules/shared-config.nix
    ./../../nixModules/server-specific.nix
    ./../../nixModules/pkg/pkg-module.nix
  ];

  # Enable desktop packages module
  desktop-pkgs.enable = true;

  # Set hostname
  networking.hostName = "pheg-nixos-desktop";

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
      memtest86.enable = true;
    };
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Environment variables
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    GCM_CREDENTIAL_STORE = "secretservice";
    TERMINAL = "alacritty";
  };

  # Enable KDE Plasma
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.autoLogin.user = "brad";
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

  # Enable programs
  programs = {
    adb.enable = true;
    gamemode.enable = true;
    kdeconnect.enable = true;

    # OBS + Plugins
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.droidcam-obs ];
    };

    # Steam
    steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
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
    "dev.ares.ares"
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
    "org.kde.kdenlive"
  ];

  # Enable VM support
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "brad" ];
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
