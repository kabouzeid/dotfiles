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
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
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

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "cuda",
    "dockerfile",
    "fennel",
    "glsl",
    "go",
    "gomod",
    "graphql",
    "haskell",
    "help",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "latex",
    "lua",
    "make",
    "markdown",
    "ninja",
    "php",
    "prisma",
    "python",
    "regex",
    "rust",
    "svelte",
    -- "swift", -- needs tree-sitter CLI to be installed
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "zig",
  },
  highlight = { enable = true, additional_vim_regex_highlighting = { "markdown" } },
  indent = { enable = true },
  context_commentstring = { enable = true },
})

-- }}}

-- toggleterm {{{

require("toggleterm").setup({ open_mapping = [[<c-\>]] })

-- }}}

-- gitsigns {{{

require("gitsigns").setup({
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
    map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

    -- Actions
    map("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
    map("v", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
    map("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
    map("v", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
    map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
    map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
    map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
    map("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
    map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
    map("n", "<leader>hD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")

    -- Text object
    map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
    map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})

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
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.get("comment"),
      info = icons.get("info"),
      warning = icons.get("alert"),
      error = icons.get("x-circle"),
    },
  },
})

-- disable nvim tree autocmds --- they are buggy
vim.cmd("augroup NvimTreeView")
vim.cmd("au!")
vim.cmd("augroup END")

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
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
})

require("telescope").load_extension("dap")
require("telescope").load_extension("ui-select")

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

  return icons.get("zap") .. " " .. table.concat(client_names, ":")
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
  options = {
    theme = "auto",
    -- section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    component_separators = { left = "|", right = "|" },
    globalstatus = vim.fn.has("nvim-0.7"),
  },
  sections = {
    lualine_a = { "mode", snippet_jump_status },
    lualine_b = {
      "filename",
      {
        "encoding",
        cond = function()
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
    },
    lualine_c = { { "branch", icon = icons.get("git-branch") }, "diff" },

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
    },
    lualine_y = {
      {
        "diagnostics",
        symbols = {
          error = icons.get("x-circle") .. " ",
          warn = icons.get("alert") .. " ",
          info = icons.get("info") .. " ",
          hint = icons.get("comment") .. " ",
        },
        sources = { "nvim_diagnostic" },
      },
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
  extensions = { "nvim-tree", "toggleterm", "quickfix" },
})

-- }}}

-- zen-mode {{{

require("zen-mode").setup({
  window = { backdrop = 1, options = { signcolumn = "no" } },
  plugins = {
    tmux = { enabled = true },
    twilight = { enabled = false },
  },
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

-- {{{ Comment

require("Comment").setup({
  pre_hook = function(ctx)
    if
      vim.tbl_contains(
        { "typescriptreact", "javascriptreact", "jsx", "tsx", "javascript", "typescript" },
        vim.bo.filetype
      )
    then
      local U = require("Comment.utils")

      -- Detemine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring({
        key = type,
        location = location,
      })
    end
  end,
})

-- }}}

-- {{{ which-key

require("which-key").setup()

-- }}}

-- {{{ gtfo

vim.g["gtfo#terminals"] = { unix = "kitty", mac = "kitty" }

-- }}}

-- VimTeX {{{

vim.g.vimtex_view_method = (vim.fn.has("macunix") == 1) and "skim" or "zathura"
vim.g.vimtex_quickfix_open_on_warning = 0

-- }}}

-- gina {{{

vim.cmd("command! Blame Gina blame")

-- }}}

-- dirvish {{{

vim.g.loaded_netrwPlugin = 1 -- comment this out when need to download spell files
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

-- nvim-lsp-installer {{{

require("nvim-lsp-installer").settings({
  ui = {
    icons = {
      server_installed = icons.get("check-circle"),
      server_pending = icons.get("clock"),
      server_uninstalled = icons.get("circle"),
    },
  },
})

-- }}}

-- lazygit {{{

vim.cmd("nnoremap <silent> <leader>gg :LazyGit<CR>")

-- }}}

-- zoxide {{{

vim.g.zoxide_hook = "pwd"

-- }}}

-- mkdp {{{

vim.g.mkdp_preview_options = {
  hide_yaml_meta = 0,
  disable_filename = 1,
}

vim.g.mkdp_page_title = "${name}"

-- }}}
