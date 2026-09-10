{
  homebrew = {
    enable = true;
    global.autoUpdate = true;

    brews = [
      "rtk"
      "pi-coding-agent"
      "bat"
      "git-delta"
      "glow"
    ];

    casks = [
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
