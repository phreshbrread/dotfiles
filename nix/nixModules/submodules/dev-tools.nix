######################
## DEV TOOLS MODULE ##
######################

{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    dev-tools.enable = lib.mkEnableOption "Enables extra software development tools";
  };

  config = lib.mkIf config.dev-tools.enable {
    environment.systemPackages = with pkgs; [
      # C
      cmake
      gcc
      clang
      gnumake
      gdb

      # Rust
      cargo
      rustc
      rustfmt
      clippy
      rust-analyzer
    ];
  };
}
