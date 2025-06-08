{ pkgs, ...}: {
  # System packages
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
    wl-clipboard

    # Core (Hyprland)
    hyprpolkitagent
    hyprprop
    hyprnotify
    hyprcursor
    alacritty
    waybar
    waypaper
    networkmanagerapplet
    mpd
    playerctl
    brightnessctl
    swaybg
    fuzzel
    xfce.thunar
    smile
    grim
    slurp
    hyprshot

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
  ];

  # System fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.hack
  ];
}