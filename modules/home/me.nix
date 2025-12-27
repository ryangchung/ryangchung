{ config, lib, ... }:
{
  config = {
    home.username = config.me.username;
  };

  options = {
    me = {
      email = lib.mkOption {
        description = "Your email for use in Git config";
        type = lib.types.str;
      };

      fullname = lib.mkOption {
        description = "Your full name for use in Git config";
        type = lib.types.str;
      };

      username = lib.mkOption {
        description = "Your username as shown by `id -un`";
        type = lib.types.str;
      };
    };
  };
}
