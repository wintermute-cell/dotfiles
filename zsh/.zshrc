# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle :compinstall filename '/home/wintermute/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install


# env variables
export SCRIPTDIR="/home/wintermute/scripts"

# xdg
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# custom
export THEME_MODE="plan9"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# set $PATH
export PATH="/home/wintermute/.local/bin:/usr/bin:$PATH"

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

PS1='%2~ $(git_prompt)%# '

# preferred editor
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# enable reverse search
bindkey '^R' history-incremental-search-backward

# aliases
alias v="nvim"
alias note="nvim -u $XDG_CONFIG_HOME/nvim/notetaker_init.lua"
alias c="$SCRIPTDIR/c.sh"
alias rm="rm -I"
alias py="python"

# cleanup
export GOPATH="/usr/local/go"
export GOROOT="/usr/local/go"
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:${XDG_DATA_HOME}/icons
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
export HISTFILE="$XDG_STATE_HOME"/zsh/history
