{ ... }:
{
  programs.lazygit = {
    enable = true;

    settings = {
      disableStartupPopups = true;
      notARepository = "skip";
      promptToReturnFromSubprocess = true;

      git = {
        branchPrefix = "rc/";
        commit.signOff = true;
        parseEmoji = true;
      };

      gui = {
        nerdFontsVersion = "3";
        scrollPastBottom = true;
        scrollOffBehaviour = "jump";
        sidePanelWidth = 0.33;
        switchTabsWithPanelJumpKeys = true;
      };

      os = {
        edit = "nvim {{filename}}";
        editAtLine = "nvim +{{line}} {{filename}}";
        editInTerminal = true;
        openDirInEditor = "nvim {{dir}}";
      };

    };
  };
}
