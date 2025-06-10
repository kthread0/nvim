return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"smjonas/inc-rename.nvim",
			"folke/twilight.nvim",
			"folke/zen-mode.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>rn", ":IncRename ")
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("snacks").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				animate = { enabled = true, fps = 60 },
				bigfile = { enabled = true },
				dashboard = { enabled = true },
				lazygit = { enabled = true, configure = true },
				explorer = { enabled = true },
				indent = { enabled = true },
				input = { enabled = true },
				picker = { enabled = true },
				image = { enabled = true },
				notifier = { enabled = true },
				quickfile = { enabled = true },
				scope = {
					enabled = true,
					cursor = true, -- when true, the column of the cursor is used to determine the scope
					edge = true, -- include the edge of the scope (typically the line above and below with smaller indent)
					siblings = true, -- expand single line scopes with single line siblings
					-- what buffers to attach to
					filter = function(buf)
						return vim.bo[buf].buftype == "" and vim.b[buf].snacks_scope ~= false and vim.g.snacks_scope ~= false
					end,
					-- debounce scope detection in ms
					debounce = 30,
					treesitter = {
						-- detect scope based on treesitter.
						-- falls back to indent based detection if not available
						enabled = true,
						injections = true, -- include language injections when detecting scope (useful for languages like `vue`)
						---@type string[]|{enabled?:boolean}
						blocks = {
							enabled = true, -- enable to use the following blocks
							"function_declaration",
							"function_definition",
							"method_declaration",
							"method_definition",
							"class_declaration",
							"class_definition",
							"do_statement",
							"while_statement",
							"repeat_statement",
							"if_statement",
							"for_statement",
						},
						-- these treesitter fields will be considered as blocks
						field_blocks = {
							"local_declaration",
						},
					},
					-- These keymaps will only be set if the `scope` plugin is enabled.
					-- Alternatively, you can set them manually in your config,
					-- using the `Snacks.scope.textobject` and `Snacks.scope.jump` functions.
					keys = {
						---@type table<string, snacks.scope.TextObject|{desc?:string}>
						textobject = {
							ii = {
								min_size = 2, -- minimum size of the scope
								edge = true, -- inner scope
								cursor = true,
								treesitter = { blocks = { enabled = false } },
								desc = "inner scope",
							},
							ai = {
								cursor = true,
								min_size = 2, -- minimum size of the scope
								treesitter = { blocks = { enabled = false } },
								desc = "full scope",
							},
						},
						---@type table<string, snacks.scope.Jump|{desc?:string}>
						jump = {
							["[i"] = {
								min_size = 1, -- allow single line scopes
								bottom = true,
								cursor = true,
								edge = true,
								treesitter = { blocks = { enabled = true } },
								desc = "jump to top edge of scope",
							},
							["]i"] = {
								min_size = 1, -- allow single line scopes
								bottom = true,
								cursor = true,
								edge = true,
								treesitter = { blocks = { enabled = true } },
								desc = "jump to bottom edge of scope",
							},
						},
					},
				},
				scroll = { enabled = true },
				statuscolumn = { enabled = true },
				words = { enabled = true },
			})
		end,
		keys = {
			-- Top Pickers & Explorer
			{
				"<leader><space>",
				function() Snacks.picker.smart() end,
				desc = "Smart Find Files",
			},
			{
				"<leader>,",
				function() Snacks.picker.buffers() end,
				desc = "Buffers",
			},
			{
				"<leader>/",
				function() Snacks.picker.grep() end,
				desc = "Grep",
			},
			{
				"<leader>:",
				function() Snacks.picker.command_history() end,
				desc = "Command History",
			},
			{
				"<leader>n",
				function() Snacks.picker.notifications() end,
				desc = "Notification History",
			},
			{
				"<leader>e",
				function() Snacks.explorer() end,
				desc = "File Explorer",
			},
			-- find
			{
				"<leader>fb",
				function() Snacks.picker.buffers() end,
				desc = "Buffers",
			},
			{
				"<leader>fc",
				function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function() Snacks.picker.files() end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function() Snacks.picker.git_files() end,
				desc = "Find Git Files",
			},
			{
				"<leader>fp",
				function() Snacks.picker.projects() end,
				desc = "Projects",
			},
			{
				"<leader>fr",
				function() Snacks.picker.recent() end,
				desc = "Recent",
			},
			-- git
			{
				"<leader>gb",
				function() Snacks.picker.git_branches() end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function() Snacks.picker.git_log() end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function() Snacks.picker.git_log_line() end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function() Snacks.picker.git_status() end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function() Snacks.picker.git_stash() end,
				desc = "Git Stash",
			},
			{
				"<leader>gd",
				function() Snacks.picker.git_diff() end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function() Snacks.picker.git_log_file() end,
				desc = "Git Log File",
			},
			-- Grep
			{
				"<leader>sb",
				function() Snacks.picker.lines() end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sB",
				function() Snacks.picker.grep_buffers() end,
				desc = "Grep Open Buffers",
			},
			{
				"<leader>sg",
				function() Snacks.picker.grep() end,
				desc = "Grep",
			},
			{
				"<leader>sw",
				function() Snacks.picker.grep_word() end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			-- search
			{
				'<leader>s"',
				function() Snacks.picker.registers() end,
				desc = "Registers",
			},
			{
				"<leader>s/",
				function() Snacks.picker.search_history() end,
				desc = "Search History",
			},
			{
				"<leader>sa",
				function() Snacks.picker.autocmds() end,
				desc = "Autocmds",
			},
			{
				"<leader>sb",
				function() Snacks.picker.lines() end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sc",
				function() Snacks.picker.command_history() end,
				desc = "Command History",
			},
			{
				"<leader>sC",
				function() Snacks.picker.commands() end,
				desc = "Commands",
			},
			{
				"<leader>sd",
				function() Snacks.picker.diagnostics() end,
				desc = "Diagnostics",
			},
			{
				"<leader>sD",
				function() Snacks.picker.diagnostics_buffer() end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>sh",
				function() Snacks.picker.help() end,
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				function() Snacks.picker.highlights() end,
				desc = "Highlights",
			},
			{
				"<leader>si",
				function() Snacks.picker.icons() end,
				desc = "Icons",
			},
			{
				"<leader>sj",
				function() Snacks.picker.jumps() end,
				desc = "Jumps",
			},
			{
				"<leader>sk",
				function() Snacks.picker.keymaps() end,
				desc = "Keymaps",
			},
			{
				"<leader>sl",
				function() Snacks.picker.loclist() end,
				desc = "Location List",
			},
			{
				"<leader>sm",
				function() Snacks.picker.marks() end,
				desc = "Marks",
			},
			{
				"<leader>sM",
				function() Snacks.picker.man() end,
				desc = "Man Pages",
			},
			{
				"<leader>sp",
				function() Snacks.picker.lazy() end,
				desc = "Search for Plugin Spec",
			},
			{
				"<leader>sq",
				function() Snacks.picker.qflist() end,
				desc = "Quickfix List",
			},
			{
				"<leader>sR",
				function() Snacks.picker.resume() end,
				desc = "Resume",
			},
			{
				"<leader>su",
				function() Snacks.picker.undo() end,
				desc = "Undo History",
			},
			{
				"<leader>uC",
				function() Snacks.picker.colorschemes() end,
				desc = "Colorschemes",
			},
			-- LSP
			{
				"gd",
				function() Snacks.picker.lsp_definitions() end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function() Snacks.picker.lsp_declarations() end,
				desc = "Goto Declaration",
			},
			{
				"gr",
				function() Snacks.picker.lsp_references() end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function() Snacks.picker.lsp_implementations() end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function() Snacks.picker.lsp_type_definitions() end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>ss",
				function() Snacks.picker.lsp_symbols() end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sS",
				function() Snacks.picker.lsp_workspace_symbols() end,
				desc = "LSP Workspace Symbols",
			},
			-- Other
			{
				"<leader>z",
				function() Snacks.zen() end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function() Snacks.zen.zoom() end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>.",
				function() Snacks.scratch() end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function() Snacks.scratch.select() end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>n",
				function() Snacks.notifier.show_history() end,
				desc = "Notification History",
			},
			{
				"<leader>bd",
				function() Snacks.bufdelete() end,
				desc = "Delete Buffer",
			},
			{
				"<leader>cR",
				function() Snacks.rename.rename_file() end,
				desc = "Rename File",
			},
			{
				"<leader>gB",
				function() Snacks.gitbrowse() end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<leader>gg",
				function() Snacks.lazygit() end,
				desc = "Lazygit",
			},
			{
				"<leader>un",
				function() Snacks.notifier.hide() end,
				desc = "Dismiss All Notifications",
			},
			{
				"<c-/>",
				function() Snacks.terminal() end,
				desc = "Toggle Terminal",
			},
			{
				"<c-_>",
				function() Snacks.terminal() end,
				desc = "which_key_ignore",
			},
			{
				"]]",
				function() Snacks.words.jump(vim.v.count1) end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function() Snacks.words.jump(-vim.v.count1) end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...) Snacks.debug.inspect(...) end
					_G.bt = function() Snacks.debug.backtrace() end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
	},
	{
		"folke/which-key.nvim",
		lazy = false,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function() require("which-key").show({ global = false }) end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"folke/trouble.nvim",
		lazy = false,
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
