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
      devenv
      android-studio

      # C
      cmake
      gcc
      clang
      gnumake
      gdb

      # Rust
      rustup
      rust-analyzer
      #cargo
      #rustc
      #rustfmt
      #clippy
      rust-analyzer
    ];
  };
}
