return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-lint",
			"xzbdmw/colorful-menu.nvim",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp", dependencies = { "rafamadriz/friendly-snippets" } },
			"jay-babu/mason-nvim-dap.nvim",
			{ "nvim-tree/nvim-web-devicons", opts = {} },
			{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
			"nvim-treesitter/nvim-treesitter-textobjects",
			"m-demare/hlargs.nvim",
			"stevearc/conform.nvim",
		},
		opts = {},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"llvm",
					"cpp",
					"cmake",
					"bash",
					"nasm",
					"asm",
					"lua",
					"luadoc",
					"vim",
					"vimdoc",
					"query",
					"regex",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"nix",
					"make",
					"meson",
					"json",
					"kdl",
					"markdown",
					"markdown_inline",
					"ninja",
					"commonlisp",
					"latex",
					"rust",
				},
				sync_install = false,
				highlight = { enable = true, additional_vim_regex_highlighting = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn", -- set to `false` to disable one of the mappings
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true or false
						include_surrounding_whitespace = true,
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							--
							-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
					lsp_interop = {
						enable = true,
						border = "none",
						floating_preview_opts = {},
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
			})
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				max_concurrent_installers = 10,
				pip = { upgrade_pip = true },
			})
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "bashls", "rust_analyzer", "html", "eslint" },
				automatic_enable = true,
				handlers = {},
			})
			require("mason-nvim-dap").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"luacheck",
					"shellharden",
					"bacon",
					"eslint_d",
					"prettierd",
					"htmlhint",
				},
				auto_update = true,
			})
			require("hlargs").setup()
			require("hlargs").enable()
			require("lint").linters_by_ft = {
				{
					lua = { "luacheck" },
					c = { "clang-tidy" },
					bash = { "shellharden" },
					rust = { "bacon" },
					javascript = { "eslint_d" },
					typescript = { "eslint_d" },
					html = { "htmlhint" },
				},
				vim.api.nvim_create_autocmd({ "BufWritePost" }, {
					callback = function()
						require("lint").try_lint()
					end,
				}),
			}
			require("conform").setup({
				formatters_by_ft = {
					c = { "clang-format" },
					lua = { "stylua" },
					bash = { "shellharden" },
					rust = { "rustfmt" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					html = { "prettierd" },
					["*"] = { "codespell" },
				},
			})
			require("conform").setup({
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },

		build = "cargo build --release",

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = { preset = "luasnip" },
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = { preset = "super-tab" },

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "normal",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				keyword = { range = "full" },
				ghost_text = { enabled = true, show_without_selection = true },
				menu = { auto_show = true, draw = { treesitter = { "lsp" } } },
				documentation = { auto_show = true },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "cmdline" },
			},

			signature = {
				enabled = true,
				trigger = {
					enabled = true,
					show_on_keyword = true,
					show_on_insert = true,
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "rust" },
		},
		opts_extend = { "sources.default" },
	},
}
