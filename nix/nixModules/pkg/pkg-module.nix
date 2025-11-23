############################
## SHARED PACKAGES MODULE ##
############################

{ pkgs, lib, ... }:

{
  imports = [
    ./desktop-pkgs.nix
    ./macbook-pkgs.nix
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    blender
    btop
    discord
    eza
    fastfetch
    gcc
    git-credential-manager
    gparted
    killall
    nh
    nixfmt-rfc-style
    obsidian
    seahorse
    starship
    steamtinkerlaunch
    tree
    libnotify
    inxi
    vulkan-tools
    vscodium-fhs
    spotify
    discord
    warpinator
    mpv
    vlc
  ];

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    corefonts
    font-awesome
    nerd-fonts.hack
    noto-fonts
  ];
}
