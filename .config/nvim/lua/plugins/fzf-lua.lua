return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			fzf_colors = true,
			blines = {
				previewer = false,
			},
		})

		vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "[F]ind existing [B]uffers" })
		vim.keymap.set("n", "<leader>fd", fzf.diagnostics_workspace, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>fn", function()
			fzf.files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[F]ind [N]eovim files" })
		vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "[F]ind [R]esume" })
		vim.keymap.set("n", "<leader>f.", fzf.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>/", fzf.blines, { desc = "[/] Fuzzily search in current buffer" })
	end,
}
