#!/usr/bin/env bash

set -euo pipefail

THEMES="$HOME/.config/waybar/themes"

theme="${1:-}"

if [[ -z "$theme" ]]; then
  echo "Usage: waybar-switch <theme>"
  exit 1
fi

if [[ ! -d "$THEMES/$theme" ]]; then
  echo "Theme '$theme' not found."
  exit 1
fi

pkill waybar || true

while pgrep -x waybar >/dev/null; do
  sleep 0.05
done

waybar \
  -c "$THEMES/$theme/config.jsonc" \
  -s "$THEMES/$theme/style.css" \
  >/dev/null 2>&1 &
