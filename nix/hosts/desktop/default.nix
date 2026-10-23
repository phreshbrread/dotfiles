{ config, pkgs, lib, ... }:

{
  imports = [
    ./configuration.nix
    ./extra-hardware-configuration.nix
    ./hardware-configuration.nix
    ./server-stuff.nix
  ];
}
