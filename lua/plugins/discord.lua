return {
	"vyfor/cord.nvim",
	build = ":Cord update",
	config = function()
		require("cord").setup({
			display = {
				swap_fields = true,
			},
			timestamp = {
				enabled = true,
				shared = true,
			},
			advanced = {
				plugin = { cursor_update = "on_move" },
				server = {
					update = "build",
				},
				discord = {
					reconnect = {
						enabled = true,
					},
				},
			},
			plugins = {
				"cord.plugins.diagnostics", -- Enable diagnostics plugin with default settings

				["cord.plugins.diagnostics"] = { -- Enable AND configure diagnostics plugin
					scope = "workspace", -- Set scope to 'workspace' instead of default 'buffer'
					severity = vim.diagnostic.severity.WARN, -- Show warnings and above
				},
			},
		})
	end,
}
