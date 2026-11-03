#!/usr/bin/env bash
set -euo pipefail

FLAKE="$HOME/nix-dots"
HOST="$(hostname)"
SYSTEM_PROFILE="/nix/var/nix/profiles/system"

cd "$FLAKE"

# Suppress unhelpful dirty-tree warnings
NIX_CONFIG="${NIX_CONFIG:-}"
NIX_CONFIG+=$'\nwarn-dirty = false'
export NIX_CONFIG

echo "================================"
echo "       NixOS System Manager"
echo "================================"

# Verify Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a Git repository."
    exit 1
fi

# Check configuration changes
echo
echo "Checking configuration for changes..."

CHANGES=$(git status --porcelain --untracked-files=all \
    -- . ':(exclude)flake.lock')

if [ -z "$CHANGES" ]; then
    echo "No configuration changes detected."
    echo "Running full flake update..."
    UPDATE_FLAKE=true
else
    echo "Configuration changes detected:"
    echo "$CHANGES"
    echo
    echo "Skipping flake update."
    UPDATE_FLAKE=false
fi

# Update flake inputs
echo

if [ "$UPDATE_FLAKE" = true ]; then
    echo "Updating flake inputs..."

    # Keep download progress visible
    nix flake update

fi

# Check configuration
echo
echo "Checking flake configuration..."

nix flake check --no-build >/dev/null

echo "Configuration check passed."

# Build system
echo
echo "Building $HOST configuration..."

sudo env NIX_CONFIG="$NIX_CONFIG" \
    nixos-rebuild build --flake "$FLAKE#$HOST" >/dev/null

echo "Build successful."

# Switch system
echo
echo "Switching to updated system..."

sudo env NIX_CONFIG="$NIX_CONFIG" \
    nixos-rebuild switch --flake "$FLAKE#$HOST" >/dev/null

echo "System switched successfully."

# Commit updated flake.lock
if [ "$UPDATE_FLAKE" = true ]; then
    echo
    echo "Saving updated flake.lock to Git..."

    git add -- flake.lock

    if ! git diff --cached --quiet -- flake.lock; then
        git commit -m "Update flake inputs $(date +%F-%H%M)" \
            --only -- flake.lock
    else
        echo "No flake.lock changes to commit."
    fi
fi

# Adaptive generation cleanup
echo
echo "Checking system generations..."

CUTOFF_DATE=$(date -d "30 days ago" +%F)

RECENT_GENERATIONS=$(
    sudo nix-env --list-generations --profile "$SYSTEM_PROFILE" |
    awk -v cutoff="$CUTOFF_DATE" '
        $2 ~ /^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$/ &&
        $2 >= cutoff {
            count++
        }
        END {
            print count+0
        }
    '
)

echo "Generations in the last 30 days: $RECENT_GENERATIONS"

if [ "$RECENT_GENERATIONS" -lt 10 ]; then
    echo
    echo "Keeping the 10 newest system generations..."

    sudo nix-env \
        --profile "$SYSTEM_PROFILE" \
        --delete-generations +10

    echo "Collecting unused Nix store files..."

    sudo nix-collect-garbage >/dev/null
else
    echo
    echo "Deleting generations older than 30 days..."

    sudo nix-collect-garbage \
        --delete-older-than 30d >/dev/null
fi

echo "Garbage collection complete."

# Optimize Nix store
echo
echo "Optimizing Nix store..."

sudo nix-store --optimise

# Finish
echo
echo "================================"
echo "       Operation successful!"
echo "================================"

if [ "$UPDATE_FLAKE" = true ]; then
    echo "Completed: Full flake update."
else
    echo "Completed: Configuration rebuild."
fi

echo
echo "Current system generations:"
sudo nix-env --list-generations --profile "$SYSTEM_PROFILE"

echo
echo "Disk usage:"
df -h /

echo 
