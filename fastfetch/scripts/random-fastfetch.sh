#!/bin/bash

LOGO_DIR="$HOME/.config/fastfetch/logos"

LOGO=$(find "$LOGO_DIR" -type f | shuf -n 1)

EXT="${LOGO##*.}"

if [[ "$EXT" == "png" || "$EXT" == "jpg" || "$EXT" == "jpeg" || "$EXT" == "webp" ]]; then
    WIDTH=35
else
    WIDTH=2
fi

sed \
    -e "s|__LOGO__|$LOGO|g" \
    -e "s|__WIDTH__|$WIDTH|g" \
    "$HOME/.config/fastfetch/config-template.txt" \
    > /tmp/fastfetch-random.jsonc

fastfetch --config /tmp/fastfetch-random.jsonc