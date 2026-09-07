{
  homebrew = {
    enable = true;
    global.autoUpdate = true;

    brews = [
      "bob"
      "gh"
      "poppler"
      "hugo"
      "rtk"
    ];

    casks = [
      "codex"
      # "obsidian"
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
