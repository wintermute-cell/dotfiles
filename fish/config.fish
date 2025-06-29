if status is-interactive
    # =========================
    # =         MISC          =
    # =========================

    # Disable the greeting message
    set -g fish_greeting

    # Load nix-index integration
    source "$HOME/.config/nixos_generated/fish_nix_index.fish"

    # =========================
    # =     VI MODE FIXES     =
    # =========================
    # This seems to be necessary for the cursors to work in wezterm (and possibly tmux)
    set -g fish_vi_force_cursor 1

    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block

    # Set the insert mode cursor to a line
    set fish_cursor_insert line

    # Set the replace mode cursors to an underscore
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore

    # Set the external cursor to a line. The external cursor appears when a command is started.
    # The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
    set fish_cursor_external line

    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block

    # =========================
    # = ENVIRONMENT VARIABLES =
    # =========================

    # Editor configuration
    set -xg VISUAL "nvim"
    if test -n "$SSH_CONNECTION"
        set -xg EDITOR "vim"
    else
        set -xg EDITOR $VISUAL
    end

    # Theme configuration
    set -xg THEME_MODE "monotone"
    set -xg XCURSOR_SIZE 20
    set -xg XCURSOR_THEME "plan9"

    # Other variables
    # set -xg GNUPGHOME "$XDG_DATA_HOME/gnupg"
    # set -xg GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
    # set -xg XCURSOR_PATH "/usr/share/icons:$XDG_DATA_HOME/icons"
    # set -xg LESSHISTFILE "$XDG_CACHE_HOME/less/history"
    # set -xg XINITRC "$XDG_CONFIG_HOME/X11/xinitrc"
    # set -xg TEXMFHOME "$XDG_CONFIG_HOME/texmf"

    # Cargo configuration (compatibility with gitconfigs insteadOf)
    set -xg CARGO_NET_GIT_FETCH_WITH_CLI true

    # Taskfile
    set -xg TASK_X_ENV_PRECEDENCE 1

    # Use nvim as manpage client
    set -xg MANPAGER 'nvim -c "Man!"'

    # Non versioned private variables
    source "$HOME/.env.fish"

    # =========================
    # =       ALIASES         =
    # =========================
    # Define functions and save them

    alias ,staticsrv "go run $HOME/scripts/staticwebserver.go"
    alias ,newtask "$HOME/scripts/new_task.sh"
    alias ,newflake "$HOME/scripts/new_flake.sh"
    alias del "trashy put"
    alias ,nix-switch-hm "/etc/dotfiles/home_manager_switch.sh"
    alias ,nix-switch-os "/etc/dotfiles/nixos_switch.sh"
    alias ,prime-run "$HOME/scripts/prime-run.sh"
    alias ,walls "qimgv /home/winterveil/Pictures/wallpapers"
    # alias remi "/home/winterveil/src/remi/remi"
    alias ,git-reignore "$HOME/scripts/git_reignore.sh"
    alias lg "lazygit"
    alias ze "zellij"

    # if test -z "$REMI_DISABLE"
    #     /home/winterveil/src/remi/remi
    # end

    zoxide init fish | source
end
