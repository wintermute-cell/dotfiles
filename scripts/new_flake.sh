#!/usr/bin/env bash

TEMPLATES_DIR="$HOME/scripts/flake_templates"

selected_template=$(find "$TEMPLATES_DIR" -type f | fzf --preview='less {}' --prompt="Select template: ")

# Check if a flake.nix file already exists
if [ -f "./flake.nix" ]; then
    echo "flake.nix already exists. Do you want to overwrite it? (y/N)"
    read -r answer
    if [[ "$answer" != "y" ]]; then
        echo "Exiting without changes."
        exit 0
    fi
fi

if [ -n "$selected_template" ]; then
    cp "$selected_template" "./flake.nix"
    echo "flake.nix has been created from the selected template: $selected_template"
    echo "Add 'use flake' to .envrc? This will overwrite your current .envrc if one exists! (y/N)"
    read -r add_to_envrc
    if [[ "$add_to_envrc" == "y" ]]; then
        echo "use flake" > .envrc
        echo ".envrc updated to include 'use flake'."
    else
        echo ".envrc not modified."
    fi
else
    echo "No layout selected, exiting."
    exit 0
fi
