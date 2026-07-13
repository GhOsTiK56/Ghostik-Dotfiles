---------------------
---- KEYBINDINGS ----
---------------------
-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local mainMod = "SUPER"
local terminal = "kitty"
local menu = "rofi -show drun"
local browser = "zen-browser"
local TUIfileManager = "kitty -e yazi"
local GUIfileManager = "dolphin"
local messenger = "Telegram"
local note = "obsidian"
local wlogout = "wlogout"
local hyprlock = "hyprlock"

-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(TUIfileManager))
hl.bind(mainMod .. " + ALT + E", hl.dsp.exec_cmd(GUIfileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(messenger))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(note))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(wlogout))
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui"))

-- discord toggle mute
hl.bind(
	"PAUSE",
	hl.dsp.pass({
		window = "class:^(discord)$",
	})
)

-- vesktop toggle mude
hl.bind(
	"CTRL + SHIFT + M",
	hl.dsp.pass({
		window = "class:^(vesktop)$",
	})
)

-- Clipboard history
hl.bind(
	mainMod .. " + SHIFT + V",
	hl.dsp.exec_cmd(
		[[sh -c 'cliphist list | rofi -dmenu -i -p "📋 Clipboard History" -theme-str "window {width: 700px;}" | cliphist decode | wl-copy']]
	)
)

-- Screenshots
-- Print -> quick screenshot
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -zm region --freeze --raw | wl-copy -t image/png"))

-- SUPER + Print -> screenshot with satty editor
hl.bind(
	mainMod .. " + PRINT",
	hl.dsp.exec_cmd(
		[[sh -c 'hyprshot -zm region --freeze --raw | satty --filename - --early-exit --copy-command="wl-copy -t image/png" --actions-on-enter=save-to-clipboard']]
	)
)

-- scroll overview
hl.bind("SUPER + G", function()
	hl.plugin.scrolloverview.overview("toggle")
end)

-- hyprland.lua
hl.define_submap("scrolloverview", function()
    hl.bind(mainMod .. "+ H", hl.plugin.scrolloverview.navigate("left"))
    hl.bind(mainMod .. "+ L", hl.plugin.scrolloverview.navigate("right"))
    hl.bind(mainMod .. "+ K", hl.plugin.scrolloverview.navigate("up"))
    hl.bind(mainMod .. "+ J", hl.plugin.scrolloverview.navigate("down"))
    hl.bind("RETURN", hl.plugin.scrolloverview.overview("select"))
    hl.bind("ESCAPE", hl.plugin.scrolloverview.overview("off"))
    hl.bind("mouse:272", function()
        -- Select the clicked window, or just the workspace if no window was clicked, then close the overview. This is the default behavior if submap is not defined.
        hl.plugin.scrolloverview.overview("select")
        hl.plugin.scrolloverview.window("select")
        hl.plugin.scrolloverview.overview("off")
    end, { mouse = true })
    hl.bind("mouse:274", hl.plugin.scrolloverview.window("close"), { mouse = true })
end)

-- Example Hyprland bind that keeps working inside the submap:
for i = 1, 10 do
    local key = i % 10
    hl.bind("ALT + " .. key, hl.dsp.focus({ workspace = i }), { submap_universal = true })
end

-- Window Management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
	mainMod .. " + V",
	hl.dsp.window.float({
		action = "toggle",
	})
)
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(hyprlock))

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Focus movement
hl.bind(
	mainMod .. " + H",
	hl.dsp.focus({
		direction = "left",
	})
)
hl.bind(
	mainMod .. " + L",
	hl.dsp.focus({
		direction = "right",
	})
)
hl.bind(
	mainMod .. " + K",
	hl.dsp.focus({
		direction = "up",
	})
)
hl.bind(
	mainMod .. " + J",
	hl.dsp.focus({
		direction = "down",
	})
)

-- move window inside a workspace
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("swapcol r"))

-- Relative workspace switching
hl.bind(
	mainMod .. " + CTRL + K",
	hl.dsp.focus({
		workspace = "r-1",
	})
)
hl.bind(
	mainMod .. " + CTRL + J",
	hl.dsp.focus({
		workspace = "r+1",
	})
)
hl.bind(
	mainMod .. " + SHIFT + K",
	hl.dsp.window.move({
		workspace = "r-1",
	})
)
hl.bind(
	mainMod .. " + SHIFT + J",
	hl.dsp.window.move({
		workspace = "r+1",
	})
)

-- Switch workspaces
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(
		mainMod .. " + " .. key,
		hl.dsp.focus({
			workspace = i,
		})
	)
	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.window.move({
			workspace = i,
		})
	)
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.window.move({
		workspace = "special:magic",
	})
)

-- resize windows
hl.bind(mainMod .. " + W", hl.dsp.layout("colresize +conf"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {
	mouse = true,
})
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {
	mouse = true,
})

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), {
	locked = true,
})
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), {
	locked = true,
})
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), {
	locked = true,
})
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), {
	locked = true,
})
