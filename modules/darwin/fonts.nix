{ config
, lib
, pkgs
, ...
}: {
  fonts.packages = with pkgs; [
    iosevka
  ];
}
