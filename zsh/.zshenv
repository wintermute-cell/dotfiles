# default programs
export TERM="alacritty"
export VISUAL="nvim"
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR="vim"
else
    export EDITOR=$VISUAL
fi

# $PATH
export PATH="/home/wintermute/.local/bin:/usr/bin:$PATH"
export PATH="$(go env GOBIN):$(go env GOPATH)/bin:$PATH"

# xdg
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# locations
export SCRIPTDIR="/home/wintermute/scripts"

# wayland specific
export LD_LIBRARY_PATH="/home/wintermute/src/bemenu"
export BEMENU_RENDERERS="/home/wintermute/src/bemenu"
export MOZ_ENABLE_WAYLAND=1

# theme
# export THEME_MODE="flowver"
export THEME_MODE="monotone"
export XCURSOR_SIZE=20
export XCURSOR_THEME=plan9

# other
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# cleanup
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

export TEXMFHOME="$XDG_CONFIG_HOME/texmf"

# gaynet
export DOTNET_ROOT="/usr/lib/dotnet"
export PATH="$PATH:/usr/lib/dotnet"
DOTNET_CLI_TELEMETRY_OPTOUT=1

# cargo (compatibility with gitconfigs insteadOf)
export CARGO_NET_GIT_FETCH_WITH_CLI=true
