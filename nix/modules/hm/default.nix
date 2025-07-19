{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [];

  home = {
    stateVersion = "25.05";
    username = "ryan";
    packages = with pkgs; [
      devenv
      nix-inspect
      zsh-powerlevel10k
      ollama
      obsidian
      highlight
      gh
      zellij
      yazi
      ttyd
      lazydocker
      lazygit
      docker
      fd
      wget
      aerospace
      # NEOVIM UNDER!
      neovim
      ripgrep
      lua5_1
      luarocks
      lua-language-server
      stylua
    ];

    sessionVariables = {
        EDITOR = "nvim";
    };
  };

  manual = {
    manpages.enable = true;
    html.enable = true;
    json.enable = true;
  };

  services = {
    home-manager = {};
  };

  programs = {
    home-manager.enable = true;
    zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        oh-my-zsh = {
            enable = true;
            plugins = ["git" "brew"];
            theme = "powerlevel10k/powerlevel10k";
            custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
        };
        shellAliases = {
            vi = "nvim";
            vim = "nvim";
            cd = "z";
            find = "fzf";
            lsa = "ls -1a";
            ccat = "highlight -0 ansi --force";
            "sudo-nix-build" = "~/ryangchung/install.sh";
        };
        initContent = ''
            eval "$(zoxide init zsh)"
            bindkey "^[[1;3C" forward-word
            bindkey "^[[1;3D" backward-word
            bindkey "^[[1;9C" end-of-line
            bindkey "^[[1;9D" beginning-of-line
            source ~/.p10k.zsh
        '';
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
          "model_parameters" = [];
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
