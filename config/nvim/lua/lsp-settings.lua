-- vim.lsp.set_log_level("debug")
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { virtual_text = { prefix = "●" } }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

local icons = require("nvim-nonicons")
vim.fn.sign_define("DiagnosticSignError", { text = icons.get("x-circle"), texthl = "DiagnosticSignError" })

vim.fn.sign_define("DiagnosticSignWarn", { text = icons.get("alert"), texthl = "DiagnosticSignWarn" })

vim.fn.sign_define("DiagnosticSignInfo", { text = icons.get("info"), texthl = "DiagnosticSignInfo" })

vim.fn.sign_define("DiagnosticSignHint", { text = icons.get("comment"), texthl = "DiagnosticSignHint" })

vim.api.nvim_command("highlight default link LspCodeLens NonText")
vim.api.nvim_command("highlight default link LspCodeLensSeparator NonText")

-- keymaps
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap(
    "n",
    "<Leader>p",
    -- null-ls might run prettier and blade-formatter, which should have higher precedence than formatting by html and php language servers
    "<cmd>lua vim.lsp.buf.formatting_seq_sync(nil, 1000, { 'html', 'php', 'null-ls' })<CR>",
    opts
  )
  buf_set_keymap("n", "<Leader>P", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("v", "<Leader>p", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  buf_set_keymap("n", "<Leader>l", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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

  if client.resolved_capabilities.code_lens then
    vim.cmd([[
    augroup lsp_codelens
      autocmd! * <buffer>
      autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    augroup END
    ]])
  end

  if client.server_capabilities.colorProvider then
    require("lsp-documentcolors").buf_attach(bufnr, { single_column = true })
  end
end

-- config that activates keymaps and enables snippet support
local function get_config(server_name)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  capabilities.textDocument.colorProvider = { dynamicRegistration = false }
  local config = {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }

  if server_name == "sumneko_lua" then
    config = require("lua-dev").setup({ lspconfig = config })
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
    config.root_dir = require("lspconfig/util").root_pattern(
      "*.cabal",
      "stack.yaml",
      "cabal.project",
      "package.yaml",
      "hie.yaml",
      ".git"
    )
  end

  return config
end

local function setup_rust_analyzer(config)
  require("rust-tools").setup({
    server = vim.tbl_extend("force", get_config("rust_analyzer"), config or {}),
    tools = {
      inlay_hints = {
        highlight = "NonText",
        only_current_line = true,
      },
    },
  })
end

-- setup servers

-- setup manually installed servers
local servers = {}
table.insert(servers, "null-ls")
if vim.fn.executable("xcrun") == 1 or vim.fn.executable("sourcekit-lsp") == 1 then
  table.insert(servers, "sourcekit")
end
-- when on arch, most LSPs will be installed manually
if vim.fn.executable("pacman") == 1 then
  table.insert(servers, "bashls")
  table.insert(servers, "clangd")
  table.insert(servers, "cmake")
  table.insert(servers, "dockerls")
  table.insert(servers, "gopls")
  table.insert(servers, "hls")
  table.insert(servers, "intelephense")
  table.insert(servers, "pyright")
  table.insert(servers, "rust_analyzer")
  table.insert(servers, "sumneko_lua")
  table.insert(servers, "svelte")
  table.insert(servers, "tailwindcss")
  table.insert(servers, "texlab")
  table.insert(servers, "tsserver")
  table.insert(servers, "vimls")
  table.insert(servers, "vuels")
  table.insert(servers, "yamlls")
  table.insert(servers, "zk")
end

-- setup the servers in the table
for _, server in pairs(servers) do
  if server == "rust_analyzer" then
    setup_rust_analyzer()
  else
    require("lspconfig")[server].setup(get_config(server))
  end
end

-- setup servers installed via nvim-lsp-installer
require("nvim-lsp-installer").on_server_ready(function(server)
  if server.name == "rust_analyzer" then
    setup_rust_analyzer(server:get_default_options())
  else
    server:setup(get_config(server.name))
  end
end)

-- UI just like `:LspInfo` to show which capabilities each attached server has
vim.api.nvim_command("command! LspCapabilities lua require'lsp-capabilities'()")
