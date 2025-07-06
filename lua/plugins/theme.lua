return {
	"datsfilipe/vesper.nvim",
	config = function()
		require("vesper").setup({
			transparent = true, -- Boolean: Sets the background to transparent
			italics = {
				comments = true, -- Boolean: Italicizes comments
				strings = true, -- Boolean: Italicizes strings
			},
			overrides = {}, -- A dictionary of group names, can be a function returning a dictionary or a table.
			palette_overrides = {},
		})
		vim.cmd.colorscheme("vesper")
	end,
}
