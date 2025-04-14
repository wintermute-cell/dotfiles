#!/usr/bin/env bash

cd /etc/dotfiles && nix flake update;
home-manager switch --flake '/etc/dotfiles?submodules=1';
