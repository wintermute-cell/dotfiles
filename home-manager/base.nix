{ pkgs, config, ... }:
let
  # NOTE: this is used as a crutch since flake based home-manager cannot do
  # direct writable symlinks of config files when using mkOutOfStoreSymlink
  # with a relative path. Therefore we need to use the absolute path for the
  # link source. To stay consistent, this is centrally defined as `dotfilesDirectory`.
  # see: https://github.com/nix-community/home-manager/issues/3514
  dotfilesDirectory = "/etc/dotfiles";
in {
  news.display = "silent";

  programs.home-manager.enable = true;

  manual.json.enable = true; # required for manix fix from https://github.com/nix-community/manix/issues/18

  # required to autoload fonts from packages installed via Home Manager
  fonts.fontconfig.enable = true;

  # gtk = {
  #   enable = true;
  #   cursorTheme = {
  #     name = "plan9";
  #     package = (pkgs.callPackage ../nix-packages/xcursor-plan9/default.nix {});
  #   };
  # };

  home.pointerCursor = {
    gtk.enable = true;  # this was supposed to fix wrong cursor in firefox but oh well...
    x11.enable = true;
    name = "plan9";
    package = (pkgs.callPackage ../nix-packages/xcursor-plan9/default.nix {});
    # size = 28;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let 
      browser = "firefox.desktop";
      imageViewer = "nsxiv.desktop";
      videoPlayer = "mpv.desktop";
      audioPlayer = "vlc.desktop";
      # pdfViewer = "org.pwmt.zathura.desktop";
      pdfViewer = "sioyek.desktop";
    in {
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/xhtml+xml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
      "application/json" = browser;
      "application/pdf" = pdfViewer;
      "application/epub+zip" = pdfViewer;
      "text/plain" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";
      "text/x-markdown" = "nvim.desktop";
      "x-scheme-handler/mailto" = "thunderbird.desktop";
      "image/bmp" = imageViewer;
      "image/gif" = imageViewer; 
      "image/jpeg" = imageViewer;
      "image/jpg" = imageViewer;
      "image/png" = imageViewer;
      "image/svg+xml" = imageViewer;
      "image/tiff" = imageViewer;
      "image/vnd.microsoft.icon" = imageViewer;
      "image/webp" = imageViewer;
      "video/mp2t" = videoPlayer;
      "video/mp4" = videoPlayer;
      "video/mpeg" = videoPlayer;
      "video/ogg" = videoPlayer;
      "video/webm" = videoPlayer;
      "video/x-flv" = videoPlayer;
      "video/x-matroska" = videoPlayer;
      "video/x-msvideo" = videoPlayer;
      "audio/aac" = audioPlayer;
      "audio/mpeg" = audioPlayer;
      "audio/ogg" = audioPlayer;
      "audio/opus" = audioPlayer;
      "audio/wav" = audioPlayer;
      "audio/webm" = audioPlayer;
      "audio/x-matroska" = audioPlayer;
      "all/all" = "pcmanfm.desktop";
      "inode/directory" = "pcmanfm.desktop";
    };
  };

  home.packages = with pkgs; [
    # meta
    nix-search-cli
    comma
    manix

    # base system stuff
    zip
    unzip
    dtrx # extraction multitool (Do The Right Extraction)
    nvtopPackages.full
    trashy # safer alternative to rm, moves to xdg trash
    (callPackage ../nix-packages/barster/default.nix {})

    # base dev stuff, often a dependency for other progs
    gcc
    git
    file
    wget
    curl
    gnumake
    jq # json formatter
    perl
    cmake
    openssl
    killall
    pstree # process tree, useful for low level debugging
    cargo
    rustc
    libnotify
    tree
    sshfs # mounting remote filesystems
    mtpfs # mounting android phones (and kindle devices!)
    awscli2
    plan9port
    pkg-config
    btop
    glances
    fzf
    xterm
    edwood
    wio
    dash
    bc
    dbeaver-bin
    xorg.xkeyboardconfig # just to have the man pages

    # networking stuff
    nmap
    netcat
    tcpdump

    # python packages
    (python311.withPackages (ps: with ps; [ # this is the python install. add all library packages here
      i3ipc 
      packaging
      pandas
      networkx
      matplotlib
      scipy
      pywayland
      evdev
    ]))
    uv

    python312Packages.pip

    # runtimes, envs, etc.
    nodejs
    #python3
    go
    graphviz # required for viewing pprof files
    delve # go debugger
    docker
    sqlite
    elixir
    lua
    jdk  # ltex-ls requires java

    # fonts
    fontpreview # pretty bad UX, only works from terminal; but works on NixOS, font-manager does not
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    sarasa-gothic
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    mononoki
    terminus_font
    # creep
    cozette
    # tamzen

    # neovim and its deps
    unstable.neovim
    stylua  # external prog, used for formatting lua code
    ripgrep
    tree-sitter # the latex plugin needs this to be a PATH executable
    neovide
    neovim-remote

    # user progs
    thunderbird
    alacritty
    wezterm
    tmux
    unstable.zellij
    lazygit
    bottom  # system monitor like htop
    zathura
    sioyek
    nsxiv
    dust # du but better UX
    # ncdu # ncurses du
    dua # ncdu but better and faster
    mpv
    unstable.signal-desktop
    discord
    pcmanfm
    aseprite
    fastfetch
    teamspeak_client
    pavucontrol
    chafa  # image/gif to textmode art cli tool
    # (callPackage ../nix-packages/streamrip/streamrip.nix {})
    streamrip
    (gimp-with-plugins.override {
      plugins = with gimpPlugins; [
        gmic
      ];
    })
    libnotify
    tldr
    shotwell
    mpd
    # cantata # mpd client / music player # NOTE: compilation broken on latest unstable 18.10.24
    obsidian
    anki-bin
    bruno # API IDE like Postman
    wf-recorder # wayland screen recorder
    sway-contrib.grimshot # sway screenshot helper
    hyprpicker # color picker
    # mnemosyne # NOTE: compilation broken on latest unstable 18.10.24
    xournalpp
    adwaita-icon-theme # required by xournalpp
    wl-mirror
    # (callPackage ../nix-packages/timetrace/default.nix {}) # replaced by watson
    figlet
    obs-studio
    (callPackage ../nix-packages/pureref/default.nix {})
    ffmpeg
    pandoc
    (texliveFull.withPackages (ps: with ps; [
      courier
    ]))
    liberation_ttf_v1 # some basic fonts
    unstable.prusa-slicer
    # jetbrains.goland
    # jetbrains.clion
    vlc
    avizo
    kitty
    unstable.ghostty
    playerctl
    j4-dmenu-desktop
    bemenu
    qimgv
    yt-dlp
    rx # vim like pixelart program
    lazydocker
    # libreoffice
    (callPackage ../nix-packages/dam/default.nix {})
    go-task
    typora
    unstable.aider-chat
    unstable.feishin # navidrome client
    (callPackage ../nix-packages/markdown-flashcards/default.nix {})
    nyxt
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        browser = "firefox -new-tab";
        dmenu = "fuzzel";
        follow = "mouse";
        font = "Droid Sans 10";
        format = ''
            %a
            <b>%s</b>
            %b'';
        frame_color = "#555555";
        frame_width = 2;
        geometry = "500x5-5+30";
        horizontal_padding = 8;
        icon_position = "off";
        line_height = 0;
        markup = "full";
        padding = 8;
        separator_color = "frame";
        separator_height = 2;
        transparency = 10;
        word_wrap = true;
      };

      urgency_low = {
        background = "#1d1f21";
        foreground = "#4da1af";
        frame_color = "#4da1af";
        timeout = 10;
      };

      urgency_normal = {
        background = "#1d1f21";
        foreground = "#70a040";
        frame_color = "#70a040";
        timeout = 15;
      };

      urgency_critical = {
        background = "#1d1f21";
        foreground = "#dd5633";
        frame_color = "#dd5633";
        timeout = 0;
      };

      shortcuts = {
        context = "mod4+grave";
        close = "mod4+shift+space";
      };
    };
  };

  # udiskie
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
  };

  # firefox
  programs.firefox = {
    enable = true;
    profiles."winterveil" = {
      isDefault = true;
      settings = {
        "browser.compactmode.show" = true;
        "general.autoScroll" = true;
        "browser.toolbars.bookmarks.visibility" = "always";
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        kagi-search
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
        darkreader
      ];
    };
  };

  # nix-index
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    # enableFishIntegration = true; # doesnt work if fish is not managed by home-manager
  };

  home.file = {
    # zellij
    "${config.home.homeDirectory}/scripts" = {
      source = ../scripts;
      recursive = false;
    };

    # nvim
    "${config.xdg.configHome}/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDirectory}/nvim";

    # git
    "${config.xdg.configHome}/git" = {
      source = ../git;
      recursive = false;
    };

    # fish
    # "${config.xdg.configHome}/fish" = {
    #   source = ../fish;
    #   recursive = false;
    # };
    "${config.xdg.configHome}/fish".source = # fish requires .config/fish/fish_variables to be writable
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDirectory}/fish";

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

    # wezterm
    "${config.xdg.configHome}/wezterm" = {
      source = ../wezterm;
      recursive = false;
    };

    # tmux
    "${config.xdg.configHome}/tmux" = {
      source = ../tmux;
      recursive = false;
    };

    "${config.xdg.configHome}/nixos_generated/tmux_fish.conf" = {
      text = ''
        # integrate fish shell into tmux
        set-option -g default-shell "${pkgs.fish}/bin/fish"
      '';
    };

    "${config.xdg.configHome}/nixos_generated/fish_nix_index.fish" = 
      let
        wrapper = pkgs.writeScript "command-not-found" ''
          #!${pkgs.bash}/bin/bash
          source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
          command_not_found_handle "$@"
        '';
      in {
      text = ''
        # integrate nix-index's command-not-found into fish
        function fish_command_not_found
          ${wrapper} $argv
        end
      '';
    };

    # waybar
    "${config.xdg.configHome}/waybar" = {
      source = ../waybar;
      recursive = false;
    };

    # sioyek
    "${config.xdg.configHome}/sioyek" = {
      source = ../sioyek;
      recursive = false;
    };

    # zathura
    "${config.xdg.configHome}/zathura" = {
      source = ../zathura;
      recursive = false;
    };

    # fuzzel
    "${config.xdg.configHome}/fuzzel" = {
      source = ../fuzzel;
      recursive = false;
    };

    # mpd
    "${config.xdg.configHome}/mpd" = {
      source = ../mpd;
      recursive = false;
    };

    # streamrip
    "${config.xdg.configHome}/streamrip" = {
      source = ../streamrip;
      recursive = false;
    };

    # wob
    "${config.xdg.configHome}/wob" = {
      source = ../wob;
      recursive = false;
    };

    # ssh
    "${config.home.homeDirectory}/.ssh/config" = {
      source = ../ssh/config;
      recursive = false;
    };

    # ghostty
    "${config.xdg.configHome}/ghostty" = {
      source = ../ghostty;
      recursive = false;
    };

    # river
    "${config.xdg.configHome}/river" = {
      source = ../river;
      recursive = false;
    };

    # zellij
    "${config.xdg.configHome}/zellij" = {
      source = ../zellij;
      recursive = false;
    };

  };
}
