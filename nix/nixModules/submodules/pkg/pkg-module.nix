############################
## SHARED PACKAGES MODULE ##
############################

{ pkgs, lib, inputs, ... }:

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
    exiftool
    nixfmt
    tree
    starship
    sqlite
    p7zip
    ffmpeg
    lsof
    smartmontools
    ntfs3g
    wineWow64Packages.stagingFull
    wineWow64Packages.waylandFull
    python3
    uv
    imagemagick
    direnv
    sshfs
    poppler
    jq
    zoxide
    resvg
    v4l-utils
    libsecret

    # GUI / TUI
    inputs.pmenu-git.packages.${pkgs.system}.default # Use pmenu from flake.nix
    ncdu
    kitty
    yazi
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
    warpinator
    equibop
    mpv
    vlc
    filezilla
    system-config-printer
    mousepad
    picard
    picard-tools
    qpwgraph
    kooha
    jellyfin-media-player
    tenacity
    yacreader
    nicotine-plus
    handbrake
    dosbox-x
  ];
}
