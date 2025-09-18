{
  # config,
  ...
}:
{
  programs.git = {
    enable = true;
    lfs.enable = false;
    maintenance.enable = false;
    userName = "Ryan Chung";
    userEmail = "ryan.chung.cs@gmail.com";

    # aliases = {
    #   ga = "git add .";
    # };

    extraConfig = {
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };
}
