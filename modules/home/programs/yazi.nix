{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "yy";

    plugins = {
      inherit (pkgs.yaziPlugins)
        sudo
        git
        lazygit
        smart-enter
        full-border
        smart-filter
        rich-preview
        ;
    };

    settings = {
      mgr = {
        ratio = [
          1
          4
          3
        ];
        show_hidden = true;
        show_symlink = true;
        sort_dir_first = true;
      };
    };

    initLua = ''
      require("full-border"):setup()
      require("git"):setup()
      require("smart-enter"):setup {
      open_multi = true,
      }
    '';
  };
}
