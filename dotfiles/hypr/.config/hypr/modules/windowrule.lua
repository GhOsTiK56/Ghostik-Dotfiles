--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.workspace_rule({
	workspace = "1",
	animation = "slidevert"
})
hl.workspace_rule({
	workspace = "2",
	animation = "slidevert"
})
hl.workspace_rule({
	workspace = "3",
	animation = "slidevert"
})
hl.workspace_rule({
	workspace = "4",
	animation = "slidevert"
})
hl.workspace_rule({
	workspace = "5",
	animation = "slidevert"
})
hl.workspace_rule({
	workspace = "6",
	animation = "slidevert"
})
hl.workspace_rule({
	workspace = "7",
	animation = "slidevert"
})

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = {
		class = ".*"
	},

	suppress_event = "maximize"
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false
	},

	no_focus = true
})

hl.window_rule({
	name = "blur-vsCode",
	match = {
		class = "code"
	},
	opacity = "1.0"
})

hl.window_rule({
	name = "move-hyprland-run",
	match = {
		class = "hyprland-run"
	},

	move = "20 monitor_h-120",
	float = true
})

hl.window_rule({
	name = "float-telegram",
	match = {
		class = "org.telegram.desktop"
	},

	float = true,
	center = true,
	size = "700 900",
	workspace = "unset"
})

hl.window_rule({
	name = "float-telegram-media-viewer",
	match = {
		class = "org.telegram.desktop",
    title = "Media viewer"
	},

	float = true,
	center = true,
	size = "700 900",
	workspace = "unset"
})

hl.window_rule({
	name = "float-pavucontrol",
	match = {
		class = "org.pulseaudio.pavucontrol"
	},

	float = true,
	center = true,
	size = "700 500"
})

hl.window_rule({
	name = "fix-android-studio-popups",
	match = {
		class = "jetbrains-studio",
		title = "^win(.*)$"
	},

	no_initial_focus = true
})

hl.window_rule({
	name = "float-audiorelay",
	match = {
		class = "com-azefsw-audioconnect-desktop-app-MainKt",
		title = "AudioRelay"
	},

	float = true,
	center = true
})

hl.window_rule({
	name = "flameshot-fix",
	match = {
		class = "flameshot"
	},

	float = true,
	center = true,

	no_shadow = true,

	workspace = "unset"
})

-- Layer rules
hl.layer_rule({
	name = "blur-logout-dialog",
	match = {
		namespace = "logout_dialog"
	},

	blur = true
})

hl.layer_rule({
	name = "blur-swaync-control-center",
	match = {
		namespace = "swaync-control-center"
	},

	blur = true
})

hl.layer_rule({
	name = "alpha-swaync-control-center",
	match = {
		namespace = "swaync-control-center"
	},

	ignore_alpha = 0.48
})

hl.layer_rule({
	name = "blur-swaync-notification-window",

	match = {
		namespace = "swaync-notification-window"
	},

	blur = true
})

hl.layer_rule({
	name = "alpha-swaync-notification-window",

	match = {
		namespace = "swaync-notification-window"
	},

	ignore_alpha = 0.35
})
