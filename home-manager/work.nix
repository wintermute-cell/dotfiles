{ pkgs, config, lib, ... }:
let
  dotfilesDirectory = "/etc/dotfiles";
in {
  home.file = {
    # git
    "${config.xdg.configHome}/git" = lib.mkForce {
      source = ../work/git;
      recursive = false;
    };

    # ssh
    "${config.home.homeDirectory}/.ssh/config" = lib.mkForce {
      source = ../work/ssh/config;
      recursive = false;
    };
  };

  home.packages = with pkgs; [
    yarn
    dbeaver-bin
  ];
}
