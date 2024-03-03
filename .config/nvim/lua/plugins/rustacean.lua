return {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    lazy = true,
    init = function()
        vim.g.rustaceanvim = function()
            local ok, mason_registry = pcall(require, "mason-registry")
            local adapter ---@type any
            if ok then
                -- rust tools configuration for debugging support
                local codelldb = mason_registry.get_package("codelldb")
                local extension_path = codelldb:get_install_path() .. "/extension/"
                local codelldb_path = extension_path .. "adapter/codelldb"
                local liblldb_path = ""
                if vim.loop.os_uname().sysname:find("Windows") then
                    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
                elseif vim.fn.has("mac") == 1 then
                    liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
                else
                    liblldb_path = extension_path .. "lldb/lib/liblldb.so"
                end
                adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
            end
            return {
                dap = adapter,

                server = {
                    on_attach = function(_, bufnr)
                        vim.lsp.inlay_hint.enable(bufnr, true)
                        vim.keymap.set("n", "K", "<cmd>RustLSP hover actions<cr>", { desc = "Hover Actions (Rust)" })
                        vim.keymap.set(
                            "n",
                            "<leader>cR",
                            "<cmd>RustLsp codeAction<cr>",
                            { desc = "Code Action (Rust)" }
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>dr",
                            "<cmd>RustLsp debuggables<cr>",
                            { desc = "Run Debuggables (Rust)" }
                        )
                    end,
                    settings = {
                        -- rust-analyzer language server configuration
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true,
                            },
                            -- Add clippy lints for Rust.
                            checkOnSave = {
                                allFeatures = true,
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                        },
                    },
                },
                tools = {
                    on_initialized = function()
                        vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
                    end,
                },
            }
        end
    end,
}
