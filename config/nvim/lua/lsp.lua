-- vim:foldmethod=marker

require("neodev").setup() -- must be called before lspconfig

local M = {}

--- {{{ visual

-- vim.lsp.set_log_level("debug")

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    prefix = "●",
  },
  float = {
    border = "rounded",
  },
  severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local icons = require("nvim-nonicons")
vim.fn.sign_define("DiagnosticSignError", { text = icons.get("x-circle"), texthl = "DiagnosticSignError" })

vim.fn.sign_define("DiagnosticSignWarn", { text = icons.get("alert"), texthl = "DiagnosticSignWarn" })

vim.fn.sign_define("DiagnosticSignInfo", { text = icons.get("info"), texthl = "DiagnosticSignInfo" })

vim.fn.sign_define("DiagnosticSignHint", { text = icons.get("comment"), texthl = "DiagnosticSignHint" })

vim.cmd("highlight default link LspCodeLens NonText")
vim.cmd("highlight default link LspCodeLensSeparator NonText")

--- }}}

--- {{{ keymaps

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

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

vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- }}}

--- {{{ attach

function M.on_attach(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
  end

  if client.server_capabilities.codeLensProvider then
    vim.cmd([[
    augroup lsp_codelens
      autocmd! * <buffer>
      " autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    augroup END
    ]])
  end

  if client.server_capabilities.colorProvider then
    require("document-color").buf_attach(bufnr)
  end
end

--- }}}

--- {{{ server configs

-- config that activates keymaps and enables snippet support
function M.get_config(server_name)
  local capabilities = require("cmp_nvim_lsp").default_capabilities() -- would maybe be better to use make_client_capabilities() too
  capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  local config = {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = M.on_attach,
  }

  if server_name == "basedpyright" then
    config.settings = {
      python = {
        pythonPath = vim.system({ "uv", "python", "find" }, { text = true }):wait().stdout:gsub("\n", ""),
      },
    }
  end
  if server_name == "lua_ls" then
    config.settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
      },
    }
  end
  if server_name == "sourcekit" then
    config.filetypes = { "swift", "objective-c", "objective-cpp" } -- we don't want c and cpp!
  end
  if server_name == "clangd" then
    config.filetypes = { "c", "cpp" } -- we don't want objective-c and objective-cpp!
  end
  if server_name == "vim" then
    config.init_options = { isNeovim = true }
  end
  if server_name == "haskell" then
    config.root_dir = require("lspconfig.util").root_pattern(
      "*.cabal",
      "stack.yaml",
      "cabal.project",
      "package.yaml",
      "hie.yaml",
      ".git"
    )
  end
  if server_name == "ltex" then
    config.on_attach = function(client, bufnr)
      M.on_attach(client, bufnr)
      require("ltex_extra").setup({
        load_langs = { "en-US", "de-DE" },
        path = vim.fn.stdpath("data") .. "/ltex",
      })
    end
    config.settings = {
      ltex = {
        additionalRules = {
          motherTongue = "de-DE",
        },
      },
    }
    config.filetypes = { "gitcommit", "plaintex", "tex" }
  end
  if server_name == "jsonls" then
    config.settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    }
  end

  return config
end

--- }}}

--- {{{ setup servers

local servers = {
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "dockerls",
  "docker_compose_language_service",
  "eslint",
  "gopls",
  "hls",
  "html",
  "intelephense",
  "jsonls",
  "ltex",
  "kotlin_language_server",
  "basedpyright",
  "ruff",
  "lua_ls",
  "svelte",
  "tailwindcss",
  "taplo",
  "texlab",
  "ts_ls",
  "typst_lsp",
  "vimls",
  "volar",
  "yamlls",
}

if vim.fn.executable("xcrun") == 1 or vim.fn.executable("sourcekit-lsp") == 1 then
  table.insert(servers, "sourcekit")
end

-- setup the servers in the table
for _, server in pairs(servers) do
  require("lspconfig")[server].setup(M.get_config(server))
end

-- }}}

return M
