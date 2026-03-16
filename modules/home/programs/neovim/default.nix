{ pkgs
, ...
}:

{
  # programs = {
  #   neovim = {
  #     enable = false;
  #     defaultEditor = false1;
  #     viAlias = false;
  #     vimAlias = false;
  #     withRuby = true;
  #     withNodeJs = true;
  #     withPython3 = true;
  #     plugins = with pkgs.vimPlugins; [
  #       lazy-nvim
  #     ];
  #   };
  # };

  # home = {
  #   file = {
  #     ".config/nvim/init.lua" = {
  #       enable = true;
  #       text = ''
  #         -- bootstrap lazy.nvim and your plugins
  #         require("config.keymaps")
  #         require("config.options")
  #         require("config.lazy")
  #       '';
  #     };
  #     # ".config/nvim/lua/plugins" = {
  #     #   enable = true;
  #     #   source = ./plugins;
  #     #   recursive = true;
  #     # };
  #     ".config/nvim/lua/config" = {
  #       enable = true;
  #       source = ./config;
  #       recursive = true;
  #     };
  #     # ".config/nvim/lazyvim.json" = {
  #     #   enable = true;
  #     #   source = ./lazyvim.json;
  #     # };
  #     # ".config/nvim/.neoconf.json" = {
  #     #   enable = true;
  #     #   text = ''
  #     #     {
  #     #       "neodev": {
  #     #         "library": {
  #     #           "enabled": true,
  #     #           "plugins": true
  #     #         }
  #     #       },
  #     #       "neoconf": {
  #     #         "plugins": {
  #     #           "lua_ls": {
  #     #             "enabled": true
  #     #           }
  #     #         }
  #     #       }
  #     #     }
  #     #   '';
  #     # };
  #     # ".config/nvim/stylua.toml" = {
  #     #   enable = true;
  #     #   text = ''
  #     #     indent_width = 2
  #     #     column_width = 120
  #     #     indent_type = "Spaces"
  #     #   '';
  #     # };
  #   };
  # };
}
