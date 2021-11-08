-- vim:foldmethod=marker
local icons = require("nvim-nonicons")

-- {{{ coq

vim.g.coq_settings = {
  auto_start = 'shut-up',
  ["display.icons.mappings"] = {
    Boolean = "",
    -- Character = "",
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "",
    Number = "",
    Operator = "",
    Parameter = "",
    Property = "",
    Reference = "",
    Snippet = "",
    String = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
  }
}

-- }}} ]]

-- {{{ lspkind

require('lspkind').init {
  preset = 'codicons',
}

-- }}}

-- {{{ cmp

local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local function feedkey(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = require("lspkind").presets.codicons[vim_item.kind] .. " " .. vim_item.kind

      -- set a name for each source
      vim_item.menu = ({
        nvim_lsp      = "[LSP]",
        buffer        = "[Buffer]",
        nvim_lua      = "[Lua]",
        tags          = "[Tags]",
        vsnip         = "[Snippet]",
        path          = "[Path]",
        tmux          = "[Tmux]",
        latex_symbols = "[LaTeX]",
        spell         = "[Spell]",
      })[entry.source.name]

      return vim_item
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(
    function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif check_back_space() then
        fallback()
      elseif vim.fn['vsnip#jumpable'](1) == 1 then
        feedkey('<Plug>(vsnip-jump-next)', '')
      else
        fallback()
      end
    end,
    { "i", "s" }
    ),
    ['<S-Tab>'] = cmp.mapping(
    function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      else
        fallback()
      end
    end,
    { "i", "s" }
    ),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'tags' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'tmux' },
    { name = 'latex_symbols' },
    { name = 'spell' },
    { name = 'treesitter' },
  },
}

-- }}}

-- treesitter {{{

require"nvim-treesitter.configs".setup { highlight = { enable = true }, indent = { enable = true } }

-- }}}

-- toggleterm {{{

require"toggleterm".setup { open_mapping = [[<c-\>]] }

-- }}}

-- gitsigns {{{

require("gitsigns").setup()

-- }}}

-- nvim-lightbulb {{{

function _G.update_lightbulb()
  require"nvim-lightbulb".update_lightbulb {
    sign = { enabled = false },
    float = { enabled = false },
    virtual_text = { enabled = true },
  }
end

vim.cmd [[autocmd CursorHold,CursorHoldI * lua update_lightbulb()]]

-- }}}

-- nvim-lspinstall {{{

-- function _G.lsp_reinstall_all()
--   local lspinstall = require "lspinstall"
--   for _, server in ipairs(lspinstall.installed_servers()) do lspinstall.install_server(server) end
-- end

-- vim.cmd [[command! -nargs=0 LspReinstallAll call v:lua.lsp_reinstall_all()]]

-- }}}

-- nvim-tree {{{

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
    ignored = "I",
  },
  folder = {
    default = icons.get("file-directory"),
    open = icons.get("file-directory"),
    empty = icons.get("file-directory-outline"),
    empty_open = icons.get("file-directory-outline"),
    symlink = icons.get("file-submodule"),
    symlink_open = icons.get("file-submodule"),
  },
  lsp = { error = "", warning = "", info = "", hint = "" },
}

vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_add_trailing = 1

require'nvim-tree'.setup {
  -- don't disable netrw because it's used by Neovim for downloading spell files
  disable_netrw       = false,
  -- hijack netrw window on startup
  hijack_netrw        = false,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = true,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = true,
  -- show lsp diagnostics in the signcolumn
  diagnostics         = {
    enable = true
  },
}

-- disable nvim tree autocmds --- they are buggy
vim.cmd "augroup NvimTreeView"
vim.cmd "au!"
vim.cmd "augroup END"

-- vim.cmd([[highlight NvimTreeGitDirty guifg=]] .. vim.g.terminal_color_11) -- orange
-- vim.cmd([[highlight NvimTreeGitMerge guifg=]] .. vim.g.terminal_color_9) -- dark red
-- vim.cmd [[highlight link NvimTreeCursorLine CurrentWord]]
-- vim.cmd [[highlight link NvimTreeFolderName NONE]]
-- vim.cmd [[highlight link NvimTreeEmptyFolderName NONE]]
-- vim.cmd([[highlight NvimTreeFolderName guifg=]] .. vim.g.terminal_color_4) -- blue
-- vim.cmd([[highlight NvimTreeEmptyFolderName guifg=]] .. vim.g.terminal_color_4) -- blue

-- function _G.auto_refresh_nvim_tree()
--   local tree = require "nvim-tree.lib"
--   if _G.nvim_tree_refresh_timer_id and
--       not vim.tbl_isempty(vim.fn.timer_info(_G.nvim_tree_refresh_timer_id)) then
--     return
--   end
--   _G.nvim_tree_refresh_timer_id = vim.fn.timer_start(2000, function(_)
--     if tree.win_open() then
--       tree.refresh_tree()
--     else
--       vim.fn.timer_stop(_G.nvim_tree_refresh_timer_id)
--       _G.nvim_tree_refresh_timer_id = nil
--     end
--   end, { ["repeat"] = -1 })
-- end
-- vim.api.nvim_command [[augroup nvimtree]]
-- vim.api.nvim_command [[autocmd Filetype NvimTree lua auto_refresh_nvim_tree()]]
-- vim.api.nvim_command [[augroup END]]

-- }}}

