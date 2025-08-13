#!/usr/bin/env bash
# ~/.config/waybar/scripts/auto‑waybar.sh
# Toggle Waybar’s "mode" and "exclusive" based on the active window state.
# Needs: hyprctl  ▸ jq  ▸ sed  ▸ waybar ≥0.10

CFG="$HOME/.config/waybar/config.jsonc"   # adjust if you keep it elsewhere

# ---------- tiny helpers ----------
make_dock () {                        # floating / tiled
  sed -Ei 's/"mode":[^,]*/"mode": "dock"/' "$CFG"
  sed -Ei 's/"exclusive":[^,]*/"exclusive": true/' "$CFG"
  pkill -SIGUSR2 waybar              # runtime reload
}

make_hide () {                       # real fullscreen
  sed -Ei 's/"mode":[^,]*/"mode": "invisible"/' "$CFG"
  sed -Ei 's/"exclusive":[^,]*/"exclusive": false/' "$CFG"
  pkill -SIGUSR2 waybar
}

# ---------- main loop ----------
while true; do
    info=$(hyprctl activewindow -j 2>/dev/null)
    [ -z "$info" ] && sleep 0.3 && continue      # nothing focused
    if echo "$info" | jq -e '.fullscreen' | grep -q true; then
        make_hide
    else
        make_dock
    fi
    sleep 0.3      # ≈3 Hz; change if you want faster/slower reaction
done
