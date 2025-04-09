# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.timeoutStyle = "hidden";

  # Set hostname
  networking.hostName = "brad-toshiba-nixos"; 

  # Enables wireless support via wpa_supplicant
  # networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties
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

  # Environment Variables
  environment.variables = {
    EDITOR = "nano";
    TERM = "alacritty";
  };

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Use doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = ["brad"];
    keepEnv = true;
    persist = true;
  }];

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.brad = {
    isNormalUser = true;
    description = "Brad";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # Enable automatic login for the user
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "brad";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    hyprland
    hyprcursor
    hyprpolkitagent
    alacritty
    git
    fish
    waypaper
    waybar
    doas
    starship
    font-awesome
    wofi
    networkmanagerapplet
    floorp
    brightnessctl
    swaybg
    rustup
    gcc
    fastfetch
    btop
    swaynotificationcenter
    nwg-look
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    lightdm-gtk-greeter
    dolphin
    gparted
    fuzzel
    killall
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.hyprland.enable = true;
  programs.fish.enable = true;
  programs.kdeconnect.enable = true;

  # List services that you want to enable:
  # Lightdm GTK greeter
  services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
  services.xserver.displayManager.lightdm.greeters.gtk.theme.name = "Breeze-Dark";

  # Enable the OpenSSH daemon
  # services.openssh.enable = true;

  # Open ports in the firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  


  # Disable firewall
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html)
  system.stateVersion = "24.11"; # Did you read the comment?

}
