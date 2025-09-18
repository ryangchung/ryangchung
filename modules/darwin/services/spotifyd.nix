{ pkgs, ... }:
{
  services.spotifyd = {
    enable = false;
    # settings = {
       # global = {
       #   username = "";
       #   password = "";
       #   device_name = "";
       # };
    # };
  };
}
