{ pkgs, config, ... }: {

  programs.home-manager.enable = true;

  # required to autoload fonts from packages installed via Home Manager
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # meta
    nix-search-cli

    # base dev stuff, often a dependency for other progs
    gcc
    git
    wget
    curl
    gnumake
    jq # json formatter
    perl
    cmake
    openssl
    zsh
    killall
    pstree # process tree, useful for low level debugging
    cargo
    rustc
    libnotify

    # python packages
    (python311.withPackages (ps: with ps; [ # this is the python install. add all library packages here
      i3ipc 
    ]))

    python312Packages.pip

    # runtimes, envs, etc.
    nodejs
    #python3
    go
    docker
    sqlite
    elixir
    lua

    # fonts
    fontpreview # pretty bad UX, only works from terminal; but works on NixOS, font-manager does not
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; })
    sarasa-gothic
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    # neovim and its deps
    neovim
    stylua  # external prog, used for formatting lua code

    # user progs
    firefox
    thunderbird
    alacritty
    wezterm
    tmux
    lazygit
    bottom  # system monitor like htop
    zathura
    nsxiv
    dust # du but better UX
    mpv
    signal-desktop
    discord
    pcmanfm
    aseprite
    neofetch
    teamspeak_client
    pavucontrol
    chafa  # image/gif to textmode art cli tool
    (callPackage ../nix-packages/streamrip/streamrip.nix {})
    gimp
    libnotify
    tldr
    shotwell
    mpd
    cantata # mpd client / music player
    obsidian
    bruno # API IDE like Postman
    wf-recorder # wayland screen recorder
    sway-contrib.grimshot # sway screenshot helper

  ];

  # firefox
  programs.firefox = {
    enable = true;
    profiles."winterveil" = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        tridactyl
        bitwarden
        sponsorblock
        clearurls
        consent-o-matic # auto cookie popup solver
        dearrow # youtube de-clickbaiting
        localcdn # intercepts CDN requests and tries to use local cache
        onetab
        privacy-badger # tracker blocker
        return-youtube-dislikes
        streetpass-for-mastodon
        ublock-origin
        youtube-nonstop
        translate-web-pages
      ];
    };
  };

  home.file = {
    # nvim / neovim
    "${config.xdg.configHome}/nvim" = {
      source = ../nvim;
      recursive = false;
    };

    # git
    "${config.xdg.configHome}/git" = {
      source = ../git;
      recursive = false;
    };

    # zshrc
    "${config.home.homeDirectory}/.zshrc" = {
      source = ../zsh/.zshrc;
      recursive = false;
    };

    # zshenv
    "${config.home.homeDirectory}/.zshenv" = {
      source = ../zsh/.zshenv;
      recursive = false;
    };

    # sway
    "${config.xdg.configHome}/sway" = {
      source = ../sway;
      recursive = false;
    };

    # alacritty
    "${config.xdg.configHome}/alacritty" = {
      source = ../alacritty;
      recursive = false;
    };

    # tmux
    "${config.xdg.configHome}/tmux" = {
      source = ../tmux;
      recursive = false;
    };

    # waybar
    "${config.xdg.configHome}/waybar" = {
      source = ../waybar;
      recursive = false;
    };

    # zathura
    "${config.xdg.configHome}/zathura" = {
      source = ../zathura;
      recursive = false;
    };

  };
}
