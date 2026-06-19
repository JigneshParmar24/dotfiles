#!/bin/bash
DIR="$HOME/Pictures/Wallpapers/Desktop"
WALL=$(find "$DIR" -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) \
  | shuf -n 1)

swww img "$WALL" \
  --transition-type any \
  --transition-fps 60 \
  --transition-duration 1.5

~/.cargo/bin/wallust run "$WALL"