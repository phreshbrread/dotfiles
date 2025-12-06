##################################
## VIRTUAL MACHINE NIXOS CONFIG ##
##################################

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixModules/shared-config.nix
  ];

  # Enable macbook packages module
  macbook-pkgs.enable = true;

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

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
