return {
	{
		"nvim-mini/mini.surround",
		version = "*",
		lazy = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
}
