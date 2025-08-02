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
    reaper
    brave
    pcsx2
    dolphin-emu
    kdePackages.kdenlive
    protonup-qt
    heroic
    #openrgb-with-all-plugins
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.hack
  ];
}
