# plugins
if [[ ! -d ~/src/zsh-autopair ]]; then
  git clone https://github.com/hlissner/zsh-autopair ~/src/zsh-autopair
fi
source ~/src/zsh-autopair/autopair.zsh
autopair-init

if [[ ! -d ~/src/zsh-syntax ]]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/src/zsh-syntax
fi
source ~/src/zsh-syntax/fast-syntax-highlighting.plugin.zsh

# autocomplete
zstyle ':completion:*' gain_privileges 1
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-/]=** r:|=**' 'l:|=* r:|=*'
# zstyle ':completion:*' menu select=long
zstyle ':completion:*' menu select
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
#zstyle :compinstall filename '/home/li/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
zmodload zsh/complist

# history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="${XDG_STATE_HOME}/zsh/.history"

setopt appendhistory
setopt SHARE_HISTORY

# immediately add to history
setopt INC_APPEND_HISTORY

# timestamp for history entries
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY


setopt extendedglob nomatch
unsetopt beep autocd
bindkey -v

# colors
autoload -U colors && colors

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

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
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

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# enable reverse search
bindkey '^R' history-incremental-search-backward

bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line

# aliases
alias v="nvim"
alias c="$SCRIPTDIR/c.sh"
alias rm="rm -I"
alias py="python"
alias n="nnn -edDgx"
alias ,pckginfo="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias ,whoowns="print -rC1 -- ${(ko)commands} | fzf --preview 'pacman -Qo {}' --layout=reverse"
alias ditherdragon="/home/wintermute/src/pxtool/pxtool-src/Builds/linux/ditherdragon-linux.x86_64"
alias ditherdragon-dev="godot --path /home/wintermute/src/pxtool/pxtool-src"
alias ,ide="/home/wintermute/scripts/ide.sh"
alias ,vide="/home/wintermute/scripts/vide.sh"
alias ,staticwebserver="go run /home/wintermute/scripts/staticwebserver.go"
alias ,newtask="/home/wintermute/scripts/new_task.sh"
alias t="go-task"

# completion definitions
#fpath=(~/.config/zsh/completion_files/_glow $fpath)
