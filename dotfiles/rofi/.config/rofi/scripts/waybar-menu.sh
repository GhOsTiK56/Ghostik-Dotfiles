#!/usr/bin/env bash

export PATH="$HOME/.local/bin:$PATH"

THEMES="$HOME/.config/waybar/themes"
IMAGES="$HOME/.config/rofi/images"

theme=$(
    find "$THEMES" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d \
        -printf "%f\n" |
    while read -r t; do
        echo -en "$t\0icon\x1f$IMAGES/$t.png\n"
    done |
    rofi \
        -dmenu \
        -show-icons \
        -theme ~/.config/rofi/waybar-selector.rasi
)

[[ -z "$theme" ]] && exit

waybar-switch.sh "$theme"