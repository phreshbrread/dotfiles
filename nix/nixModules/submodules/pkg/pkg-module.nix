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
    eza
    ripgrep
    ripgrep-all
    fzy
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
    spotify
    discord
    warpinator
    mpv
    vlc
    sqlite
    p7zip
    ffmpeg
    lsof
    ntfs3g
    smartmontools
    wineWowPackages.stagingFull
    wineWowPackages.waylandFull
    filezilla
    system-config-printer
  ];

  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    corefonts
    font-awesome
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
  ];
}
