{ pkgs
, ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = true;
    withNodeJs = true;
    withPython3 = true;

    initLua = builtins.readFile ./config/init.lua;
  };
}
