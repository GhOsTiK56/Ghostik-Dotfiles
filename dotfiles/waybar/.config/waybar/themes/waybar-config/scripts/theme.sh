#!/bin/bash

# --- Configuration Paths ---
WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
WAYBAR_THEMES_DIR="$WAYBAR_CONFIG_DIR/styles"       # Waybar styles location
TARGET_WAYBAR_CSS_FILE="$WAYBAR_CONFIG_DIR/style.css" # The main CSS file Waybar loads

ROFI_CONFIG_DIR="$HOME/.config/rofi"
ROFI_THEMES_DIR="$ROFI_CONFIG_DIR/themes"         # Rofi styles location
TARGET_ROFI_CSS_FILE="$ROFI_CONFIG_DIR/style.css"   # The main CSS file Rofi loads

# State file to track the current index
STATE_FILE="$WAYBAR_CONFIG_DIR/.current_style_index"

# --- Theme List ---
# List of all available BASE style filenames. The script will look for:
# 1. Waybar: $WAYBAR_THEMES_DIR/FILENAME
# 2. Rofi:   $ROFI_THEMES_DIR/rofi_FILENAME
STYLES=(
    "style_1.css"
    "style_2.css"
    "style_3.css"
    "style_4.css"
    "style_5.css"
    "style_6.css"
    "style_7.css"
    "style_8.css"
    "style_9.css"
    "style_10.css"
    "style_11.css"
)

# --- Script Logic ---

# Get the current theme index, default to 0 if not set
CURRENT_INDEX=0
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE")
    # Reset index if it's out of bounds
    if ! [[ "$CURRENT_INDEX" =~ ^[0-9]+$ ]] || [ "$CURRENT_INDEX" -ge ${#STYLES[@]} ]; then
        CURRENT_INDEX=0
    fi
fi

# Calculate the index for the next theme in the list
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#STYLES[@]} ))
NEXT_STYLE_FILENAME="${STYLES[$NEXT_INDEX]}"

# --- Construct full paths for the next theme files using their respective directories ---
NEXT_WAYBAR_PATH="$WAYBAR_THEMES_DIR/$NEXT_STYLE_FILENAME"
NEXT_ROFI_PATH="$ROFI_THEMES_DIR/rofi_$NEXT_STYLE_FILENAME"


# The Waybar theme is required. Abort if it's not found.
if [ ! -f "$NEXT_WAYBAR_PATH" ]; then
    echo "Error: Waybar theme file not found: $NEXT_WAYBAR_PATH" >&2
    echo "Aborting theme switch." >&2
    exit 1
fi

# Kill any running Waybar instance before applying the new theme
killall waybar 2>/dev/null

cp "$NEXT_WAYBAR_PATH" "$TARGET_WAYBAR_CSS_FILE"

if [ -f "$NEXT_ROFI_PATH" ]; then
    cp "$NEXT_ROFI_PATH" "$TARGET_ROFI_CSS_FILE"
else
    echo "Warning: Rofi theme not found for '$NEXT_STYLE_FILENAME'. Skipping." >&2
fi

# Save the new index to the state file
echo "$NEXT_INDEX" > "$STATE_FILE"

waybar & disown
echo "Theme switched to: $NEXT_STYLE_FILENAME"