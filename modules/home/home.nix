{
  imports = [
    ./packages.nix
  ];

  home = {
    shell = {
      enableShellIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    sessionPath = [
      "/usr/local/bin"
      "/etc/profiles/per-user/$USER/bin"
      "/nix/var/nix/profiles/system/sw/bin"
    ];
  };
}
