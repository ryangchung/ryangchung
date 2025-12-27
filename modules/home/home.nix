{
  imports = [
    ./packages.nix
  ];

  home = {
    shell = {
      enableBashIntegration = true;
      enableShellIntegration = true;
      enableZshIntegration = true;
    };

    sessionPath = [
      "/etc/profiles/per-user/$USER/bin"
      "/nix/var/nix/profiles/system/sw/bin"
      "/usr/local/bin"
    ];
  };
}
