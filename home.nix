{ inputs
, config
, lib
, pkgs
, ...
}: {
  home = {
    stateVersion = "25.05";
    username = "ryan";
    packages = with pkgs; [
      devenv
      nix-inspect
      ttyd
      docker
      wget
      nixpkgs-fmt
      lua5_1
      # luarocks
      # lua-language-server
      stylua
    ];
    file = {
#      ".config/nvim" = {
#        source = ../../../nvim;
#        recursive = true;
#      };
      ".p10k.zsh".source = ../../../p10k/.p10k.zsh;
      #".config/doom" = {
      #  source = ../../../doom;
      #  recursive = true;
      #};
    };
    #sessionPath = [
    #  "${config.home.homeDirectory}/.emacs.d/bin"
    #];
  };

  manual = {
    manpages.enable = true;
    html.enable = true;
    json.enable = true;
  };

  services = {
    home-manager = {
     autoExpire = {
       enable = true;
       frequency = "daily";
     };
    };
    ollama.enable = true;
  };

  programs = {
    fd.enable = true;
    home-manager.enable = true;
    lazydocker.enable = true;
    lazygit.enable = true;
    zellij.enable = true;
    gh.enable = true;
    #emacs = {
    #  enable = true;
    #};
    neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      vimAlias = true;
      viAlias = true;
    };
    bat = {
      enable = true;
    };
    ripgrep.enable = true;
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    obsidian = {
      enable = true;
    };
    yazi = {
      enable = true;
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./.;
          file = "./p10k/.p10k.zsh";
        }
      ];
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "brew" ];
      };
      shellAliases = {
        cd = "z";
        find = "fzf";
        lsa = "ls -1a";
        cat = "bat";
        ccat = "bat --plain";
        emacs = "emacs -nw";
      };
      initContent = ''
        eval "$(zoxide init zsh)"
        bindkey "^[[1;3C" forward-word
        bindkey "^[[1;3D" backward-word
        bindkey "^[[1;9C" end-of-line
        bindkey "^[[1;9D" beginning-of-line
      '';
    };
    aerospace = {
      enable = true;
      userSettings = {
        start-at-login = true;
        gaps = {
          inner = {
            horizontal = 4;
            vertical = 4;
          };
          outer = {
            left = 4;
            bottom = 4;
            top = 4;
            right = 4;
          };
        };
        mode.main.binding = {
          alt-tab = "workspace-back-and-forth";

          # Layout commands
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";

          # Focus commands
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          # Move commands
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          # Resize commands
          alt-minus = "resize smart -50";
          alt-equal = "resize smart +50";

          # Workspace switching
          cmd-1 = "workspace 1";
          cmd-2 = "workspace 2";
          cmd-3 = "workspace 3";
          cmd-4 = "workspace 4";
          cmd-5 = "workspace 5";
          cmd-6 = "workspace 6";
          cmd-7 = "workspace 7";
          cmd-8 = "workspace 8";
          cmd-9 = "workspace 9";

          # Move node to workspace
          cmd-alt-1 = "move-node-to-workspace 1";
          cmd-alt-2 = "move-node-to-workspace 2";
          cmd-alt-3 = "move-node-to-workspace 3";
          cmd-alt-4 = "move-node-to-workspace 4";
          cmd-alt-5 = "move-node-to-workspace 5";
          cmd-alt-6 = "move-node-to-workspace 6";
          cmd-alt-7 = "move-node-to-workspace 7";
          cmd-alt-8 = "move-node-to-workspace 8";
          cmd-alt-9 = "move-node-to-workspace 9";

          # Move workspace to monitor
          cmd-alt-tab = "move-workspace-to-monitor --wrap-around next";

          # Mode switching
          alt-shift-semicolon = "mode service";
        };
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    kitty = {
      enable = true;
      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      themeFile = "dracula";
      settings = {
        hide_window_decorations = "titlebar-only";
        window_margin_width = "8";

        font_size = "13";
        font_family = "Iosevka";
        bold_font = "Iosevka Bold";
        italic_font = "Iosevka Italic";
        bold_italic_font = "Iosevka Bold Italic";

        cursor_trail = 10;
        cursor_trail_start_threshold = 0;
        cursor_trail_decay = "0.01 0.05";
        cursor_shape = "block";
        cursor_blink = true;
      };
    };
    zed-editor = {
      enable = true;
      userKeymaps = [
        {
          "bindings" = {
            "cmd-shift-e" = "workspace::ToggleBottomDock";
            "cmd-shift-j" = "project_panel::ToggleFocus";
            "cmd-shift-k" = "agent::ToggleFocus";
            "cmd-shift-l" = "workspace::ToggleRightDock";
            "cmd-shift-a" = "pane::ActivatePreviousItem";
            "cmd-shift-d" = "pane::ActivateNextItem";
            "cmd-shift-w" = "pane::CloseActiveItem";
          };
        }
        {
          "context" = "Editor";
          "bindings" = {
            "cmd-i" = "editor::MoveLineUp";
            "cmd-k" = "editor::MoveLineDown";
            "cmd-up" = "editor::MoveLineUp";
            "cmd-down" = "editor::MoveLineDown";
          };
        }
      ];
      userSettings = {
        vim_mode = true;
        "autosave" = "on_focus_change";
        "restore_on_startup" = "last_workspace";
        "base_keymap" = "VSCode";
        "use_smartcase_search" = true;
        "show_wrap_guides" = true;
        "auto_signature_help" = true;
        "diagnostics" = {
          "inline" = {
            "enabled" = true;
            "update_debounce_ms" = 150;
            "padding" = 4;
            "min_column" = 0;
            "max_severity" = null;
          };
        };
        "inlay_hints" = {
          "enabled" = true;
          "show_type_hints" = true;
          "show_parameter_hints" = true;
          "show_other_hints" = true;
          "show_background" = false;
          "edit_debounce_ms" = 700;
          "scroll_debounce_ms" = 50;
          "toggle_on_modifiers_press" = null;
        };
        "terminal" = {
          "dock" = "bottom";
          "cursor_shape" = "bar";
          "blinking" = "on";
          "toolbar" = {
            "breadcrumbs" = false;
          };
          "button" = false;
        };
        "agent" = {
          "default_profile" = "ask";
          "always_allow_tool_actions" = true;
          "dock" = "right";
          "model_parameters" = [ ];
          "default_model" = {
            "provider" = "copilot_chat";
            "model" = "claude-sonnet-4";
          };
        };
        "edit_predictions" = {
          "mode" = "subtle";
          "copilot" = {
            "proxy" = null;
            "proxy_no_verify" = null;
          };
          "enabled_in_text_threads" = false;
        };
        "toolbar" = {
          "selections_menu" = false;
          "quick_actions" = false;
        };
        telemetry = {
          metrics = false;
          diagnostics = false;
        };
        "ui_font_size" = 14;
        "buffer_font_size" = 14;
        theme = {
          mode = "system";
          light = "One Light";
          dark = "Catppuccin Mocha";
        };
        "collaboration_panel" = {
          dock = "right";
          button = false;
        };
        "outline_panel" = {
          dock = "right";
          button = false;
        };
        "git_panel" = {
          dock = "right";
          button = false;
        };
        "project_panel" = {
          dock = "right";
        };
        "notification_panel" = {
          button = false;
        };
      };
      extensions = [
        "html"
        "catpuccin"
        "dockerfile"
        "scss"
        "astro"
        "golangci-lint"
      ];
    };
  };
}
