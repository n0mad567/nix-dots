#!/usr/bin/env bash
set -euo pipefail

FLAKE="$HOME/nix-dots"
HOST="$(hostname)"

cd "$FLAKE"

echo "Building NixOS..."
sudo nixos-rebuild build --flake "$FLAKE#$HOST"

echo "Switching configuration..."
sudo nixos-rebuild switch --flake "$FLAKE#$HOST"

echo "Rebuild complete."