#!/bin/bash
echo "installing configured dotfiles to the system! Are you sure? [y/n]"

read INPUT_STRING
if ["$INPUT_STRING" == "y"]; then
      cp ./nvim/ ~/.config/nvim/
      echo "dotfiles installed"
fi
