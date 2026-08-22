#!/usr/bin/env bash
sudo nixos-rebuild switch --flake ~/nix-dots#$(hostname)
