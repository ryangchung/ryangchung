{
  homebrew = {
    enable = true;
    global.autoUpdate = true;

    brews = [
      "gh"
      "poppler"
      "hugo"
    ];

    casks = [
      "anki"
      "google-chrome"
      "codex"
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
