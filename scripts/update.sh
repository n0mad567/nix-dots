#!/usr/bin/env bash
set -euo pipefail

FLAKE="$HOME/nix-dots"
HOST="$(hostname)"

cd "$FLAKE"

echo "Saving current configuration to git..."
git add .
git commit -m "Before flake update $(date +%F)" || true

echo "Updating flake inputs..."
nix flake update

echo "Checking configuration..."
nix flake check --no-build

echo "Building updated system..."
sudo nixos-rebuild build --flake "$FLAKE#$HOST"

echo "Switching to updated system..."
sudo nixos-rebuild switch --flake "$FLAKE#$HOST"

echo "Update successful."