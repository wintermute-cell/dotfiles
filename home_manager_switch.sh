#!/usr/bin/env bash

cd /etc/dotfiles && nix flake update;
home-manager switch --show-trace --flake '/etc/dotfiles?submodules=1';
