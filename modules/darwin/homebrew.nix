{
  homebrew = {
    enable = true;
    global.autoUpdate = true;

    onActivation = {
      upgrade = true;
      cleanup = "zap";
      autoUpdate = true;

      extraFlags = [
        "--verbose"
      ];
    };

    brews = [ ];

    casks = [
      "raycast"
      "spotify"
      "antigravity"
    ];
  };
}
