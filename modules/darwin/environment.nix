{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      macmon
      devenv
      # spotify
    ];

    pathsToLink = [
      "/share/zsh"
      "/share/bash-completion"
    ];
  };
}
