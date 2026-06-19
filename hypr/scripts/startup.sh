#!/bin/bash

# ----------------------------------
# Workspace 1
# Terminal + Yazi + CMatrix
# ----------------------------------

hyprctl dispatch workspace 1

# kitty &
# sleep 1

kitty yazi &
sleep 1

kitty cmatrix &
sleep 1


# ----------------------------------
# Workspace 2
# Browser
# ----------------------------------

hyprctl dispatch workspace 2

brave-browser &
sleep 2


# ----------------------------------
# Workspace 3
# VSCode
# ----------------------------------

hyprctl dispatch workspace 3

# code ~/Projects &
code &
sleep 2


# ----------------------------------
# Workspace 4
# Development Workspace
# ----------------------------------

hyprctl dispatch workspace 4

kitty &
sleep 0.5

kitty &
sleep 0.5

kitty &
sleep 0.5

kitty &
sleep 1


# ----------------------------------
# Workspace 5
# Music Workspace
# ----------------------------------

hyprctl dispatch workspace 5

flatpak run com.spotify.Client &
sleep 5

kitty cava &
sleep 1

kitty btm &
sleep 1


# ----------------------------------
# Return to Workspace 1
# ----------------------------------

hyprctl dispatch workspace 1