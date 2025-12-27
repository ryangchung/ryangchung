{
  homebrew = {
    enable = true;
    global.autoUpdate = true;

    brews = [
      "gemini-cli"
    ];

    casks = [
      "antigravity"
      "claude-code"
      "obsidian"
      "raycast"
      "spotify"
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
