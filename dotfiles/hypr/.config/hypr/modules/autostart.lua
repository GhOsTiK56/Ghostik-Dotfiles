-------------------
---- AUTOSTART ----
-------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
	-- Keyring Polkit agent DBus environment sync
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")

	-- Bar / UI
	hl.exec_cmd("waybar")

	-- notification daemon
	hl.exec_cmd("swaync")

	-- Hyprpm plugins
	hl.exec_cmd("hyprpm reload")

	-- Cursor
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")

	-- Clipboard tools
	hl.exec_cmd("wl-clip-persist --clipboard regular")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- Wallpaper daemon
	hl.exec_cmd("awww-daemon")

	-- RGB control with delay
	hl.exec_cmd("sh -c 'sleep 4 && openrgb --startminimized --profile black'")
end)
