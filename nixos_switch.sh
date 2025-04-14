#!/usr/bin/env bash

cd /etc/nixos/ && sudo nix flake update;
sudo nixos-rebuild switch --flake /etc/nixos/
