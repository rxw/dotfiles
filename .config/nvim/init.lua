-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keybindings
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save with <leader>w
keymap("n", "<leader>w", ":w<CR>", opts)
-- Smart window closing
vim.keymap.set("n", "<leader>q", function()
	-- Check how many windows are open
	if #vim.api.nvim_list_wins() > 1 then
		vim.cmd("close") -- just close this window
	else
		vim.cmd("quit") -- quit Neovim if this is the last one
	end
end, { desc = "Close window or quit", noremap = true, silent = true })

-- Use H and L to move between buffers (you can swap to tabs if you prefer)
keymap("n", "H", ":bprev<CR>", opts)
keymap("n", "L", ":bnext<CR>", opts)

-- Number settings: absolute on current, relative on others
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2 -- Number of visual spaces per tab
vim.opt.shiftwidth = 2 -- Spaces per indent
vim.opt.expandtab = true -- Use spaces instead of tabs

-- Make nvim use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Navigate splits
vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Go Left" })
vim.keymap.set("n", "<leader>j", "<C-w>j", { desc = "Go Down" })
vim.keymap.set("n", "<leader>k", "<C-w>k", { desc = "Go Up" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Go Right" })

-- Split vertical or horizontal
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Horizontal Split" })

require("config.lazy")
