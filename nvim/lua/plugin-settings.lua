--------
-- compe
--------

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    -- treesitter = true;
    tmux = true;
    latex_symbols = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {expr = true, silent=true, noremap = true})
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true, silent=true, noremap = true})
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", {expr = true, silent=true, noremap = true})
vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", {expr = true, silent=true, noremap = true})
vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", {expr = true, silent=true, noremap = true})


-------------
-- treesitter
-------------

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}


----------------
-- tmux-complete
----------------

do
  local compe = require'compe'
  local Source = {}

  function Source.get_metadata(_)
    return {
      priority = 10,
      dup = 0,
      menu = '[Tmux]'
    }
  end

  function Source.determine(_, context)
    return compe.helper.determine(context)
  end

  function Source.complete(_, context)
    vim.fn["tmuxcomplete#async#gather_candidates"](function (items)
      context.callback({ items = items })
    end)
  end

  compe.register_source('tmux', Source)
end


-------------
-- toggleterm
-------------

require"toggleterm".setup { open_mapping = [[<c-\>]], }


-----------
-- gitsigns
-----------

require('gitsigns').setup()


-----------------
-- nvim-lightbulb
-----------------

function _G.update_lightbulb()
  require'nvim-lightbulb'.update_lightbulb {
    sign = {
      enabled = false
    },
    float = {
      enabled = false
    },
    virtual_text = {
      enabled = true
    }
  }
end

vim.cmd [[autocmd CursorHold,CursorHoldI * lua update_lightbulb()]]


------------------
-- nvim-lspinstall
------------------

function _G.lsp_reinstall_all()
  local lspinstall = require'lspinstall'
  for _, server in ipairs(lspinstall.installed_servers()) do
    lspinstall.install_server(server)
  end
end

vim.cmd [[command! -nargs=0 LspReinstallAll call v:lua.lsp_reinstall_all()]]


------------
-- nvim-tree
------------

do
  local icons = require("nvim-nonicons")
  vim.g.nvim_tree_icons = {
    default = icons.get("file"),
    symlink = icons.get("file-symlink"),
    git = {
      -- unstaged = icons.get("diff-modified"),
      -- staged = icons.get("check-circle"),
      -- unmerged = icons.get("git-merge"),
      -- renamed = icons.get("diff-renamed"),
      -- untracked = icons.get("diff-added"),
      -- deleted = icons.get("diff-removed"),
      -- ignored = icons.get("diff-ignored")
      unstaged = "M",
      staged = "S",
      unmerged = icons.get("git-merge"),
      renamed = "R",
      untracked = "U",
      deleted = "D",
      ignored = "I"
    },
    folder = {
      default = icons.get("file-directory"),
      open = icons.get("file-directory-outline"),
      empty = icons.get("file-directory-outline"),
      empty_open = icons.get("file-directory-outline"),
      symlink = icons.get("file-submodule"),
      symlink_open = icons.get("file-submodule"),
    }
  }
  vim.g.nvim_tree_group_empty = 1
  vim.g.nvim_tree_add_trailing = 1
  vim.cmd([[highlight NvimTreeGitDirty guifg=]] .. vim.g.terminal_color_11) -- orange
  vim.cmd([[highlight NvimTreeGitMerge guifg=]] .. vim.g.terminal_color_9) -- dark red
  vim.cmd([[highlight NvimTreeFolderName guifg=]] .. vim.g.terminal_color_4) -- blue
  vim.cmd([[highlight NvimTreeEmptyFolderName guifg=]] .. vim.g.terminal_color_4) -- blue
end


---------------
-- lspkind-nvim
---------------

require('lspkind').init({
  with_text = true,
  symbol_map = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
  },
})
