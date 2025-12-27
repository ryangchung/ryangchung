{ flake, pkgs, lib, config, ... }:
let
  inherit (flake.inputs) self;
  mapListToAttrs =
    m: f:
    lib.listToAttrs (
      map
        (name: {
          inherit name;
          value = f name;
        })
        m
    );
in
{
  config = {
    home-manager = {
      backupFileExtension = "hm-bak";
      users = mapListToAttrs config.myusers (name: {
        imports = [
          (self + /configurations/home/${name}.nix)
        ];
      });
    };

    nix = {
      channel.enable = pkgs.stdenv.isDarwin;
      gc.automatic = true;
      optimise.automatic = true;

      settings = {
        auto-optimise-store = pkgs.stdenv.isLinux;
        http-connections = 40;
        max-jobs = "auto";
        max-substitution-jobs = 32;
        show-trace = true;
        trace-verbose = true;

        experimental-features = [
          "flakes"
          "nix-command"
        ];

        trusted-users = [

        ] ++ lib.optionals pkgs.stdenv.isLinux [
          "root"
        ] ++ lib.optionals pkgs.stdenv.isDarwin [
          "@admin"
        ] ++ config.myusers;

        substituters = [
          "https://cache.nixos.org"
          "https://cachix.cachix.org"
          "https://devenv.cachix.org"
          "https://mfarabi.cachix.org"
          "https://nixpkgs.cachix.org"
          "https://nix-darwin.cachix.org"
          "https://nix-community.cachix.org"
        ];

        trusted-substituters = [
          "https://cache.nixos.org"
          "https://cachix.cachix.org"
          "https://devenv.cachix.org"
          "https://nixpkgs.cachix.org"
          "https://nix-darwin.cachix.org"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
          "nix-darwin.cachix.org-1:LxMyKzQk7Uqkc1Pfq5uhm9GSn07xkERpy+7cpwc006A="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };

    users.users = mapListToAttrs config.myusers (
      name:
      lib.optionalAttrs pkgs.stdenv.isDarwin
        {
          home = "/Users/${name}";
        }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        isNormalUser = true;
        shell = pkgs.zsh;
      }
    );
  };

  options = {
    myusers = lib.mkOption {
      default =
        let
          dirContents = builtins.readDir (self + /configurations/home);
          fileNames = builtins.attrNames dirContents; # Extracts keys: [ "ryan.nix" ]
          regularFiles = builtins.filter (name: dirContents.${name} == "regular") fileNames; # Filters for regular files
          baseNames = map (name: builtins.replaceStrings [ ".nix" ] [ "" ] name) regularFiles; # Removes .nix extension
        in
        baseNames;
      description = "List of usernames";
      defaultText = "All users under ./configuration/users are included by default";
      type = lib.types.listOf lib.types.str;
    };
  };
}
