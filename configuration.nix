{ config
, lib
, pkgs
, ...
}: {
  environment = {
    systemPackages = with pkgs; [
      cmake
      coreutils
      binutils
      gnutls
      vips
      sqlite
      binutils
      shellcheck
      direnv
      spotify
      gemini-cli
    ];

    pathsToLink = [
      "/share/zsh"
      "/share/bash-completion"
    ];
  };

  users.users.ryan = {
    home = "/Users/ryan";
  };

  nix = {
   settings = {
     trusted-users = [
       "root"
       "ryan"
     ];
     experimental-features = [
       "nix-command"
       "flakes"
     ];
   };
  };

  system = {
    primaryUser = "ryan";
    defaults = {
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      controlcenter = {
        Bluetooth = false;
        Display = false;
        NowPlaying = false;
      };
    };
    stateVersion = 6;
  };

  nixpkgs = {
   hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };

  fonts.packages = with pkgs; [
    iosevka
  ];

  homebrew = {
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    casks = [
      "raycast"
      # "arc"
    ];
  };
}
