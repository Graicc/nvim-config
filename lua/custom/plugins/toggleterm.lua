-- powershell
if vim.fn.has('win32') then
	vim.opt.shell = 'pwsh'
	vim.opt.shellcmdflag =
	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
	vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
end
if vim.fn.has('linux') then
	vim.opt.shell = 'zsh'
	vim.opt.shellcmdflag = "-c"
	vim.opt.shellredir = ""
	vim.opt.shellpipe = ""
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
end

vim.cmd [[autocmd BufWinEnter,WinEnter term://* startinsert]]

return {
	'akinsho/toggleterm.nvim',
	--lazy = true,
	version = "*",
	opts = {},
	config = function()
		require('toggleterm').setup()
		local Terminal = require('toggleterm.terminal').Terminal

		local lazygit  = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "double",
			},
			-- function to run on opening the terminal
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
					{ noremap = true, silent = true })
			end,
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end
	end,
	keys = {
		{ "<leader>`",  "<cmd> ToggleTerm <cr>",                desc = "Toggle Terminal" },
		{ "<leader>tf", "<cmd> ToggleTerm direction=float<cr>", desc = "Toggle Float Terminal" },
		{ "<esc>",      [[<c-\><c-n>]],                         mode = 't' },
		{ "<c-w>",      [[<c-\><c-n><c-w>]],                    mode = 't' },
		{
			"<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", noremap = true, silent = true, desc = 'lazygit'
		}
	}
}
