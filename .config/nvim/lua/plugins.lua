return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto",
					section_separators = "",
					component_separators = "",
					icons_enabled = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-frappe]])
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				rust = { "rustfmt" },
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					layout_config = { prompt_position = "top" },
					sorting_strategy = "ascending",
					winblend = 10,
				},
			})

			vim.keymap.set("n", "<leader>p", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
			vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
			vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "Switch Buffer" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			local on_attach = function(client, bufnr)
				require("lsp_signature").on_attach({
					bind = true,
					hint_enable = true,
					handler_opts = { border = "rounded" },
				}, bufnr)
				-- put this in your on_attach function
				local buf = vim.lsp.buf

				vim.keymap.set("n", "<leader>d", buf.definition, { desc = "Go to definition" })
				vim.keymap.set("n", "<leader>D", buf.declaration, { desc = "Go to Declaration" })
				vim.keymap.set("n", "<leader>r", buf.references, { desc = "Find refrences" })
				vim.keymap.set("n", "<leader>i", buf.implementation, { desc = "Go to implementation" })
				vim.keymap.set("n", "<leader>y", buf.type_definition, { desc = "Go to type definition" })
				vim.keymap.set("n", "K", buf.hover)
				vim.keymap.set("n", "<leader>rn", buf.rename, { desc = "Rename symbol" })
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("lspconfig").ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			require("lspconfig").rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						procMacro = {
							enable = true,
						},
						checkOnSave = {
							extraArgs = { "--cfg", "anchor-debug" },
						},
					},
				},
			})
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP completion source
			"hrsh7th/cmp-buffer", -- Buffer words
			"hrsh7th/cmp-path", -- File paths
			"hrsh7th/cmp-cmdline", -- Commands
			"L3MON4D3/LuaSnip", -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				hint_enable = true,
				handler_opts = {
					border = "rounded",
				},
				floating_window = true,
				floating_window_above_cur_line = true,
			})
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "flake8" },
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				rust = { "clippy" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- show buffers (not tabs)
					diagnostics = "nvim_lsp",
					show_buffer_close_icons = true,
					show_close_icon = false,
					separator_style = "thin",
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"echasnovski/mini.bufremove",
		version = "*",
		config = function()
			local bufremove = require("mini.bufremove")
			vim.keymap.set("n", "<leader>q", bufremove.delete, { desc = "Smart Buffer Close" })
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- enables treesitter integration for smarter pairing
			})
		end,
	},
}
