{ pkgs
, lib
, ...
}:
{
  home = {
    packages =
      with pkgs; [
      ] ++ lib.optionals stdenv.isDarwin [
        nodejs_24 # for claude code
        claude-code
        # spotify
      ];
  };
}
