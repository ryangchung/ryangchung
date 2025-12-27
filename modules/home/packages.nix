{ pkgs, lib, ... }:
{
  home = {
    packages =
      with pkgs; [
      ] ++ lib.optionals stdenv.isDarwin [
        vips
        gnutls
        sqlite
        direnv
        devenv
        binutils
        binutils
        shellcheck
      ];
  };
}
