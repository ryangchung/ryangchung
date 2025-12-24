# List of users for darwin or nixos system and their top-level configuration.
{
  flake,
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (flake.inputs) self;
  mapListToAttrs =
    m: f:
    lib.listToAttrs (
      map (name: {
        inherit name;
        value = f name;
      }) m
    );
in
{
  options = {
    myusers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of usernames";
      defaultText = "All users under ./configuration/users are included by default";
      default =
        let
          dirContents = builtins.readDir (self + /configurations/home);
          fileNames = builtins.attrNames dirContents; # Extracts keys: [ "ryan.nix" ]
          regularFiles = builtins.filter (name: dirContents.${name} == "regular") fileNames; # Filters for regular files
          baseNames = map (name: builtins.replaceStrings [ ".nix" ] [ "" ] name) regularFiles; # Removes .nix extension
        in
        baseNames;
    };
  };

  config = {
    # For home-manager to work.
    # https://github.com/nix-community/home-manager/issues/4026#issuecomment-1565487545
    users.users = mapListToAttrs config.myusers (
      name:
      lib.optionalAttrs pkgs.stdenv.isDarwin {
        home = "/Users/${name}";
      }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        isNormalUser = true;
        shell = pkgs.zsh;
      }
    );

    home-manager = {
      backupFileExtension = "hm-bak";
      users = mapListToAttrs config.myusers (name: {
        imports = [
          (self + /configurations/home/${name}.nix)
        ];
      });
    };

    nix = {
      gc.automatic = true;
      optimise.automatic = true;
      channel.enable = pkgs.stdenv.isDarwin;


      settings = {
        max-jobs = "auto";
        show-trace = true;
        trace-verbose = true;
        http-connections = 40;
        max-substitution-jobs = 32;
        # FIXME: showing as unknown option despite - https://nix.dev/manual/nix/2.24/command-ref/conf-file.html#conf-download-buffer-size
        # download-buffer-size = 6710886400;
        auto-optimise-store = pkgs.stdenv.isLinux;

        experimental-features = [
          "flakes"
          "nix-command"
          "pipe-operators"
          # "pipe-operator" # if using lix
        ];

        trusted-users = [
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [
          "root"
        ]
        ++ lib.optionals pkgs.stdenv.isDarwin [
          "@admin"
        ]
        ++ config.myusers;

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
          "https://mfarabi.cachix.org"
          "https://nixpkgs.cachix.org"
          "https://nix-darwin.cachix.org"
          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          "mfarabi.cachix.org-1:FPO/Xsv7VIaZqGBAbjYMyjU1uUekdeEdMbWfxzf5wrM="
          "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
          "nix-darwin.cachix.org-1:LxMyKzQk7Uqkc1Pfq5uhm9GSn07xkERpy+7cpwc006A="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
  };
}
