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
		opts = {
			auto_close = false, -- auto close when there are no items
			auto_open = false, -- auto open when there are items
			auto_preview = true, -- automatically open preview when on an item
			auto_refresh = true, -- auto refresh when open
			auto_jump = false, -- auto jump to the item when there's only one
			focus = false, -- Focus the window when opened
			restore = true, -- restores the last location in the list when opening
			follow = true, -- Follow the current item
			indent_guides = true, -- show indent guides
			max_items = 200, -- limit number of items that can be displayed per section
			multiline = true, -- render multi-line messages
			pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
			warn_no_results = true, -- show a warning when there are no results
			open_no_results = false, -- open the trouble window when there are no results
			---@type trouble.Window.opts
			win = {}, -- window options for the results window. Can be a split or a floating window.
			-- Window options for the preview window. Can be a split, floating window,
			-- or `main` to show the preview in the main editor window.
			---@type trouble.Window.opts
			preview = {
				type = "main",
				-- when a buffer is not yet loaded, the preview window will be created
				-- in a scratch buffer with only syntax highlighting enabled.
				-- Set to false, if you want the preview to always be a real loaded buffer.
				scratch = true,
			},
			-- Throttle/Debounce settings. Should usually not be changed.
			---@type table<string, number|{ms:number, debounce?:boolean}>
			throttle = {
				refresh = 10, -- fetches new data when needed
				update = 10, -- updates the window
				render = 10, -- renders the window
				follow = 10, -- follows the current item
				preview = { ms = 10, debounce = true }, -- shows the preview for the current item
			},
			-- Key mappings can be set to the name of a builtin action,
			-- or you can define your own custom action.
			---@type table<string, trouble.Action.spec|false>
			keys = {
				["?"] = "help",
				r = "refresh",
				R = "toggle_refresh",
				q = "close",
				o = "jump_close",
				["<esc>"] = "cancel",
				["<cr>"] = "jump",
				["<2-leftmouse>"] = "jump",
				["<c-s>"] = "jump_split",
				["<c-v>"] = "jump_vsplit",
				-- go down to next item (accepts count)
				-- j = "next",
				["}"] = "next",
				["]]"] = "next",
				-- go up to prev item (accepts count)
				-- k = "prev",
				["{"] = "prev",
				["[["] = "prev",
				dd = "delete",
				d = { action = "delete", mode = "v" },
				i = "inspect",
				p = "preview",
				P = "toggle_preview",
				zo = "fold_open",
				zO = "fold_open_recursive",
				zc = "fold_close",
				zC = "fold_close_recursive",
				za = "fold_toggle",
				zA = "fold_toggle_recursive",
				zm = "fold_more",
				zM = "fold_close_all",
				zr = "fold_reduce",
				zR = "fold_open_all",
				zx = "fold_update",
				zX = "fold_update_all",
				zn = "fold_disable",
				zN = "fold_enable",
				zi = "fold_toggle_enable",
				gb = { -- example of a custom action that toggles the active view filter
					action = function(view) view:filter({ buf = 0 }, { toggle = true }) end,
					desc = "Toggle Current Buffer Filter",
				},
				s = { -- example of a custom action that toggles the severity
					action = function(view)
						local f = view:get_filter("severity")
						local severity = ((f and f.filter.severity or 0) + 1) % 5
						view:filter({ severity = severity }, {
							id = "severity",
							template = "{hl:Title}Filter:{hl} {severity}",
							del = severity == 0,
						})
					end,
					desc = "Toggle Severity Filter",
				},
			},
			---@type table<string, trouble.Mode>
			modes = {
				-- sources define their own modes, which you can use directly,
				-- or override like in the example below
				lsp_references = {
					-- some modes are configurable, see the source code for more details
					params = {
						include_declaration = true,
					},
				},
				-- The LSP base mode for:
				-- * lsp_definitions, lsp_references, lsp_implementations
				-- * lsp_type_definitions, lsp_declarations, lsp_command
				lsp_base = {
					params = {
						include_current = true,
					},
				},
				-- more advanced example that extends the lsp_document_symbols
				symbols = {
					desc = "document symbols",
					mode = "lsp_document_symbols",
					focus = false,
					win = { position = "right" },
					filter = {
						-- remove Package since luals uses it for control flow structures
						["not"] = { ft = "lua", kind = "Package" },
						any = {
							-- all symbol kinds for help / markdown files
							ft = { "help", "markdown" },
							-- default set of symbol kinds
							kind = {
								"Class",
								"Constructor",
								"Enum",
								"Field",
								"Function",
								"Interface",
								"Method",
								"Module",
								"Namespace",
								"Package",
								"Property",
								"Struct",
								"Trait",
							},
						},
					},
				},
			},
			icons = {
				---@type trouble.Indent.symbols
				indent = {
					top = "│ ",
					middle = "├╴",
					last = "└╴",
					-- last          = "-╴",
					-- last       = "╰╴", -- rounded
					fold_open = " ",
					fold_closed = " ",
					ws = "  ",
				},
				folder_closed = " ",
				folder_open = " ",
				kinds = {
					Array = " ",
					Boolean = "󰨙 ",
					Class = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Function = "󰊕 ",
					Interface = " ",
					Key = " ",
					Method = "󰊕 ",
					Module = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",
					Object = " ",
					Operator = " ",
					Package = " ",
					Property = " ",
					String = " ",
					Struct = "󰆼 ",
					TypeParameter = " ",
					Variable = "󰀫 ",
				},
			},
		}, -- for default options, refer to the configuration section for custom setup.
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
