-- vim:foldmethod=marker

--- {{{ visual

-- vim.lsp.set_log_level("debug")

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    prefix = "●",
  },
  float = {
    source = true,
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

local keymap_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", keymap_opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", keymap_opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", keymap_opts)
vim.api.nvim_set_keymap("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", keymap_opts)

local on_attach = function(client, bufnr)
  -- Mappings.
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "x", "<Leader>a", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<Leader>wr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    keymap_opts
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<Leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    keymap_opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<Leader>p",
    -- null-ls might run prettier and blade-formatter, which should have higher precedence than formatting by html and php language servers
    "<cmd>lua vim.lsp.buf.formatting_seq_sync(nil, 1000, { 'html', 'php', 'null-ls' })<CR>",
    keymap_opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>P", "<cmd>lua vim.lsp.buf.formatting()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<Leader>p", ":'<,'>lua vim.lsp.buf.range_formatting()<CR>", keymap_opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>l", "<cmd>lua vim.lsp.codelens.run()<CR>", keymap_opts)

  -- vim already has builtin docs
  if vim.bo.ft ~= "vim" then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", keymap_opts)
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

--- }}}

--- {{{ server configs

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
    config.settings = {
      Lua = {
        completion = { callSnippet = "Disable" },
      },
    }
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
  if server_name == "ltex" then
    config.settings = {
      ltex = {
        additionalRules = {
          motherTongue = "de-DE",
        },
        disabledRules = {
          ["en-US"] = { "MORFOLOGIK_RULE_EN_US" }, -- possible spelling mistakes, I prefer vim's spell
        },
      },
    }
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

local function setup_zk(config)
  local zk = require("zk")
  local commands = require("zk.commands")

  zk.setup({
    picker = "telescope",
    lsp = {
      config = vim.tbl_extend("force", get_config("zk"), config or {}),
    },
  })

  local function make_edit_fn(defaults, picker_options)
    return function(options)
      options = vim.tbl_extend("force", defaults, options or {})
      zk.edit(options, picker_options)
    end
  end

  commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
  commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))

  vim.api.nvim_set_keymap("n", "<Leader>zc", "<cmd>ZkNew<CR>", { noremap = true })
  vim.api.nvim_set_keymap("x", "<Leader>zc", ":'<,'>ZkNewFromTitleSelection<CR>", { noremap = true })
  vim.api.nvim_set_keymap("x", "<Leader>zC", ":'<,'>ZkNewFromContentSelection<CR>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<leader>zn", "<cmd>ZkNotes { sort = { 'modified' } }<CR>", { noremap = true })
  vim.api.nvim_set_keymap(
    "n",
    "<leader>zf",
    "<cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>",
    { noremap = true }
  )
  vim.api.nvim_set_keymap("n", "<Leader>zb", "<cmd>ZkBacklinks<CR>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<Leader>zl", "<cmd>ZkLinks<CR>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<Leader>zt", "<cmd>ZkTags<CR>", { noremap = true })
  vim.api.nvim_set_keymap("x", "<Leader>zm", ":'<,'>ZkMatch<CR>", { noremap = true })

  require("telescope").load_extension("zk")
end

--- }}}

--- {{{ setup servers

-- setup manually installed servers
local servers = {}
if vim.fn.executable("xcrun") == 1 or vim.fn.executable("sourcekit-lsp") == 1 then
  table.insert(servers, "sourcekit")
end
-- when on arch, most LSPs will be installed manually
if vim.fn.executable("pacman") == 1 then
  table.insert(servers, "bashls")
  table.insert(servers, "clangd")
  table.insert(servers, "cmake")
  table.insert(servers, "cssls")
  table.insert(servers, "dockerls")
  table.insert(servers, "eslint")
  table.insert(servers, "gopls")
  table.insert(servers, "hls")
  table.insert(servers, "html")
  table.insert(servers, "intelephense")
  table.insert(servers, "jsonls")
  table.insert(servers, "ltex")
  table.insert(servers, "pyright")
  table.insert(servers, "rust_analyzer")
  table.insert(servers, "sumneko_lua")
  table.insert(servers, "svelte")
  table.insert(servers, "tailwindcss")
  table.insert(servers, "texlab")
  table.insert(servers, "tsserver")
  table.insert(servers, "vimls")
  table.insert(servers, "volar")
  table.insert(servers, "yamlls")
  table.insert(servers, "zk")
end

-- setup the servers in the table
for _, server in pairs(servers) do
  if server == "rust_analyzer" then
    setup_rust_analyzer()
  elseif server == "zk" then
    setup_zk()
  else
    require("lspconfig")[server].setup(get_config(server))
  end
end

-- setup servers installed via nvim-lsp-installer
require("nvim-lsp-installer").on_server_ready(function(server)
  if server.name == "rust_analyzer" then
    setup_rust_analyzer(server:get_default_options())
  elseif server.name == "zk" then
    setup_zk(server:get_default_options())
  else
    server:setup(get_config(server.name))
  end
end)

-- {{{ null-ls

require("null-ls").setup({
  on_attach = on_attach,
  sources = vim.tbl_filter(function(source)
    if source._opts and source._opts.command then
      return vim.fn.executable(source._opts.command) == 1 and source or nil
    else
      return source
    end
  end, {
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.prettier.with({
      command = "./node_modules/.bin/prettier",
    }),
    require("null-ls").builtins.formatting.rustywind,
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
  }),
})

-- }}}

-- }}}
