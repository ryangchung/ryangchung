{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.default
  ];

  # Defined by /modules/home/me.nix
  # And used all around in /modules/home/*
  me = {
    username = "ryan";
    fullname = "Ryan Chung";
    email = "ryan.chung.cs@gmail.com";
  };

  home.stateVersion = "25.05";
}
