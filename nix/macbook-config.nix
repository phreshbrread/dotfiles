#######################
## Main NixOS Config ##
#######################

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Set hostname
  networking.hostName = "brad-nixos-macbook";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Environment variables
  environment.variables = {
    EDITOR = "nano";
    GDK_SCALE = 2;
    GCM_CREDENTIAL_STORE = "secretservice";
  };

  # Define user account
  users.users.brad = {
    isNormalUser = true;
    description = "Brad";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # Use doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = ["brad"];
    keepEnv = true;
    persist = true;
  }];

  # Autologin to tty1
  services.getty = {
    autologinUser = "brad";
    autologinOnce = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable OpenGL
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

    # Appearance
    nwg-look
    elementary-xfce-icon-theme
    catppuccin-gtk
    catppuccin-kvantum
    kdePackages.qtstyleplugin-kvantum

    # Extra
    wev
    vscodium
    floorp
    gparted
    fastfetch
    font-manager
    obsidian
    kdePackages.dolphin
    kdePackages.gwenview

  ];

  # System fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.hack
  ];

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "brad";
    dataDir = "/home/brad";
  };

  # Enable programs
  programs.fish.enable = true;
  programs.steam.enable = true;
  programs.hyprland.enable = true;
  programs.kdeconnect.enable = true;

  # Enable services
  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = true;

  # Power key handling
  services.logind.powerKey = "ignore";

  # Disable firewall
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
