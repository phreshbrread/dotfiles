###################
## SHARED CONFIG ##
###################

{ config, pkgs, ... }:

{
# Import all modules here
# Hosts can simply toggle the ones needed
    imports = [ # TODO Do this a better way
        ./submodules/x-module.nix
        ./submodules/vm-module.nix
        ./submodules/ssh-module.nix
        ./submodules/gaming-module.nix
        ./submodules/cosmic-module.nix
        ./submodules/editors-module.nix
        ./submodules/openbox-module.nix
        ./submodules/hyprland-module.nix
        ./submodules/syncthing-module.nix
        ./submodules/systemd-boot-module.nix
        ./submodules/pkg/pkg-module.nix
    ];

# Enable text editors for all hosts
    editors-module.enable = true;

# Enable package index
    programs.nix-index.enable = true;

# Allow unfree packages
    nixpkgs.config.allowUnfree = true;

# Enable Flakes
    nix.settings.experimental-features = [
        "nix-command"
            "flakes"
    ];

# Bluetooth
    hardware.bluetooth = {
        enable = true;
        settings = {
          General = {
            FastConnectable = true;
            JustWorksRepairing = "always";
          };
        };
    };

# Environment variables
    environment.variables = {
        TERMINAL    = "kitty";
        TERM        = "kitty";
        EDITOR      = "nvim";
    };

    xdg = {
# Set default XDG terminal
        terminal-exec = {
            enable = true;
            settings.default = [ "kitty.desktop "];
        };

# Set default apps
        mime.defaultApplications = {
# https://mimetype.io/all-types for types
            "application/pdf" = "floorp.desktop";
            "image/png" = [
                "image-roll.desktop"
                    "gimp.desktop"
            ];
        };
    };

    security = {
        rtkit.enable = true; # Enable realtime daemon

# Use doas instead of sudo
# User must be in 'wheel' group
            sudo.enable = false;
        doas = {
            enable                = true;
            wheelNeedsPassword    = true;
            extraRules = [{
                groups    = [ "wheel" ];
                keepEnv   = true;
                persist   = true;
            }];
        };
    };

# Enable XDG portals
    xdg.portal.enable = true;

# Declare services
    services = {
        power-profiles-daemon.enable    = true;
        tumbler.enable                  = true;
        gvfs.enable                     = true;

# Enable Flatpak
        flatpak = {
            enable = true;
            update.auto = {
                enable      = true;
                onCalendar  = "weekly";
            };
        };

# Enable printing
        printing = {
            enable = true;
            drivers = with pkgs; [
# Canon print drivers
                gutenprint
                    gutenprintBin
# cnijfilter2
            ];
        };

# Configure keymap in X11
        xserver.xkb = {
            layout    = "au";
            variant   = "";
        };

# Enable sound with pipewire
        pulseaudio.enable = false;
        pipewire = {
            enable            = true;
            alsa.enable       = true;
            alsa.support32Bit = true;
            pulse.enable      = true;
            jack.enable       = true;
        };
    };

    networking = {
        networkmanager = {
            enable            = true;
            wifi.powersave    = false;
            plugins = with pkgs; [
                networkmanager-openvpn
                    networkmanager-strongswan
            ];
        };
        firewall = {
            enable                    = true;
            allowPing                 = true;
            logRefusedConnections     = true;
            checkReversePath          = false;
            allowedTCPPorts = [
                42000 # Warpinator
                    42001
                    2234  # Soulseek
            ];
            allowedUDPPorts = [
                42000
                    42001
                    2234
            ];
        };
    };

# Programs
    programs = {
        git.enable                  = true;
        tmux.enable                 = true;
        gamescope.enable            = true;
        fish = {
            enable = true;
            shellAliases = {
                x               = "exit";
                ls              = "eza -algh --group-directories-first --icons=always";
                cls             = "clear";
                sudo            = "doas";
                tmux-mc         = "tmux a -t minecraft-server";
                sudoedit        = "doas rnano";
                install-date    = "stat / | grep Birth";
                tmux-terraria   = "tmux a -t terraria-server";
                nrs             = "nixos-rebuild switch";
                nv              = "nvim";
                ff              = "fastfetch";
                cat             = "bat";
            };
        };

# Enable AppImage
        appimage = {
            enable = true;
            binfmt = true;
        };
    };

# Fonts
    fonts = {
        fontDir.enable          = true;
        enableDefaultPackages   = true;
        packages = with pkgs; [
            corefonts
                font-awesome
                nerd-fonts.hack
                nerd-fonts.jetbrains-mono
                noto-fonts
                noto-fonts-cjk-sans
                noto-fonts-color-emoji
        ];

        fontconfig = {
            defaultFonts.emoji = [ "Noto Color Emoji" ];
            useEmbeddedBitmaps = true;
        };
    };

# Time zone + locale
    time.timeZone         = "Australia/Melbourne";
    i18n.defaultLocale    = "en_AU.UTF-8";
    i18n.extraLocales     = [ "all" ];
    i18n.extraLocaleSettings = {
        LC_ADDRESS          = "en_AU.UTF-8";
        LC_IDENTIFICATION   = "en_AU.UTF-8";
        LC_MEASUREMENT      = "en_AU.UTF-8";
        LC_MONETARY         = "en_AU.UTF-8";
        LC_NAME             = "en_AU.UTF-8";
        LC_NUMERIC          = "en_AU.UTF-8";
        LC_PAPER            = "en_AU.UTF-8";
        LC_TELEPHONE        = "en_AU.UTF-8";
        LC_TIME             = "en_AU.UTF-8";
    };
}
