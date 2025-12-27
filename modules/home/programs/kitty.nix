{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "dracula";

    settings = {
      cursor_blink = true;
      cursor_shape = "block";
      cursor_trail = 10;
      cursor_trail_decay = "0.01 0.05";
      cursor_trail_start_threshold = 0;

      bold_italic_font = "Iosevka Bold Italic";
      bold_font = "Iosevka Bold";
      font_size = "13";
      font_family = "Iosevka";
      hide_window_decorations = "titlebar-only";
      italic_font = "Iosevka Italic";

      window_margin_width = "8";
    };

    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
