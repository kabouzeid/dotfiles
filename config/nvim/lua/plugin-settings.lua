-- vim:foldmethod=marker
local icons = require("nvim-nonicons")

-- {{{ nvim-cmp

local completion_item_kinds = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "", -- 
  Property = "",
  Unit = "",
  Value = "", -- 
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = completion_item_kinds[vim_item.kind] .. " " .. vim_item.kind
      vim_item.menu = entry.source.name
      return vim_item
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "vsnip" },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "tags" },
    { name = "path" },
    { name = "buffer" },
    { name = "latex_symbols" },
    { name = "treesitter" },
  },
})

-- }}}

-- {{{ vsnip

vim.cmd([[
  imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
  smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

  nmap        <C-s>   <Plug>(vsnip-select-text)
  xmap        <C-s>   <Plug>(vsnip-select-text)
  nmap        <A-s>   <Plug>(vsnip-cut-text)
  xmap        <A-s>   <Plug>(vsnip-cut-text)
]])

-- }}}

-- treesitter {{{

require("nvim-treesitter.configs").setup({ highlight = { enable = true }, indent = { enable = true } })

-- }}}

-- toggleterm {{{

require("toggleterm").setup({ open_mapping = [[<c-\>]] })

-- }}}

-- gitsigns {{{

require("gitsigns").setup()

-- }}}

-- nvim-lightbulb {{{

function _G.update_lightbulb()
  require("nvim-lightbulb").update_lightbulb({
    sign = { enabled = false },
    float = { enabled = false },
    virtual_text = { enabled = true },
  })
end

vim.cmd([[autocmd CursorHold,CursorHoldI * lua update_lightbulb()]])

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

require("nvim-tree").setup({
  -- don't disable netrw because it's used by Neovim for downloading spell files
  disable_netrw = false,
  -- hijack netrw window on startup
  hijack_netrw = false,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor = true,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd = true,
  -- show lsp diagnostics in the signcolumn
  diagnostics = { enable = true },
})

-- disable nvim tree autocmds --- they are buggy
vim.cmd("augroup NvimTreeView")
vim.cmd("au!")
vim.cmd("augroup END")

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
-- vim.cmd [[augroup nvimtree]]
-- vim.cmd [[autocmd Filetype NvimTree lua auto_refresh_nvim_tree()]]
-- vim.cmd [[augroup END]]

vim.cmd("nnoremap <leader>tt <cmd>NvimTreeToggle<cr>")
vim.cmd("nnoremap <leader>tf <cmd>NvimTreeFindFile<cr>")
vim.cmd("nnoremap <leader>tr <cmd>NvimTreeRefresh<cr>")

-- }}}

-- Telescope {{{

local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
})

require("telescope").load_extension("dap")

vim.api.nvim_set_keymap("n", "<Leader>fp", "<cmd>Telescope<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { noremap = true })

-- }}}

-- lsp-trouble {{{

require("trouble").setup({
  signs = {
    error = icons.get("x-circle"),
    warning = icons.get("alert"),
    information = icons.get("info"),
    hint = icons.get("comment"),
    other = icons.get("circle"),
  },
})

-- }}}

-- lualine {{{

local function lsp_servers_status()
  local clients = vim.lsp.buf_get_clients(0)
  if vim.tbl_isempty(clients) then
    return ""
  end

  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end

  return icons.get("zap") .. " " .. table.concat(client_names, "|")
end

local function snippet_jump_status()
  if vim.fn["vsnip#jumpable"](1) == 1 then
    return " "
  elseif vim.fn["vsnip#jumpable"](-1) == 1 then
    return " "
  end
  return ""
end

require("lualine").setup({
  options = { theme = vim.g.colors_name },
  sections = {
    lualine_a = { "mode", snippet_jump_status },
    lualine_b = { { "branch", icon = icons.get("git-branch") }, { "diff", colored = false } },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      {
        "lsp_progress",
        display_components = { "lsp_client_name", { "title", "message", "percentage" }, "spinner" },
        separators = {
          component = " ",
          progress = " | ",
          message = { pre = "(", post = ")" },
          percentage = { pre = " ", post = "%%" },
          title = { pre = "", post = ": " },
          lsp_client_name = { pre = "[", post = "]" },
          spinner = { pre = "", post = "" },
        },
        spinner_symbols = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
      },
      {
        "diagnostics",
        symbols = {
          error = icons.get("x-circle") .. " ",
          warn = icons.get("alert") .. " ",
          info = icons.get("info") .. " ",
        },
        sources = { "nvim_diagnostic" },
      },
    },
    lualine_y = {
      {
        "encoding",
        cond = function()
          -- when filencoding="" lualine would otherwise report utf-8 anyways
          return vim.bo.fileencoding and #vim.bo.fileencoding > 0 and vim.bo.fileencoding ~= "utf-8"
        end,
      },
      {
        "fileformat",
        cond = function()
          return vim.bo.fileformat ~= "unix"
        end,
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
})

-- }}}

-- zen-mode {{{

require("zen-mode").setup({
  window = { backdrop = 1, options = { signcolumn = "no" } },
  plugins = { tmux = true },
})

vim.cmd("nnoremap <C-w>z :ZenMode<CR>")

-- }}}

-- -- {{{ nvim-lint
-- require("lint").linters_by_ft = {
--   sh = { "shellcheck" },
--   -- javascript = { "eslint-local" },
--   -- typescript = { "eslint-local" },
--   -- html = { "tidy" },
--   -- go = { "revive" },
--   vim = { "vint" },
--   -- php = { "phpstan" },
--   python = { "flake8" },
--   -- yaml = { "yamllint" },
--   -- make = { "checkmake" },
-- }
--
-- vim.cmd([[autocmd CursorHold,CursorHoldI <buffer> lua require'lint'.try_lint()]])
-- -- }}}

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

require("Comment").setup()

-- }}}

-- {{{ which-key

require("which-key").setup()

-- }}}

-- {{{ gtfo

vim.g["gtfo#terminals"] = { unix = "kitty", mac = "kitty" }

-- }}}

-- VimTeX {{{

if vim.fn.has("macunix") then
  vim.g.vimtex_view_method = "skim"
end
vim.g.vimtex_quickfix_open_on_warning = 0

-- }}}

-- workbench {{{

vim.cmd([[
  nmap <leader>bp <Plug>ToggleProjectWorkbench
  nmap <leader>bb <Plug>ToggleBranchWorkbench
]])
vim.g.workbench_storage_path = vim.fn.stdpath("data") .. "/workbench/"

-- }}}

-- gina {{{

vim.cmd("command! Blame Gina blame")

-- }}}

-- dirvish {{{

vim.g.loaded_netrwPlugin = 1
vim.cmd([[
  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
]])

-- }}}

-- svelte {{{

vim.g.svelte_preprocessor_tags = {
  { name = "ts", tag = "script", as = "typescript" },
}
vim.g.svelte_preprocessors = { "typescript", "ts" }

-- }}}

-- delimitMate {{{

-- vim.g.delimitMate_expand_cr = 1
-- vim.g.delimitMate_expand_space = 1

-- }}}

-- rust {{{

vim.g.rust_fold = 1

-- }}}
