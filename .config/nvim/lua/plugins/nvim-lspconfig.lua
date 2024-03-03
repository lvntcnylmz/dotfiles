local config = function()
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local diagnostic_signs = require("util.icons").diagnostics
	local lspconfig = require("lspconfig")
	-- local lspui = require("lspconfig.ui.windows")
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- diagnostic signs for sign column
	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- lspui.default_opts.border = "double"

	-- vim.diagnostic.config({
	-- 	underline = true,
	-- 	update_in_insert = false,
	-- 	float = {
	-- 		focusable = false,
	-- 		style = "default",
	-- 		border = "rounded",
	-- 		source = "always",
	-- 		header = "Diagnostics:",
	-- 	},
	-- 	virtual_text = {
	-- 		spacing = 3,
	-- 		source = "if_many",
	-- 	},
	-- 	severity_sort = true,
	-- })

	-- start other plugins
	require("autoclose").setup()
	require("luasnip.loaders.from_vscode").lazy_load()
	require("neodev").setup({})

	-- lspconfig.efm.setup({})
	lspconfig.ast_grep.setup({
		capabilities = capabilities,
		filetypes = {
			"html",
			"css",
		},
	})

	lspconfig.clangd.setup({
		capabilities = capabilities,
	})
	lspconfig.tsserver.setup({
		capabilities = capabilities,
	})
	lspconfig.jdtls.setup({
		capabilities = capabilities,
	})
	lspconfig.omnisharp.setup({
		capabilities = capabilities,
		organize_imports_on_format = true,
	})
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})
end

local keys = function()
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
	vim.keymap.set("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })

	-- Use LspAttach autocommand to only map the following keys
	-- after the language server attaches to the current buffer
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Enable completion triggered by <c-x><c-o>
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf }
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			-- vim.keymap.set("n", "<space>f", function()
			--     vim.lsp.buf.format({ async = true, lsp_fallback = true })
			-- end, opts)
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	event = "FileType",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"m4xshen/autoclose.nvim",
		-- { "j-hui/fidget.nvim", opts = {} },
	},
	config = config,
	keys = keys,
}
