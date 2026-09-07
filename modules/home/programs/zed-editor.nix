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
      "edit_predictions" = {
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
      "project_panel" = {
        dock = "right";
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
}
