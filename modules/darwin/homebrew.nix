{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      extraFlags = [
        "--verbose"
      ];
    };
    casks = [
      "raycast"
      "spotify"
    ];
    brews = [ ];
  };
}
