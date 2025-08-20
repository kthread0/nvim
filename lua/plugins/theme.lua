return {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme moonfly")
		vim.g.moonflyCursorColor = true
		vim.g.moonflyTransparent = true
		vim.g.moonflyUnderlineMatchParen = true
		vim.g.moonflyVirtualTextColor = true
	end,
}
