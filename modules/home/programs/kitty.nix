{ pkgs, ... }:
{
programs.kitty = {
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
}
