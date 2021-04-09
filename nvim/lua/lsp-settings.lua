-- vim.lsp.set_log_level("debug")

-- needs https://github.com/microsoft/vscode-codicons/blob/master/dist/codicon.ttf
require('vim.lsp.protocol').CompletionItemKind = {
  '  Text';          -- = 1
  '  Function';      -- = 2;
  '  Method';        -- = 3;
  '  Constructor';   -- = 4;
  '  Field';         -- = 5;
  '  Variable';      -- = 6;
  '  Class';         -- = 7;
  '  Interface';     -- = 8;
  '  Module';        -- = 9;
  '  Property';      -- = 10;
  '  Unit';          -- = 11;
  '  Value';         -- = 12;
  '  Enum';          -- = 13;
  '  Keyword';       -- = 14;
  '  Snippet';       -- = 15;
  '  Color';         -- = 16;
  '  File';          -- = 17;
  '  Reference';     -- = 18;
  '  Folder';        -- = 19;
  '  EnumMember';    -- = 20;
  '  Constant';      -- = 21;
  '  Struct';        -- = 22;
  '  Event';         -- = 23;
  '  Operator';      -- = 24;
  '  TypeParameter'; -- = 25;
}

local function range_formatting_sync(options, timeout_ms, start_pos, end_pos)
  local sts = vim.bo.softtabstop;
  options = vim.tbl_extend('keep', options or {}, {
    tabSize = (sts > 0 and sts) or (sts < 0 and vim.bo.shiftwidth) or vim.bo.tabstop;
    insertSpaces = vim.bo.expandtab;
  })
  local params = vim.lsp.util.make_given_range_params(start_pos, end_pos)
  params.options = options
  local result = vim.lsp.buf_request_sync(0, "textDocument/rangeFormatting", params, timeout_ms)
  if not result or vim.tbl_isempty(result) then return end
  local _, range_formatting_result = next(result)
  result = range_formatting_result.result
  if not result then return end
  vim.lsp.util.apply_text_edits(result)
end

function _G.buf_format()
  local formatting = false
  local range_formatting = false

  for _, client in pairs(vim.lsp.buf_get_clients()) do
    if client.resolved_capabilities.document_formatting then
      formatting = true
    end
    if client.resolved_capabilities.document_range_formatting then
      range_formatting = true
    end
  end

  if formatting then
    vim.lsp.buf.formatting_sync(nil, 1000)
  end

  -- format the whole range
  -- this is needed because some LSPs only provide range formatting
  if range_formatting then
    local last_line = vim.fn.line("$")
    local last_col = vim.fn.col({last_line, "$"})
    range_formatting_sync({}, 1000, {1,0}, {last_line, last_col})
  end

  vim.cmd("Prettier")
end

function _G.buf_range_format()
  local range_formatting = false

  for _, client in pairs(vim.lsp.buf_get_clients()) do
    if client.resolved_capabilities.document_range_formatting then
      range_formatting = true
    end
  end

  if range_formatting then
    range_formatting_sync({}, 1000)
  end

  vim.cmd("PrettierPartial")
end

vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua buf_format()<CR>", { noremap=true })
vim.api.nvim_set_keymap("v", "<space>f", "<cmd>lua buf_range_format()<CR>", { noremap=true })

-- keymaps
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

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
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
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
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  require'lspinstall'.setup()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()
  -- ... and add manually installed servers
  table.insert(servers, "sourcekit")

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end
    if server == "sourcekit" then
      config.filetypes = {"swift", "objective-c", "objective-cpp"}; -- we don't want c and cpp!
    end
    if server == "clangd" then
      config.filetypes = {"c", "cpp"}; -- we don't want objective-c and objective-cpp!
    end
    if server == "efm" then
      config = vim.tbl_extend("force", config, require'efm')
    end
    if server == "diagnosticls" then
      config = vim.tbl_extend("force", config, require'diagnosticls')
    end
    if server == "tailwindcss" then
      config.on_attach = require'tailwindcss-colorizer'.wrap_on_attach(config.on_attach)
    end
    -- if server == "vim" then
    --   config.init_options.isNeovim = true
    -- end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end
