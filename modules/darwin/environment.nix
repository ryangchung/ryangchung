{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      macmon
      # spotify
    ];

    pathsToLink = [
      "/share/zsh"
      "/share/bash-completion"
    ];
  };
}
