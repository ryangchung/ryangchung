{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.default
  ];

  home.stateVersion = "25.05";

  # Defined by /modules/home/me.nix, used in /modules/home/*
  me = {
    username = "ryan";
    fullname = "Ryan Chung";
    email = "ryan.chung.cs@gmail.com";
  };
}
