    {
programs.aerospace = {
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
  }
