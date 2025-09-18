{
  # config,
  ...
}:
{
  # home.shellAliases.lg = "lazygit";
  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
      disableStartupPopups = true;
      promptToReturnFromSubprocess = true;

      gui = {
        sidePanelWidth = 0.33;
        nerdFontsVersion = "3";
        scrollPastBottom = true;
        scrollOffBehaviour = "jump";
        switchTabsWithPanelJumpKeys = true;
      };

      os = {
        editInTerminal = true;
        edit = "nvim {{filename}}";
        openDirInEditor = "nvim {{dir}}";
        editAtLine = "nvim +{{line}} {{filename}}";
      };

      git = {
        parseEmoji = true;
        commit.signOff = true;
        branchPrefix = "rc/";
        # branchPrefix = "${config.me.username}/";
      };
    };
  };
}
