{ pkgs
, lib
, ...
}:
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
        nodejs_24 # for claude code
        shellcheck
        claude-code
        # spotify
      ];
  };
}
