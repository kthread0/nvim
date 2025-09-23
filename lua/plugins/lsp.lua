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
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			"jay-babu/mason-nvim-dap.nvim",
			{ "nvim-tree/nvim-web-devicons", opts = {} },
			{
				"nvim-treesitter/nvim-treesitter",
				build = ":TSUpdate",
				branch = "main",
				lazy = false,
			},
			"nvim-treesitter/nvim-treesitter-textobjects",
			"m-demare/hlargs.nvim",
			"stevearc/conform.nvim",
		},
		opts = {},
		config = function()
			require("nvim-treesitter").setup({
				prefer_git = true,
				ensure_installed = {
					"c",
					"llvm",
					"cpp",
					"cmake",
					"bash",
					"lua",
					"vim",
					"query",
					"regex",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"json",
					"markdown",
					"markdown_inline",
					"latex",
					"rust",
				},
				sync_install = true,
				auto_install = true,
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
				ensure_installed = {
					"lua_ls",
					"clangd",
					"pylsp",
					"bashls",
					"rust_analyzer",
					"html",
					"eslint",
				},
				automatic_enable = true,
				handlers = {},
			})
			require("mason-nvim-dap").setup()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua",
					"shellharden",
					"bacon",
					"eslint_d",
					"prettierd",
					"htmlhint",
					"flake8",
					"autopep8",
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
					python = { "flake8", "pylsp" },
					["*"] = { "codespell", "codebook" },
				},
				vim.api.nvim_create_autocmd({ "BufWritePost" }, {
					callback = function() require("lint").try_lint() end,
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
					python = { "autopep8", "pylsp" },
					["*"] = { "codespell", "codebook" },
				},

				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "prefer",
				},
				default_format_opts = {
					timeout_ms = 500,
					lsp_format = "prefer",
				},
				format_after_save = {
					timeout_ms = 500,
					lsp_format = "prefer",
				},
			})
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets", { "L3MON4D3/LuaSnip", build = "make install_jsregexp" } },

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
			fuzzy = {
				implementation = "rust",
				max_typos = 0,
				sorts = {
					"exact",
					"score",
					"sort_text",
					"label",
					"kind",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
