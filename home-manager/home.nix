{ pkgs, config, ... }: {

  imports = [ ../overlays ];

  programs.home-manager.enable = true;

  # required to autoload fonts from packages installed via Home Manager
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      name = "plan9";
      package = (pkgs.callPackage ../nix-packages/xcursor-plan9/default.nix {});
    };
  };

  home.packages = with pkgs; [
    # meta
    nix-search-cli

    # base system stuff, why is this not in the base system?
    zip
    unzip
    trashy # safer alternative to rm, moves to xdg trash

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
    killall
    pstree # process tree, useful for low level debugging
    cargo
    rustc
    libnotify
    go-task
    tree
    sshfs # mounting remote filesystems
    awscli2
    plan9port

    # networking stuff
    nmap
    netcat
    tcpdump

    # python packages
    (python311.withPackages (ps: with ps; [ # this is the python install. add all library packages here
      i3ipc 
      packaging
      pandas
      plotly
      dash
    ]))

    python312Packages.pip

    # runtimes, envs, etc.
    nodejs
    #python3
    go
    delve # go debugger
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
    ripgrep

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
    (gimp-with-plugins.override {
      plugins = with gimpPlugins; [
        gmic
      ];
    })
    libnotify
    tldr
    shotwell
    mpd
    cantata # mpd client / music player
    obsidian
    bruno # API IDE like Postman
    wf-recorder # wayland screen recorder
    sway-contrib.grimshot # sway screenshot helper
    mnemosyne
    xournalpp
    gnome.adwaita-icon-theme # required by xournalpp
    wl-mirror
    # (callPackage ../nix-packages/timetrace/default.nix {}) # replaced by watson
    figlet
    obs-studio
    (callPackage ../nix-packages/pureref/default.nix {})
    ffmpeg
    reaper

  ];

  # watson
  programs.watson = {
    enable = true;
    enableZshIntegration = true;
    settings.options = {
      pager = false;
      date_format = "%d.%m.%Y";
    };
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
        darkreader
      ];
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    #dotDir = "${config.xdg.configHome}/zsh";
    history = {
      extended = true;
      path = "${config.xdg.stateHome}/zsh/.history";
      size = 10000;
      save = 10000;
      share = true;

    };

    initExtraBeforeCompInit = ''
      fpath+=("${config.home.profileDirectory}"/share/zsh/site-functions "${config.home.profileDirectory}"/share/zsh/$ZSH_VERSION/functions "${config.home.profileDirectory}"/share/zsh/vendor-completions)
    '';

    initExtra = ''
      setopt appendhistory
      
      # immediately add to history
      setopt INC_APPEND_HISTORY
      
      # timestamp for history entries
      export HISTTIMEFORMAT="[%F %T] "
      setopt EXTENDED_HISTORY
      
      setopt extendedglob nomatch # extended globbing
      unsetopt beep autocd # no bell, no autocd
      bindkey -v # vi mode
      
      # custom prompt
      setopt prompt_subst # reeval prompt every time it is printed
      git_prompt() {
        BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
      
        if [ ! -z $BRANCH ]; then
          echo -n "[$BRANCH"
          if [ ! -z "$(git status --short)" ]; then
            echo -n "+"
          fi
          echo -n "]"
        fi
      }

      dev_shell_prompt() {
        if [ -n "$IN_DEV_SHELL" ]; then
          echo "[DEV]"
        fi
      }
      
      #PS1='%2~ $(git_prompt)%# '
      PS1='$(dev_shell_prompt) %2~ $(git_prompt)%# '
      
      # Change cursor shape for different vi modes.
      function zle-keymap-select {
        if [[ $KEYMAP == vicmd ]] ||
           [[ $1 = 'block' ]]; then
          echo -ne '\e[1 q'
        elif [[ $KEYMAP == main ]] ||
             [[ $KEYMAP == viins ]] ||
             [[ $KEYMAP = "" ]] ||
             [[ $1 = 'beam' ]]; then
          echo -ne '\e[5 q'
        fi
      }
      zle -N zle-keymap-select
      zle-line-init() {
          zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
          echo -ne "\e[5 q"
      }
      zle -N zle-line-init
      echo -ne '\e[5 q' # Use beam shape cursor on startup.
      preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
      # enable reverse search
      bindkey '^R' history-incremental-search-backward
      
      bindkey '^n' expand-or-complete
      bindkey '^p' reverse-menu-complete
      
      # Edit line in vim with ctrl-e:
      autoload edit-command-line; zle -N edit-command-line
      bindkey '^E' edit-command-line
      bindkey '^[L' autosuggest-accept
    '';

    envExtra = ''
      export TERM="xterm-256color" # some programs/systems don't recognize 'alacritty', so use xterm-256color
      export VISUAL="nvim"
      if [[ -n $SSH_CONNECTION ]]; then
          export EDITOR="vim"
      else
          export EDITOR=$VISUAL
      fi
      
      # $PATH
      #export PATH="/home/wintermute/.local/bin:/usr/bin:$PATH"
      #export PATH="$(go env GOBIN):$(go env GOPATH)/bin:$PATH"
      
      # xdg
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_CACHE_HOME="$HOME/.cache"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_STATE_HOME="$HOME/.local/state"
      
      # wayland specific
      #export LD_LIBRARY_PATH="/home/wintermute/src/bemenu"
      #export BEMENU_RENDERERS="/home/wintermute/src/bemenu"
      export MOZ_ENABLE_WAYLAND=1
      
      # theme
      # export THEME_MODE="flowver"
      export THEME_MODE="monotone"
      export XCURSOR_SIZE=20
      export XCURSOR_THEME=plan9
      
      # other
      #export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
      
      # cleanup
      export GNUPGHOME="$XDG_DATA_HOME"/gnupg
      export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
      export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
      export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
      export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
      export TEXMFHOME="$XDG_CONFIG_HOME/texmf"
      
      # cargo (compatibility with gitconfigs insteadOf)
      export CARGO_NET_GIT_FETCH_WITH_CLI=true
    '';

    shellAliases = {
      # aliases
      "v"               = "nvim";
      "rm"              = "rm -I";
      "py"              = "python";
      "n"               = "nnn -edDgx";
      ",ide"            = "${config.home.homeDirectory}/scripts/ide.sh";
      ",vide"           = "${config.home.homeDirectory}/scripts/vide.sh";
      ",staticsrv"      = "go run ${config.home.homeDirectory}/scripts/staticwebserver.go";
      ",newtask"        = "${config.home.homeDirectory}/scripts/new_task.sh";
      "t"               = "task"; # careful, setting this to go-task will break completion, as completion expects "task"
      "del"             = "trashy put";
      ",nix-switch-hm"  = "${config.home.homeDirectory}/scripts/nixos/home_manager_switch.sh";
      ",nix-switch-os"  = "${config.home.homeDirectory}/scripts/nixos/nixos_switch.sh";
      ",ws"             = "watson start";
      ",wstop"          = "watson stop";
      ",wclock"         = "watch -n 5 \"watson status | sed 's/^.*started \\(.*\\) ago (.*$/\\1/' | figlet\"
";
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
    #"${config.home.homeDirectory}/.zshrc" = {
    #  source = ../zsh/.zshrc;
    #  recursive = false;
    #};

    # zshenv
    #"${config.home.homeDirectory}/.zshenv" = {
    #  source = ../zsh/.zshenv;
    #  recursive = false;
    #};

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

    # aseprite
    #"${config.xdg.configHome}/aseprite" = {
    #  source = ../aseprite;
    #  recursive = false;
    #};

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

  };
}
