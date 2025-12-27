{ inputs, ... }:

{
  imports = [
    inputs.nixos-unified.flakeModules.autoWire
    inputs.nixos-unified.flakeModules.default
  ];

  perSystem = { self', pkgs, ... }: {
    # For 'nix fmt .'
    formatter = pkgs.nixpkgs-fmt;

    # Enables 'nix run' to activate.
    packages.default = self'.packages.activate;
  };
}
