{
  programs.zed-editor = {
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
      "debugger" = {
        "button" = false;
      };
      "auto_install_extensions" = {
        "astro" = true;
        "basher" = true;
        "catppuccin" = true;
        "csv" = true;
        "docker-compose" = true;
        "dockerfile" = true;
        "git-firefly" = true;
        "golangci-lint" = true;
        "graphql" = true;
        "html" = true;
        "latex" = true;
        "lua" = true;
        "nginx" = true;
        "nix" = true;
        "ruby" = true;
        "scss" = true;
        "solidity" = true;
        "sql" = true;
        "stylint" = true;
        "svelte" = true;
        "toml" = true;
        "unocss" = true;
        "vue" = true;
      };
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
        "button" = false;
        "tool_permissions" = {
          "default" = "allow";
        };
        "default_model" = {
          "model" = "claude-sonnet-4";
          "provider" = "copilot_chat";
        };
        "default_profile" = "ask";
        "dock" = "right";
        "model_parameters" = [ ];
      };
      "edit_predictions" = {
        "copilot" = {
          "proxy" = null;
          "proxy_no_verify" = null;
        };
        "enabled_in_text_threads" = false;
        "mode" = "subtle";
      };
      "toolbar" = {
        "selections_menu" = false;
        "quick_actions" = false;
      };
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      "ui_font_size" = 12;
      "buffer_font_size" = 12;
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
      "notification_panel" = {
        "button" = false;
      };
      "pane_split_direction_vertical" = "left";
      "project_panel" = {
        dock = "right";
      };
    };
    extensions = [
      "astro"
      "basher"
      "catppuccin"
      "csv"
      "docker-compose"
      "dockerfile"
      "git-firefly"
      "golangci-lint"
      "graphql"
      "html"
      "latex"
      "lua"
      "nginx"
      "nix"
      "ruby"
      "scss"
      "solidity"
      "sql"
      "stylint"
      "svelte"
      "toml"
      "unocss"
      "vue"
    ];
  };
}
