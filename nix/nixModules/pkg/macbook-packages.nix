#############################
## SYSTEM PACKAGES + FONTS ##
#############################

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
    libnotify
    git-credential-manager
    seahorse
    pavucontrol
    vulkan-tools
    winePackages.stagingFull
    wine64Packages.stagingFull
    inxi
    tree
    slint-lsp
    
    # Core (DWM)
    dmenu
    nitrogen
    copyq

    # Core (Hyprland)
    hyprpolkitagent
    hyprprop
    hyprnotify
    hyprcursor
    swaynotificationcenter
    alacritty
    waybar
    waypaper
    swaybg
    networkmanagerapplet
    mpd
    playerctl
    brightnessctl
    fuzzel
    xfce.thunar
    smile
    hyprshot
    clipse
    nemo-with-extensions

    # Appearance
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    arc-theme
    papirus-icon-theme
    phinger-cursors

    # Extra
    wev
    hyprpicker
    vscodium-fhs
    floorp
    gparted
    fastfetch
    font-manager
    obsidian
    kdePackages.dolphin
    kdePackages.gwenview
    space-cadet-pinball
    nixfmt-rfc-style
    shfmt
    blender
    steamtinkerlaunch
    discord
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.hack
  ];
}
