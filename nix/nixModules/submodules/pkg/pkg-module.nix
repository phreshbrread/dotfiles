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
    # CLI
    eza
    gcc
    ripgrep
    fastfetch
    git-credential-manager
    killall
    nh
    nixfmt
    steamtinkerlaunch
    tree
    starship
    sqlite
    p7zip
    ffmpeg
    lsof
    smartmontools
    ntfs3g
    wineWowPackages.stagingFull
    wineWowPackages.waylandFull
    python3
    uv
    imagemagick

    # GUI / TUI
    alacritty
    btop
    obsidian
    blender
    seahorse
    gparted
    libnotify
    inxi
    vulkan-tools
    spotify
    discord
    warpinator
    mpv
    vlc
    filezilla
    system-config-printer
    mousepad
    picard
    picard-tools

    # Language servers
    rust-analyzer

    # Other
    papirus-icon-theme
    pantheon.elementary-wallpapers
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
