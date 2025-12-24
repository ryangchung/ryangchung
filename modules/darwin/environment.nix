{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      macmon
      devenv
    ];

    pathsToLink = [
      "/share/zsh"
      "/share/bash-completion"
    ];
  };
}
