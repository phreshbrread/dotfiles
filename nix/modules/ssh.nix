{ pkgs, lib, config, ... }:
let
  cfg = config.ssh;
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4CrQpgClN88TzMPVCkACe0r6n3kwPttU8b2ir5C9oa" # Mobile phone
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBno6ku/9vynuqpYNH1OLx1hZ1X0qciMycvzd5YM/aW8" # Macbook
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBsOBvqJxsicqpr4wDYLwR9s2VezX0r84vRpsSM/I0Oe" # Desktop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ6A3BTsde4wQCZPXwmjorPNk13BdOL0+nJa+rlH0IjH" # Toshiba laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOoINyatbHwAARhJnwBQccXXDH1/PnQ0C4B8KJpwQC66" # ROG Ally
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINcBwMGwNJVLw/puNsZjpZXjH36/BFW3ySzfTlZJxCdW" # Server
  ];
  targetUsers = [ "plum" "brad" "pheg" ];
in
{
  options.ssh.enable = lib.mkEnableOption "Enable openssh";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = false;
        UseDns = true;
        X11Forwarding = true;
        PermitRootLogin = "yes";
      };
    };

    # Write the keys to a system-wide file, then open for each user
    environment.etc."ssh/authorized_keys_global".text = builtins.concatStringsSep "\n" sshKeys;
    services.openssh.settings.AuthorizedKeysFile = ".ssh/authorized_keys /etc/ssh/authorized_keys_global";
  };
}
