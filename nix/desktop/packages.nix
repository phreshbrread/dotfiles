##############################
## DESKTOP PACKAGES + FONTS ##
##############################

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core (System)
    gcc
    eza
    killall
    nh
    btop
    starship
    git-credential-manager
    seahorse
    sqlite
    nixfmt-rfc-style
    mpv

    # Extra
    vscodium
    floorp
    gparted
    fastfetch
    obsidian
    blender
    steamtinkerlaunch
    spotify
    discord
    arrpc
    qjackctl
    reaper
    brave
    pcsx2
    dolphin-emu
    openrgb-with-all-plugins
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.hack
  ];
}
