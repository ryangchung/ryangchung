{
  system = {
    primaryUser = "ryan";
    startup.chime = false;
    stateVersion = 6;

    defaults = {
      controlcenter = {
        AirDrop = false;
        BatteryShowPercentage = false;
        Bluetooth = false;
        Display = false;
        FocusModes = false;
        NowPlaying = false;
        Sound = false;
      };

      dock = {
        appswitcher-all-displays = false;
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 1.0;
        expose-animation-duration = 0.0;
        launchanim = false;
        mru-spaces = false;
        show-recents = false;

        persistent-apps = [
          { app = "Applications/Safari.app"; }
          { app = "Applications/Spotify.app"; }
        ];
      };

      finder = {
        ShowPathbar = true;
        QuitMenuItem = true;
        CreateDesktop = true;
        NewWindowTarget = "Home";

        _FXSortFoldersFirst = true;
        FXPreferredViewStyle = "icnv";
        FXDefaultSearchScope = "SCcf";
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirstOnDesktop = true;
        FXEnableExtensionChangeWarning = false;

        ShowHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = true;
        ShowRemovableMediaOnDesktop = true;
        ShowExternalHardDrivesOnDesktop = true;

        ShowStatusBar = true;
        AppleShowAllExtensions = true;
      };

      loginwindow = {
        GuestEnabled = false;
        SleepDisabled = true;
        DisableConsoleAccess = false;
      };

      NSGlobalDomain = {
        AppleFontSmoothing = 2;
        AppleInterfaceStyle = "Dark";
        AppleTemperatureUnit = "Celsius";
        NSDisableAutomaticTermination = true;
        NSAutomaticWindowAnimationsEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        AppleInterfaceStyleSwitchesAutomatically = false;

        NSWindowResizeTime = 0.1;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = false;

        _HIHideMenuBar = false;

        "com.apple.springing.delay" = 0.0;
        "com.apple.springing.enabled" = false;

        "com.apple.trackpad.scaling" = 1.0;
        "com.apple.sound.beep.feedback" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
        "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
      };

      screencapture = {
        type = "png";
        target = "clipboard";
        include-date = true;
        disable-shadow = true;
        show-thumbnail = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
      spaces.spans-displays = false;

      trackpad = {
        Clicking = true;
        Dragging = true;
        ActuationStrength = 0;
        FirstClickThreshold = 0;
        SecondClickThreshold = 0;
        TrackpadRightClick = true;
      };
    };
  };
}
