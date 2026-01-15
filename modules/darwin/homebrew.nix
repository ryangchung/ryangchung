{
  homebrew = {
    enable = true;
    global.autoUpdate = true;

    casks = [
      "antigravity"
      "codex"
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
