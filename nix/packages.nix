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
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    nwg-look
    papirus-icon-theme
    phinger-cursors
    (catppuccin-gtk.overrideAttrs {
      accent = "mauve";
      variant = "macchiato";
    })
    (catppuccin-kvantum.overrideAttrs {
      accent = "mauve";
      variant = "macchiato";
    })

    # Extra
    wev
    hyprpicker
    vscodium
    floorp
    gparted
    fastfetch
    font-manager
    obsidian
    kdePackages.dolphin
    kdePackages.gwenview
    space-cadet-pinball
    nixfmt-rfc-style
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.hack
  ];
}
