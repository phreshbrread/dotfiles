{ pkgs, lib, config, ... }:
let
  cfg = config.ssh;
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
        #PermitRootLogin = "yes";
      };
    };
  };
}
