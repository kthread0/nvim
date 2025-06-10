return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		config = function()
			require("ibl").setup({
				scope = {
					enabled = true,
					show_start = true,
					show_end = true,
					injected_languages = true,
				},
			})
		end,
	},
}
