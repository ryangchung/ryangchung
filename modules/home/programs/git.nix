{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = false;
    maintenance.enable = false;

    settings = {
      pull.rebase = false;
      init.defaultBranch = "main";

      user = {
        email = "ryan.chung.cs@gmail.com";
        name = "Ryan Chung";
      };
    };
  };
}
