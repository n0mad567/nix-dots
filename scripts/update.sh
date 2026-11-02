#!/usr/bin/env bash
set -euo pipefail

FLAKE="$HOME/nix-dots"
HOST="$(hostname)"

cd "$FLAKE"

echo "saving current configuration to git..."
git add .
git commit -m "Before flake update $(date +%F)" || true

echo "updating flake inputs..."
nix flake update

echo "checking configuration..."
nix flake check --no-build

echo "building updated system..."
sudo nixos-rebuild build --flake "$FLAKE#$HOST"

echo "switching to updated system..."
sudo nixos-rebuild switch --flake "$FLAKE#$HOST"

echo "update successful."