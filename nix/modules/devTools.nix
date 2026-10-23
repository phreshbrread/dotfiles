{ pkgs, lib, config, ... }:
let cfg = config.devTools; in {
  options.devTools.enable = lib.mkEnableOption "Enables extra software development tools";

  config = lib.mkIf cfg.enable {
    # Set rust library path
    environment.variables.RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";

    environment.systemPackages = with pkgs; [
      devenv
      android-studio

      # C
      cmake
      gcc
      clang
      clang-tools
      gnumake
      gdb

      # Rust
      rust-analyzer
      cargo
      rustc
      rustfmt
      clippy

      # Zig
      zig
      zls
    ];
  };
}
