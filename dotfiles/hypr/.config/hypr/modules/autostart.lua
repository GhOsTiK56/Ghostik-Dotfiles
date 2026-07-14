-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
	-- Keyring Polkit agent DBus environment sync
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")

	-- Bar / UI
	hl.exec_cmd("uwsm app -- waybar")

	-- notification daemon
	hl.exec_cmd("uwsm app -- swaync")

	-- Hyprpm plugins
	hl.exec_cmd("hyprpm reload")

	-- Cursor
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")

	-- Clipboard tools
	hl.exec_cmd("uwsm app -- wl-clip-persist --clipboard regular")
	hl.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist store")
	hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store")

	-- Wallpaper daemon
	hl.exec_cmd("uwsm app -- awww-daemon")

	-- RGB control with delay
	hl.exec_cmd("sh -c 'sleep 4 && uwsm app -- openrgb --startminimized --profile black'")
end)
