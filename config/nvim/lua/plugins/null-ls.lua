require("null-ls").setup({
  on_attach = require("lsp").on_attach,
  sources = {
    require("null-ls").builtins.formatting.stylua,
    -- require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.prettier.with({
      only_local = "node_modules/.bin",
    }),
    -- require("null-ls").builtins.formatting.shellharden,

    -- require("null-ls").builtins.diagnostics.codespell,
    require("null-ls").builtins.diagnostics.cppcheck,
    -- require("null-ls").builtins.diagnostics.flake8,
    -- require("null-ls").builtins.diagnostics.proselint,
    require("null-ls").builtins.diagnostics.selene,
    require("null-ls").builtins.diagnostics.shellcheck,
    require("null-ls").builtins.diagnostics.vint,
    -- require("null-ls").builtins.diagnostics.write_good,

    -- require("null-ls").builtins.code_actions.proselint,
  },
})
