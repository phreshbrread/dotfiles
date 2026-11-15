############################
## SHARED PACKAGES MODULE ##
############################

{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./desktop-pkgs.nix
    ./macbook-pkgs.nix
  ];

  # Allow insecure packages
  nixpkgs.config = {
    allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg) [
      "broadcom-sta"
      "ventoy"
    ];

    problems.handlers = {
      "gtk+".broken = "warn";
    };
  };

  environment.systemPackages = with pkgs; [
    # CLI
    eza
    gcc
    bat
    ripgrep
    fastfetch
    killall
    extract-xiso
    nh
    exiftool
    unrar
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
    resvg
    v4l-utils
    libsecret
    ventoy
    inxi
    libnotify
    vulkan-tools
    android-tools
    gdb
    man
    man-pages
    gnumake
    yt-dlp
    flac2mp3

    # TUI
    inputs.pmenu-tui.packages.${stdenv.hostPlatform.system}.default
    gf
    ncdu
    yazi
    btop
    wifitui

    # GUI
    inputs.zooma.packages.${stdenv.hostPlatform.system}.default
    kitty
    librewolf
    obsidian
    blender
    gparted
    spotify
    warpinator
    equibop
    mpv
    vlc
    filezilla
    system-config-printer
    picard
    picard-tools
    qpwgraph
    tenacity
    yacreader
    nicotine-plus
    handbrake
    remmina
  ];
}
