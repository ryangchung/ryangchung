{ pkgs
, lib
, ...
}:
{
  targets = {
    darwin = lib.mkIf pkgs.stdenv.isDarwin {
      search = "Google";

      currentHostDefaults = {
        "com.apple.controlcenter" = {
          BatteryShowPercentage = true;
        };
      };

      defaults = {
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.dock" = {
          autohide = true;
          orientation = "bottom";
          tileSize = 48;
        };

        "com.apple.finder" = {
          AppleShowAllFiles = true;
          showPathBar = true;
          ShowStatusBar = true;
        };

        "com.apple.menuextra.clock" = {
          IsAnalog = false;
          ShowAMPM = true;
          ShowDate = 1;
        };

        NSGlobalDomain = {
          AppleMetricUnits = true;
          AppleMesurementUnits = "Centimeters";
        };
      };

      # https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/EventOverview/TextDefaultsBindings/TextDefaultsBindings.html
      keybindings = {
        "^u" = "deleteToBeginningOfLine:";
        "^w" = "deleteWordBackward:";
      };

      linkApps = {
        enable = true;
        directory = "Applications";
      };
    };
  };
}
