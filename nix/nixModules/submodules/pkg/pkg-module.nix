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
    bat
    ripgrep
    fastfetch
    git-credential-manager
    killall
    nh
    nixfmt
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
    direnv
    sshfs

    # GUI / TUI
    alacritty
    btop
    floorp-bin
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
    ranger
    qjackctl
    qpwgraph
    kooha
    jellyfin-media-player
    tenacity

    # Appearance
    papirus-icon-theme

    # Language servers
    rust-analyzer
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
