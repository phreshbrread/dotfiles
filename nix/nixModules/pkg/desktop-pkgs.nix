######################
## DESKTOP PACKAGES ##
######################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    desktop-pkgs.enable = lib.mkEnableOption "Enables desktop packages";
  };

  config = lib.mkIf config.desktop-pkgs.enable {
    environment.systemPackages = with pkgs; [
      # Core
      gcc
      eza
      killall
      nh
      i2c-tools
      btop
      starship
      git-credential-manager
      seahorse
      sqlite
      unrar
      p7zip
      unzip
      nixfmt-rfc-style
      wget
      xdotool
      xorg.xprop
      xxd
      xorg.xwininfo
      yad
      ffmpeg
      lsof
      ntfs3g
      tree
      smartmontools
      alacritty

      # Extra
      floorp-bin
      fastfetch
      qjackctl
      brave
      pcsx2
      dolphin-emu
      kdePackages.kdenlive
      protonup-qt
      heroic
      steamtinkerlaunch
      lutris
      umu-launcher
      gimp3-with-plugins
      yabridge
      yabridgectl
      wineWowPackages.stagingFull
      wineWowPackages.waylandFull
      winetricks
      onlyoffice-desktopeditors
      equibop
      arrpc
      filezilla
      mangareader
      azahar
      OVMF
      jdk
      jdk8
    ];
  };
}
