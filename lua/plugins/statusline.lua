return {
	{
		"sschleemilch/slimline.nvim",
		dependencies = { "lewis6991/gitsigns.nvim", { "echasnovski/mini.icons", version = false } },
		config = function()
			require("mini.icons").setup()
			require("slimline").setup({
				bold = true, -- makes primary parts bold

				-- Global style. Can be overwritten using `configs.<component>.style`
				style = "bg", -- or "fg"

				-- Component placement
				components = {
					left = {
						"mode",
						"path",
						"git",
					},
					center = {},
					right = {
						"diagnostics",
						"filetype_lsp",
						"progress",
					},
				},

				-- Component configuration
				-- `<component>.style` can be used to overwrite the global 'style'
				-- `<component>.hl = { primary = ..., secondary = ...}` can be used to overwrite global ones
				-- `<component>.follow` can point to another component name to follow its style (e.g. 'progress' following 'mode' by default). Follow can be disabled by setting it to `false`
				configs = {
					mode = {
						verbose = true, -- Mode as single letter or as a word
						hl = {
							normal = "Type",
							insert = "Function",
							pending = "Boolean",
							visual = "Keyword",
							command = "String",
						},
					},
					path = {
						directory = true, -- Whether to show the directory
					},
					git = {
						icons = {
							branch = "",
							added = "+",
							modified = "~",
							removed = "-",
						},
					},
					diagnostics = {
						workspace = true, -- Whether diagnostics should show workspace diagnostics instead of current buffer
						icons = {
							ERROR = " ",
							WARN = " ",
							HINT = " ",
							INFO = " ",
						},
					},
					filetype_lsp = {},
					progress = {
						follow = "mode",
						column = true, -- Enables a secondary section with the cursor column
						icon = " ",
					},
					recording = {
						icon = " ",
					},
				},

				-- Global highlights
				hl = {
					base = "StatusLine", -- highlight of the background. Change it .e.g to `StatusLine` if you do not want it to be transparent
					primary = "Normal", -- highlight of primary parts (e.g. filename)
					secondary = "Comment", -- highlight of secondary parts (e.g. filepath)
				},
				spaces = {
					components = "",
					left = "",
					right = "",
				},
				sep = {
					hide = {
						first = true,
						last = true,
					},
					left = "",
					right = "",
				},
			})
		end,
	},
}
