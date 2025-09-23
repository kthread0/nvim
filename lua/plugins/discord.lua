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
		})
	end,
}
