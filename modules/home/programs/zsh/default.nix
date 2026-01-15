{ pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = false;
    enableCompletion = true;

    shellAliases = {
      mkdir = "mkdir -p";
      coderabbit = "~/.local/bin/coderabbit"; # Relies on installing https://www.coderabbit.ai/cli
      leader-key-settings = "open \"leaderkey://settings\"";
    };

    history = {
      size = 10000;
      save = 10000;
      share = true;
      append = true;
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
    };

    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "line"
        "main"
        "root"
        "regexp"
        "pattern"
        "brackets"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./.;
        file = ".p10k.zsh";
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "colorize"
        "colored-man-pages"
      ]
      ++ lib.optionals pkgs.stdenv.isDarwin [
        "macos"
      ];
    };
  };
}
