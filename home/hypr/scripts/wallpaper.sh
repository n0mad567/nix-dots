
#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
STATE_FILE="$HOME/.cache/current-wallpaper"

# Generate wallpaper entries with image previews.
selected=$(
    {
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
        | while IFS= read -r filename; do
            printf 'img:%s:text:%s\n' \
                "$WALLPAPER_DIR/$filename" \
                "$filename"
        done
    } | wofi \
        --show dmenu \
        --prompt "Wallpaper" \
        --allow-images \
        --parse-search \
        --define=image_size=128 \
        --define=dmenu-parse_action=true \
        --width=60% \
        --height=70%
) || exit 0

[ -z "$selected" ] && exit 0

wallpaper="$WALLPAPER_DIR/$selected"

# Set wallpaper.
awww img "$wallpaper" \
    --transition-type wave \
    --transition-angle 145

# Generate pywal colors.
wal -i "$wallpaper" -n

# Save selected wallpaper for next login.
mkdir -p "$(dirname "$STATE_FILE")"
cp -f "$wallpaper" "$STATE_FILE.image"
printf '%s\n' "$wallpaper" > "$STATE_FILE"

# Reload Waybar.
pkill waybar || true
waybar >/dev/null 2>&1 &
