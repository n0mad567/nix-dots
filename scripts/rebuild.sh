#!/usr/bin/env bash
sudo nix-channel --update
sudo nixos-rebuild switch --upgrade --flake ~/nix-dots#$(hostname)
sudo nix-env --delete-generations +10 --profile /nix/var/nix/profiles/system