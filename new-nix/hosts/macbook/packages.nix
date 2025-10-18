# ############################
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
    
    # Core (DWM)
    dmenu
    nitrogen

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

    # Appearance
    arc-theme
    lxappearance
    lxappearance-gtk2
    xfce.xfwm4-themes
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    nwg-look
    papirus-icon-theme
    phinger-cursors
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons

    # Extra
    wev
    hyprpicker
    vscodium
    floorp-bin
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
    equibop
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.hack
  ];
}
