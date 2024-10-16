require("Comment").setup({
	pre_hook = function(ctx)
		local U = require("Comment.utils")

		-- Determine the file type
		local filetype = vim.bo.filetype

		-- If file is jsx or tsx, use block comment style
		if filetype == "javascriptreact" or filetype == "typescriptreact" then
			-- Determine whether to use linewise or blockwise comment
			local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
			local location = require("ts_context_commentstring.utils").get_cursor_location()

			return require("ts_context_commentstring.internal").calculate_commentstring({
				key = type,
				location = location,
			})
		end
	end,
})
