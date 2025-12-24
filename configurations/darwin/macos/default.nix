{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.default
  ];

  # Moves old dotfiles out of the way, and avoids clobbering via unique backup file extension
  home-manager.backupFileExtension = "nixos-unified-template-backup";
  system.stateVersion = 6;
}
