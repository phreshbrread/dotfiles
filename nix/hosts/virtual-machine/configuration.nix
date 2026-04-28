##################################
## VIRTUAL MACHINE NIXOS CONFIG ##
##################################

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable modules
  macbook-pkgs.enable = true;
  hyprland-module.enable = true;

  # Define hostname
  networking.hostName = "nixos-vm";

  # Bootloader + kernel
  boot = {
    kernelPackages = pkgs.linuxPackages;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

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

  # GNOME keyring
  services.gnome.gnome-keyring.enable = true;

  # Autologin
  services.getty = {
    autologinUser = "pheg";
    autologinOnce = true;
  };

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
