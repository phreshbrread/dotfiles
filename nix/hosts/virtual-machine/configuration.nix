##################################
## VIRTUAL MACHINE NIXOS CONFIG ##
##################################

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixModules/shared-config.nix
    ./../../nixModules/pkg/macbook-packages.nix
    ./../../nixModules/pkg/fonts.nix
  ];

  # Define your hostname.
  networking.hostName = "nixos-vm";

  # Set kernel packages
  boot.kernelPackages = pkgs.linuxPackages;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define a user account.
  users.users.pheg = {
    isNormalUser = true;
    description = "Pheg";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Specify XDG desktop portals
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # Desktop
  services = {
    pantheon.apps.enable = true;
    xserver = {
      enable = true;
      desktopManager.pantheon.enable = true;
      displayManager = {
        startx.enable = true;
        lightdm = {
          enable = true;
          greeters.pantheon.enable = true;
        };
      };
    };
  };

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
