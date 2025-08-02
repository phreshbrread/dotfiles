##########################
## DESKTOP NIXOS CONFIG ##
##########################

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./extra-hardware-configuration.nix
    ./server-specific.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Environment variables
  environment.variables = {
    GCM_CREDENTIAL_STORE = "secretservice";
  };

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set hostname
  networking.hostName = "pheg-nixos-desktop";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Set your time zone.
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

  # Enable KDE Plasma.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.autoLogin.user = "brad";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Define user account
  users.users.brad = {
    isNormalUser = true;
    description = "Brad";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
    ];
  };

  # Use doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "brad" ];
      keepEnv = true;
      persist = true;
    }
  ];

  # Enable AppImages
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Enable programs
  programs.git.enable = true;
  programs.fish.enable = true;
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.kdeconnect.enable = true;
  programs.steam = {
    enable = true;
    protontricks.enable = true;
  };
  programs.thunderbird = {
    enable = true;
    package = pkgs.thunderbird-latest;
  };

  # Enable Flatpak & add flathub repo
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # OpenRGB udev rules
  services = {
    udev.packages = with pkgs; [
      openrgb-with-all-plugins
    ];
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "brad";
    dataDir = "/home/brad";
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [
      8096
      8920
      7777
    ];
    allowedUDPPorts = [ 7359 ];
    logRefusedConnections = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
