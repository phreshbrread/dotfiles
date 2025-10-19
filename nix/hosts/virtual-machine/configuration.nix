##################################
## VIRTUAL MACHINE NIXOS CONFIG ##
##################################

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../../nixModules/shared-config.nix
    ./../../nixModules/pkg/macbook-packages.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pheg = {
    isNormalUser = true;
    description = "Pheg";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Initial system state version (no need to change)
  system.stateVersion = "25.05";
}
