{ flake, pkgs, lib, ... }:
let
  flox = flake.inputs.flox.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home = {
    packages =
      [
        flox
      ] ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin (with pkgs; [
        vips
        gnutls
        sqlite
        direnv
        devenv
        binutils
        binutils
        shellcheck
      ]);
  };
}
