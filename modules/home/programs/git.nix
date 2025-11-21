{
  # config,
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = false;
    maintenance.enable = false;
    settings.user = {
      email = "ryan.chung.cs@gmail.com";
      name = "Ryan Chung";
    };

    # aliases = {
    #   ga = "git add .";
    # };

    settings = {
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };
}
