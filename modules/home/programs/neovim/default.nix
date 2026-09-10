{ pkgs
, ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
      gh
    ];

    initLua = builtins.readFile ./config/init.lua;
  };
}
