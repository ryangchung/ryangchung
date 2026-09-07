{ config, ... }:
let
  piSourceRoot = "${config.home.homeDirectory}/ryangchung/pi/agent";
  rtkSourceRoot = "${config.home.homeDirectory}/ryangchung/pi/rtk";
  linkFromPiRepository = relativePath:
    config.lib.file.mkOutOfStoreSymlink "${piSourceRoot}/${relativePath}";
  linkFromRtkRepository = relativePath:
    config.lib.file.mkOutOfStoreSymlink "${rtkSourceRoot}/${relativePath}";
in
{
  home.file = {
    ".pi-lens/config.json".text = builtins.toJSON {
      widget.visible = false;
    };

    ".pi/agent/AGENTS.md".source = linkFromPiRepository "AGENTS.md";
    ".pi/agent/settings.json".source = linkFromPiRepository "settings.json";

    ".pi/agent/agents/scout.md".source = linkFromPiRepository "agents/scout.md";
    ".pi/agent/agents/researcher.md".source = linkFromPiRepository "agents/researcher.md";
    ".pi/agent/agents/worker.md".source = linkFromPiRepository "agents/worker.md";

    ".pi/agent/extensions/git-safety.js".source =
      linkFromPiRepository "extensions/git-safety.js";
    ".pi/agent/extensions/rtk.ts".source =
      linkFromPiRepository "extensions/rtk.ts";
    ".pi/agent/extensions/usage-footer.js".source =
      linkFromPiRepository "extensions/usage-footer.js";
    ".pi/agent/extensions/subagent/config.json".source =
      linkFromPiRepository "extensions/subagent/config.json";

    "Library/Application Support/rtk/config.toml".source =
      linkFromRtkRepository "config.toml";
  };
}
