##############################
## DESKTOP PACKAGES + FONTS ##
##############################

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core
    gcc
    eza
    killall
    nh
    i2c-tools
    btop
    starship
    git-credential-manager
    seahorse
    sqlite
    unrar
    p7zip
    unzip
    nixfmt-rfc-style
    mpv
    wget
    xdotool
    xorg.xprop
    xxd
    xorg.xwininfo
    yad
    ffmpeg
    lsof

    # Extra
    vscodium
    floorp
    gparted
    fastfetch
    obsidian
    blender
    spotify
    discord
    arrpc
    qjackctl
    brave
    pcsx2
    dolphin-emu
    kdePackages.kdenlive
    protonup-qt
    heroic
    steamtinkerlaunch
    lutris
    umu-launcher
    gimp3-with-plugins
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.hack
  ];
}