-- Telescope {{{

local actions = require("telescope.actions")
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["œ"] = actions.send_selected_to_qflist + actions.open_qflist, -- Alt-q on macOS
      },
      n = {
        ["œ"] = actions.send_selected_to_qflist + actions.open_qflist, -- Alt-q on macOS
      },
    },
  },
}

require("telescope").load_extension("dap")
-- require("telescope").load_extension("fzf")

-- }}}

-- lsp-trouble {{{

require"trouble".setup {
  signs = {
    error = icons.get("x-circle"),
    warning = icons.get("alert"),
    information = icons.get("info"),
    hint = icons.get("comment"),
    other = icons.get("circle"),
  },
}

-- }}}

-- lualine {{{

local function lsp_servers_status()
  local clients = vim.lsp.buf_get_clients(0)
  if vim.tbl_isempty(clients) then return "" end

  local client_names = {}
  for _, client in pairs(clients) do table.insert(client_names, client.name) end

  return icons.get("zap") .. " " .. table.concat(client_names, "|")
end

require("lualine").setup {
  options = { theme = "rose-pine" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "branch", icon = icons.get("git-branch") }, { "diff", colored = false } },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      "lsp_progress",
      {
        "diagnostics",
        symbols = {
          error = icons.get("x-circle") .. " ",
          warn = icons.get("alert") .. " ",
          info = icons.get("info") .. " ",
        },
        sources = { "nvim_lsp" },
      },
    },
    lualine_y = {
      {
        "encoding",
        condition = function()
          -- when filencoding="" lualine would otherwise report utf-8 anyways
          return vim.bo.fileencoding and #vim.bo.fileencoding > 0 and vim.bo.fileencoding ~= "utf-8"
        end,
      },
      {
        "fileformat",
        condition = function() return vim.bo.fileformat ~= "unix" end,
        icons_enabled = false,
      },
      { "filetype", icons_enabled = false },
    },
    lualine_z = { lsp_servers_status },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" },
}

-- }}}

-- zen-mode {{{

require"zen-mode".setup {
  window = { backdrop = 1, options = { signcolumn = "no" } },
  plugins = { tmux = true },
}

-- }}}

-- {{{ nvim-lint
require"lint".linters_by_ft = {
  sh = { "shellcheck" },
  -- javascript = { "eslint-local" },
  -- typescript = { "eslint-local" },
  -- html = { "tidy" },
  -- go = { "revive" },
  vim = { "vint" },
  -- php = { "phpstan" },
  python = { "flake8" },
  -- yaml = { "yamllint" },
  -- make = { "checkmake" },
}

vim.cmd [[autocmd CursorHold,CursorHoldI <buffer> lua require'lint'.try_lint()]]
-- }}}

-- {{{ catppuccino

-- require"catppuccino".setup {
--   colorscheme = "neon_latte",
--   term_colors = true,
--   styles = {
--     comments = "italic",
--     functions = "italic",
--     keywords = "italic",
--     strings = "NONE",
--     variables = "NONE",
--   },
--   integrations = {
--     treesitter = true,
--     native_lsp = {
--       enabled = true,
--       virtual_text = {
--         errors = "italic",
--         hints = "italic",
--         warnings = "italic",
--         information = "italic",
--       },
--       underlines = {
--         errors = "underline",
--         hints = "underline",
--         warnings = "underline",
--         information = "underline",
--       }
--     },
--     lsp_trouble = true,
--     gitsigns = true,
--     telescope = true,
--     nvimtree = {
--       enabled = true,
--       show_root = true,
--     },
--     vim_sneak = true,
--     markdown = true,
--   }
-- }

-- vim.cmd [[colorscheme catppuccino]]

-- }}}

-- {{{ comments.nvim

require"Comment".setup()

-- }}}

-- {{{ which-key

require"which-key".setup()

-- }}}
