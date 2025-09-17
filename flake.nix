# git add .; nix run .#update --show-trace
# git add .; nix run .#activate --show-trace
# git add .; nix run .#activate $USER@$HOSTNAME --show-trace
{
  description = "Ryan Chung's distributed NixOS Configurations.";

  inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-unified.url = "github:srid/nixos-unified";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

nix-darwin = {
url = "github:nix-darwin/nix-darwin/master";
inputs.nixpkgs.follows = "nixpkgs";
};

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # nixos-unified.org/autowiring.html
  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake
      { inherit inputs; root = ./.; };
}
