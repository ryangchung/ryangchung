{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    buildPlatform = "aarch64-darwin";
    hostPlatform = "aarch64-darwin";
  };
}
