{
  homebrew = {
    enable = true;
    global.autoUpdate = true;

    brews = [
      "gh"
      "hugo"
    ];

    casks = [
      "anki"
      "antigravity"
      "google-chrome"
      "obsidian"
      "raycast"
      "spotify"
      "visual-studio-code"
    ];

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;

      extraFlags = [
        "--verbose"
      ];
    };
  };
}
