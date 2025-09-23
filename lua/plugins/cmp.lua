return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets", 	{ "L3MON4D3/LuaSnip", build = "make install_jsregexp"}, },

	build = "cargo build --release",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "default" },
		snippets = { preset = 'luasnip' },

		appearance = {
			highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
			nerd_font_variant = "normal",
		},

		fuzzy = {
			implementation = "rust",
			max_typos = 0,
			sorts = {
				"exact",
				"score",
				"sort_text",
				"label",
				"kind"
			},
		},

		signature = {
			enabled = true,
			trigger = {
				enabled = true,
				show_on_keyword = true,
			},
			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				border = nil, -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
				winblend = 0,
				winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				scrollbar = true, -- Note that the gutter will be disabled when border ~= 'none'
				direction_priority = { "n", "s" },

				treesitter_highlighting = true,
				show_documentation = true,
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		completion = {
			keyword = {
				range = "full",
			},
			trigger = {
				prefetch_on_insert = true,
				show_in_snippet = true,
				show_on_backspace = true,
				show_on_backspace_in_keyword = true,
				show_on_insert = true,
			},
			documentation = {
				auto_show = true,
				treesitter_highlighting = true,
			},
			ghost_text = {
				enabled = true,
			},
			list = {
				max_items = 256,
				selection = {
					preselect = true,
					auto_insert = true,
				},
				cycle = {
					from_bottom = true,
					from_top = true,
				},
			},
		},
	},
}
