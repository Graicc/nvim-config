-- powershell
vim.opt.shell = 'pwsh'
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""

vim.cmd [[autocmd BufWinEnter,WinEnter term://* startinsert]]

return {
	'akinsho/toggleterm.nvim',
	version = "*",
	opts = {},
	keys = {
		{ "<leader>`",  "<cmd> ToggleTerm <cr>",                desc = "Toggle Terminal" },
		{ "<leader>tf", "<cmd> ToggleTerm direction=float<cr>", desc = "Toggle Float Terminal" },
		{ "<esc>",      [[<c-\><c-n>]],                         mode = 't' },
		{ "<c-w>",      [[<c-\><c-n><c-w>]],                    mode = 't' }
	}
}
