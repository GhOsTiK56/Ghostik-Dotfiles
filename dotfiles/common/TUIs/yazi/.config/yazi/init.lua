-- Git styling (Kanagawa-friendly)
th.git = th.git or {}

-- Цвета под Kanagawa
th.git.modified  = ui.Style():fg("#7FB4CA")   -- blue
th.git.added     = ui.Style():fg("#98BB6C")   -- green
th.git.untracked = ui.Style():fg("#E6C384")   -- yellow
th.git.deleted   = ui.Style():fg("#E46876"):bold() -- red
th.git.ignored   = ui.Style():fg("#727169")   -- gray
th.git.clean     = ui.Style():fg("#7AA89F")   -- cyan-ish

-- Символы (минималистичные, как в топ dotfiles)
th.git.modified_sign  = "M"
th.git.added_sign     = "A"
th.git.untracked_sign = "?"
th.git.deleted_sign   = "D"
th.git.ignored_sign   = "I"
th.git.clean_sign     = "."

-- Инициализация плагина
require("git"):setup {
	order = 1500,
}

require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}
