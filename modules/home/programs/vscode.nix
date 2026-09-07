{ flake, pkgs, ... }:
let
  marketplace =
    flake.inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
in
{
  programs.vscode = {
    enable = false;

    # The application is installed by Homebrew. Home Manager manages only its
    # user configuration and extensions.
    package = null;

    profiles.default = {
      userSettings = {
        "workbench.sideBar.location" = "right";
        "workbench.navigationControl.enabled" = false;
        "workbench.activityBar.location" = "top";
        "editor.minimap.enabled" = false;
        "workbench.colorTheme" = "Tokyo Night Storm";
        "chat.agentsControl.enabled" = false;
        "workbench.layoutControl.enabled" = false;
        "window.commandCenter" = false;
        "workbench.editor.tabSizing" = "fixed";
        "workbench.editor.tabSizingFixedMaxWidth" = 150;
        "workbench.editor.tabSizingFixedMinWidth" = 150;
        "editor.formatOnSave" = true;
        "files.autoSave" = "onFocusChange";
        "editor.fontFamily" = "iosevka";
        "workbench.iconTheme" = "chalice-icon-theme";
        "github.copilot.enable"."*" = true;
        "github.copilot.nextEditSuggestions.enabled" = true;
        "editor.inlineSuggest.enabled" = true;
        "window.title" = "\${activeEditorShort}";
        "editor.showUnused" = true;
        "breadcrumbs.enabled" = false;
        "workbench.editor.showIcons" = true;
        "workbench.editor.editorActionsLocation" = "hidden";
        "workbench.list.multiSelectModifier" = "alt";
        "editor.gotoLocation.multipleDefinitions" = "goto";
        "gitlens.ai.model" = "vscode";
        "gitlens.ai.vscode.model" = "copilot:gpt-4.1";
      };

      keybindings = [
        {
          key = "cmd+-";
          command = "editor.action.fontZoomOut";
        }
        {
          key = "shift+cmd+-";
          command = "workbench.action.zoomOut";
        }
        {
          key = "cmd+numpad_subtract";
          command = "-workbench.action.zoomOut";
        }
        {
          key = "cmd+=";
          command = "editor.action.fontZoomIn";
        }
        {
          key = "shift+cmd+j";
          command = "workbench.view.explorer";
          when = "viewContainer.workbench.view.explorer.enabled";
        }
        {
          key = "shift+cmd+e";
          command = "-workbench.view.explorer";
          when = "viewContainer.workbench.view.explorer.enabled";
        }
        {
          key = "shift+cmd+j";
          command = "-workbench.action.search.toggleQueryDetails";
          when = "inSearchEditor || searchViewletFocus";
        }
        {
          key = "shift+cmd+k";
          command = "workbench.action.chat.open";
          when = "!chatSetupDisabled && !chatSetupHidden";
        }
        {
          key = "ctrl+cmd+i";
          command = "-workbench.action.chat.open";
          when = "!chatSetupDisabled && !chatSetupHidden";
        }
        {
          key = "shift+cmd+l";
          command = "workbench.action.toggleSidebarVisibility";
          when = "sideBarVisible";
        }
        {
          key = "cmd+w";
          command = "workbench.action.toggleSidebarVisibility";
          when = "sideBarVisible";
        }
        {
          key = "cmd+=";
          command = "-workbench.action.zoomIn";
        }
        {
          key = "cmd+[";
          command = "workbench.action.increaseViewSize";
        }
        {
          key = "cmd+]";
          command = "workbench.action.decreaseViewSize";
        }
        {
          key = "ctrl+shift+]";
          command = "runCommands";
          args.commands = [
            "workbench.action.focusActiveEditorGroup"
            "workbench.action.nextEditor"
          ];
        }
        {
          key = "ctrl+shift+[";
          command = "runCommands";
          args.commands = [
            "workbench.action.focusActiveEditorGroup"
            "workbench.action.previousEditor"
          ];
        }
      ];

      userMcp.servers.Spline = {
        type = "stdio";
        command = "/Applications/Spline.app/Contents/MacOS/Spline";
        args = [ "/Applications/Spline.app/Contents/Resources/spline-mcp.cjs" ];
        env.ELECTRON_RUN_AS_NODE = "1";
      };

      extensions = [
        marketplace.artlaman.chalice-icon-theme
        marketplace.astral-sh.ty
        marketplace.astro-build.astro-vscode
        marketplace.bbenoist.nix
        marketplace.charliermarsh.ruff
        marketplace.enkia.tokyo-night
        marketplace.ms-python.python
        marketplace.ms-toolsai.jupyter
        marketplace.ms-toolsai.jupyter-keymap
        marketplace.ms-toolsai.jupyter-renderers
        marketplace.ms-toolsai.vscode-jupyter-cell-tags
        marketplace.ms-toolsai.vscode-jupyter-slideshow
        marketplace.shd101wyy.markdown-preview-enhanced
        marketplace.tomoki1207.pdf
        marketplace.vscodevim.vim
        marketplace.yzhang.markdown-all-in-one
      ];
    };
  };
}
