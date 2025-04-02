-- Always set the keymap, even when no LSP is enabled
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaraion" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnsotic Description" })
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("x", "<leader>a", ":'<,'>lua vim.lsp.buf.range_code_action<CR>", { desc = "Code Action (Range)" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set({ "n", "x" }, "<leader>p", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("v", "<leader>p", ":'<,'>lua vim.lsp.buf.range_formatting<CR>", { desc = "Format Selection" })
vim.keymap.set("n", "<leader>l", vim.lsp.codelens.run, { desc = "Run Code Lens" })

vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

vim.keymap.set("i", '<Tab>', function()
  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, {
  silent = true,
})

vim.lsp.enable("lua_ls")
