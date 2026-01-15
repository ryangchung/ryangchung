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
      "leader-key"
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
