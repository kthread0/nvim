return {
	"marko-cerovac/material.nvim",
	lazy = false,
	config = function()
		require("material").setup({
			styles = { -- Give comments style such as bold, italic, underline etc.
				comments = { italic = true },
				strings = { bold = true },
				keywords = { underline = true },
				functions = { bold = true, undercurl = true },
				variables = {},
				operators = {},
				types = {},
			},

			plugins = { -- Uncomment the plugins that you use to highlight them
				-- Available plugins:
				"blink",
				"dap",
				"dashboard",
				"gitsigns",
				"illuminate",
				"noice",
				"nvim-notify",
				"nvim-web-devicons",
				"telescope",
				"trouble",
				"which-key",
			},

			lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

			async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)
		})
		vim.cmd("colorscheme material-deep-ocean")
	end,
}
