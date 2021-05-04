-- vim.lsp.set_log_level("debug")
-- needs https://github.com/microsoft/vscode-codicons/blob/master/dist/codicon.ttf
require("vim.lsp.protocol").CompletionItemKind =
    {
      "  Text", -- = 1
      "  Function", -- = 2;
      "  Method", -- = 3;
      "  Constructor", -- = 4;
      "  Field", -- = 5;
      "  Variable", -- = 6;
      "  Class", -- = 7;
      "  Interface", -- = 8;
      "  Module", -- = 9;
      "  Property", -- = 10;
      "  Unit", -- = 11;
      "  Value", -- = 12;
      "  Enum", -- = 13;
      "  Keyword", -- = 14;
      "  Snippet", -- = 15;
      "  Color", -- = 16;
      "  File", -- = 17;
      "  Reference", -- = 18;
      "  Folder", -- = 19;
      "  EnumMember", -- = 20;
      "  Constant", -- = 21;
      "  Struct", -- = 22;
      "  Event", -- = 23;
      "  Operator", -- = 24;
      "  TypeParameter" -- = 25;
    }

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    function(...)
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                   { virtual_text = { prefix = "●" } })(...)
    end

vim.fn.sign_define("LspDiagnosticsSignError",
                   { text = "", texthl = "LspDiagnosticsSignError" })

vim.fn.sign_define("LspDiagnosticsSignWarning",
                   { text = "", texthl = "LspDiagnosticsSignWarning" })

vim.fn.sign_define("LspDiagnosticsSignInformation",
                   { text = "", texthl = "LspDiagnosticsSignInformation" })

vim.fn.sign_define("LspDiagnosticsSignHint",
                   { text = "", texthl = "LspDiagnosticsSignHint" })

-- keymaps
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>",
                 opts)
  buf_set_keymap("n", "<Leader>wa",
                 "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wr",
                 "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wl",
                 "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                 opts)
  buf_set_keymap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>",
                 opts)
  buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<Leader>e",
                 "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<Leader>q",
                 "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<Leader>p",
                 "<cmd>lua require'lsp-formatting-chain'.formatting_chain_sync(nil, 1000, { 'html', 'php', 'efm' })<CR>",
                 opts)
  buf_set_keymap("n", "<Leader>P", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("v", "<Leader>p",
                 "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = "LuaJIT",
      path = vim.split(package.path, ";")
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" }
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
      }
    }
  }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach
  }
end

-- lsp-install
local function setup_servers()
  require"lspinstall".setup()

  -- get all installed servers
  local servers = require"lspinstall".installed_servers()
  -- ... and add manually installed servers
  table.insert(servers, "sourcekit")
  table.insert(servers, "hls")

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then config.settings = lua_settings end
    if server == "sourcekit" then
      config.filetypes = { "swift", "objective-c", "objective-cpp" }; -- we don't want c and cpp!
    end
    if server == "clangd" then
      config.filetypes = { "c", "cpp" }; -- we don't want objective-c and objective-cpp!
    end
    if server == "efm" then
      config = vim.tbl_extend("force", config, require "efm")
    end
    if server == "diagnosticls" then
      config = vim.tbl_extend("force", config, require "diagnosticls")
    end
    if server == "tailwindcss" then
      config.on_attach = require"tailwindcss-colorizer".wrap_on_attach(
                             config.on_attach)
    end
    if server == "vim" then config.init_options = { isNeovim = true } end
    if server == "hls" then
      config.root_dir = require"lspconfig/util".root_pattern("*.cabal",
                                                             "stack.yaml",
                                                             "cabal.project",
                                                             "package.yaml",
                                                             "hie.yaml", ".git");
    end

    require"lspconfig"[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require"lspinstall".post_install_hook = function()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- UI just like `:LspInfo` to show which capabilities each attached server has
vim.api.nvim_command("command! LspCapabilities lua require'lsp-capabilities'()")
