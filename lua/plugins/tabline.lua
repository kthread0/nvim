return {
	{
		"nanozuki/tabby.nvim",
		config = function()
			require("tabby").setup({
				preset = "active_wins_at_tail",
				option = {
					theme = {
						fill = "TabLineFill", -- tabline background
						head = "TabLine", -- head element highlight
						current_tab = "TabLineSel", -- current tab label highlight
						tab = "TabLine", -- other tab label highlight
						win = "TabLine", -- window highlight
						tail = "TabLine", -- tail element highlight
					},
					nerdfont = true, -- whether use nerdfont
					lualine_theme = "kanagawa", -- lualine theme name
					tab_name = {
						name_fallback = function(tabid) return tabid end,
					},
					buf_name = {
						mode = "unique", -- or 'relative', 'tail', 'shorten'
					},
				},
			})
			vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
			-- move current tab to previous position
			vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
			-- move current tab to next position
			vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })
		end,
	},
}
