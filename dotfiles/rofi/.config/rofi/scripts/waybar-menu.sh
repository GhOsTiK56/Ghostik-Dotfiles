#!/usr/bin/env bash

export PATH="$HOME/.local/bin:$PATH"

THEMES="$HOME/.config/waybar/themes"

theme=$(
    find "$THEMES" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d \
        -printf "%f\n" |
    sort |
    rofi -dmenu -p "Waybar"
)

[[ -z "$theme" ]] && exit

waybar-switch.sh "$theme"