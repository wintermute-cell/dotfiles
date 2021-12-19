#!/bin/bash
echo "installing configured dotfiles to the system! Are you sure? [y/n](n)"

read INPUT_STRING
if [ "$INPUT_STRING" = "y" ]; then
      stow -t ~ nvim
      stow -t ~ i3
      stow -t ~ dunst
      stow -t ~ tmux
      echo "dotfiles installed"
fi
