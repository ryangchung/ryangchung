{ pkgs, ... }:
{
  environment = {
    enableAllTerminfo = true;

    systemPackages = with pkgs; [
        coreutils
        tree-sitter
      ]
      ++ lib.optionals stdenv.isAarch64 [
        macmon
      ];

    systemPath = [
      "/usr/local/bin"
      "/opt/homebrew/bin"
      "/Users/ryan/.local/bin"
      "/Users/ryan/.cargo/bin"
      # "/Users/ryan/.bun/bin"
      "/Users/ryan/Library/pnpm"
    ];

    pathsToLink = [
      "/share/zsh"
      "/Applications"
      "/share/bash-completion"
    ];
  };
}
