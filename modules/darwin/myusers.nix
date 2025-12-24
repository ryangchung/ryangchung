# List of users for darwin or nixos system and their top-level configuration.
{ flake
, pkgs
, lib
, config
, ...
}:
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
  options = {
    myusers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of usernames";
      defaultText = "All users under .configuration/users are included by default";
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
    users.users = mapListToAttrs config.myusers (
      name:
      lib.optionalAttrs pkgs.stdenv.isDarwin
        {
          home = "/Users/${name}";
        }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        isNormalUser = true;
      }
    );

    # Enable home-manager for our user
    home-manager.users = mapListToAttrs config.myusers (name: {
      imports = [
        (self + /configurations/home/${name}.nix)
      ];
    });

    # All users can add Nix caches.
    nix = {
      settings = {
        max-jobs = "auto";
        trusted-users = [
          "root"
        ]
        ++ config.myusers;
        experimental-features = [
          "flakes"
          "nix-command"
        ];
      };

      linux-builder = {
        enable = false;
        workingDirectory = "var/lib/linux-builder";
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        supportedFeatures = [
          "kvm"
          "benchmark"
          "big-parallel"
        ];
      };

      channel.enable = false;

      gc = {
        automatic = false;
      };

      optimise = {
        automatic = false;
      };
    };
  };
}
