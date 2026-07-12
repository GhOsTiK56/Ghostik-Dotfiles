#!/bin/bash

wallpaper_dir="$HOME/Pictures/Wallpapers"

transitions=(
    "simple"
    "fade"
    "left"
    "right"
    "top"
    "bottom"
    "wipe"
    "wave"
    "grow"
    "outer"
)

find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) -print0 | \
while IFS= read -r -d $'\0' file; do
    printf "%s\0icon\x1f%s\n" "$(basename "$file")" "$file"
done | \
rofi -dmenu -i -p "wallpaper" -markup-rows -width 40 -lines 15 \
-theme ~/.config/rofi/wallpaper-switcher.rasi | \
while IFS= read -r selected_wallpaper; do

    if [[ -n "$selected_wallpaper" ]]; then

        transition=${transitions[$RANDOM % ${#transitions[@]}]}

        duration=$(awk -v min=0.8 -v max=1.8 'BEGIN{srand(); print min+rand()*(max-min)}')

        awww img "$wallpaper_dir/$selected_wallpaper" \
            --transition-type "$transition" \
            --transition-duration "$duration" \
            --transition-fps 165

    fi

done