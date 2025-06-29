{ pkgs, config, lib, ... }:
let
  dotfilesDirectory = "/etc/dotfiles";
in {
  home.file = { };

  home.packages = with pkgs; [
    libation
    reaper
    steam-run
    milkytracker
  ];
}
