return {
	{
		"bjarneo/aether.nvim",
		branch = "v2",
		name = "aether",
		priority = 1000,
		opts = {
			transparent = false,
			colors = {
				-- Background colors
				bg = "#141d23",
				bg_dark = "#10171c",
				bg_highlight = "#22343d",

				-- Foreground colors
				-- fg: Object properties, builtin types, builtin variables, member access, default text
				fg = "#b69f80",
				-- fg_dark: Inactive elements, statusline, secondary text
				fg_dark = "#8a7b68",
				-- comment: Line highlight, gutter elements, disabled states
				comment = "#255051",

				-- Accent colors
				-- red: Errors, diagnostics, tags, deletions, breakpoints
				red = "#d61f20",
				-- orange: Constants, numbers, current line number, git modifications
				orange = "#f09631",
				-- yellow: Types, classes, constructors, warnings, numbers, booleans
				yellow = "#e6c93a",
				-- green: Comments, strings, success states, git additions
				green = "#63bba5",
				-- cyan: Parameters, regex, preprocessor, hints, properties
				cyan = "#93c5b3",
				-- blue: Functions, keywords, directories, links, info diagnostics
				blue = "#7c49e0",
				-- purple: Storage keywords, special keywords, identifiers, namespaces
				purple = "#c44b8f",
				-- magenta: Function declarations, exception handling, tags
				magenta = "#f762c2",
			},
		},
		config = function(_, opts)
			require("aether").setup(opts)
			vim.cmd.colorscheme("aether")

			-- Enable hot reload
			require("aether.hotreload").setup()
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "aether",
		},
	},
}
