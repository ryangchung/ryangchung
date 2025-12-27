{
  programs.eza = {
    enable = true;
    colors = "always";
    enableBashIntegration = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";

    extraOptions = [
      "--classify"
      "--group-directories-first"
      "--git-ignore"
      "--header"
      "--hyperlink"
      "--icons=always"
      "--no-quotes"
    ];
  };
}
