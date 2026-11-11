{ config, lib, pkgs-stable, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bignuts";

  networking.networkmanager.enable = true;

  system.stateVersion = "26.11";
}

