{
  homebrew = {
    enable = true;
    global.autoUpdate = true;

    brews = [
      "bob"
      "poppler"
      "hugo"
      "rtk"
      "pi-coding-agent"
      "bat"
      "git-delta"
      "glow"
    ];

    casks = [
      # "codex"
      "spotify"
      # "visual-studio-code"
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
