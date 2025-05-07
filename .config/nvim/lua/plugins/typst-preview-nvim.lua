return {
	"chomosuke/typst-preview.nvim",
	ft = "typst",
	version = "1.*",
	opts = {
		dependencies_bin = { ["tinymist"] = "tinymist" },
		open_cmd = vim.fn.has("wsl") == 1 and "firefox.exe --new-window %s" or "firefox --new-window %s",
	},
}
