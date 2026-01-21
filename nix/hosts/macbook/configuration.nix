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
  imports = [
    ./hardware-configuration.nix
    ./../../nixModules/shared-config.nix
  ];

  # Enable macbook packages module
  macbook-pkgs.enable = true;

  # Enable WM modules
  hyprland-module.enable = true;
  x-module.enable = true;

  # Set hostname
  networking.hostName = "pheg-nixos-macbook";

  # Set kernel packages
  boot.kernelPackages = pkgs.linuxPackages;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

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

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "brad";
    dataDir = "/home/brad";
  };

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

  # SSH
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "brad" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "yes";
    };
  };

  # Authorised SSH keys
  users.users.brad.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBsOBvqJxsicqpr4wDYLwR9s2VezX0r84vRpsSM/I0Oe brad@pheg-nixos-desktop"
  ];

  # Ignore power key
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
