#!/bin/bash

DIR="${1:-$HOME/Pictures/Wallpapers/W}"

PREVIEW_SCRIPT=$(mktemp /tmp/wallpaper-preview-XXXXXX.sh)
cat > "$PREVIEW_SCRIPT" << 'EOF'
#!/bin/bash
FILE="$1"
COLS=$FZF_PREVIEW_COLUMNS
LINES=$FZF_PREVIEW_LINES

kitty icat --clear --stdin=no --transfer-mode=memory 2>/dev/null

if [[ "$FILE" == *.gif ]]; then
    TMPFILE=$(mktemp /tmp/gifpreview-XXXXXX.png)
    ffmpeg -i "$FILE" -vframes 1 -y "$TMPFILE" 2>/dev/null
    kitty icat --transfer-mode=memory --unicode-placeholder --stdin=no \
        --place="${COLS}x${LINES}@0x0" \
        --scale-up \
        "$TMPFILE" 2>/dev/null
    rm -f "$TMPFILE"
else
    kitty icat --transfer-mode=memory --unicode-placeholder --stdin=no \
        --place="${COLS}x${LINES}@0x0" \
        --scale-up \
        "$FILE" 2>/dev/null
fi
EOF
chmod +x "$PREVIEW_SCRIPT"

WALL=$(find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | sort | \
    fzf \
    --preview "$PREVIEW_SCRIPT {}" \
    --preview-window=right:40%:wrap:border-left \
    --prompt=" wallpaper > " \
    --header=" enter to apply | esc to exit" \
    --border=none \
    --color="bg:#0a0a0a,bg+:#1a1a1a,border:#333333,prompt:#cdd6f4,header:#6c7086,hl:#cba6f7,hl+:#cba6f7,pointer:#cba6f7,info:#6c7086,preview-bg:#0a0a0a" \
    --height=100% \
    --layout=reverse \
    --no-mouse \
    --filepath-word
)

rm -f "$PREVIEW_SCRIPT"
kitty icat --clear 2>/dev/null

if [ -n "$WALL" ]; then
    swww img "$WALL" \
        --transition-type any \
        --transition-fps 60 \
        --transition-duration 1.5

    ~/.cargo/bin/wallust run "$WALL"

    sleep 1

    hyprctl dispatch killactive
fi