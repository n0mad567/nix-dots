#!/usr/bin/env bash

set -euo pipefail


WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
STATE_FILE="$HOME/.cache/current-wallpaper"

selected=$(
    find "$WALLPAPER_DIR" \
        -maxdepth 1 \
        -type f \
        \( \
            -iname "*.png" \
            -o -iname "*.jpg" \
            -o -iname "*.jpeg" \
            -o -iname "*.webp" \
        \) \
        -printf "%f\n" \
    | sort \
    | wofi \
        --show dmenu \
        --prompt "Wallpaper"
)

[ -z "$selected" ] && exit 0

wallpaper="$WALLPAPER_DIR/$selected"

# Set wallpaper.
awww img "$wallpaper" --transition-type wave --transition-angle 145

# Generate pywal colors.
wal -i "$wallpaper" -n

# Save selected wallpaper for next login.
printf '%s\n' "$wallpaper" > "$STATE_FILE"

# Reload Waybar.
pkill waybar || true
waybar >/dev/null 2>&1 &