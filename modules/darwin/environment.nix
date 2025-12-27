{ pkgs, ... }:
{
  environment = {
    enableAllTerminfo = true;

    pathsToLink = [
      "/share/zsh"
      "/Applications"
      "/share/bash-completion"
    ];

    systemPackages = with pkgs; [
      coreutils
    ] ++ lib.optionals stdenv.isAarch64 [
      macmon
    ];

    systemPath = [
      "/usr/local/bin"
      "/opt/homebrew/bin"
      "/Users/ryan/.local/bin"
      "/Users/ryan/.cargo/bin"
      "/Users/ryan/Library/pnpm"
    ];
  };
}
