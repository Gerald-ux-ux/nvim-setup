require("core.options") -- Load general options
require("core.keymaps") -- Load general keymaps

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)
vim.o.showcmd = true
require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.colortheme"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.autocompletion"),
	require("plugins.none-ls"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	require("plugins.indent-blankline"),
	require("plugins.misc"),
	require("plugins.comment"),

	--Plugins installed
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				default = true,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter", -- Load it when you enter insert mode
	},
	--tokyonight theme
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "night", -- Choose from 'night', 'storm', 'day', 'moon'
				transparent = true, -- Enable transparent background
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
					functions = {},
					variables = {},
					sidebars = "transparent", -- Transparent sidebars
					floats = "transparent", -- Transparent floating windows
				},
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	-- color highlighting
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*", -- Highlight all files
				css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in CSS files
				html = { names = true }, -- Enable color name highlighting in HTML
			})
		end,
	},
})
require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = false,
	},
	per_filetype = {
		["html"] = {
			enable_close = false,
		},
	},
})
