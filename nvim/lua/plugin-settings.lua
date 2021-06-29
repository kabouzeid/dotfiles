-- vim:foldmethod=marker
local icons = require("nvim-nonicons")

-- compe: {{{

require"compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    -- treesitter = true;
    tmux = true,
    latex_symbols = true,
  },
}

local t = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()",
                        { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')",
                        { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')",
                        { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })",
                        { expr = true, silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })",
                        { expr = true, silent = true, noremap = true })

-- }}}

-- treesitter {{{

require"nvim-treesitter.configs".setup { highlight = { enable = true }, indent = { enable = true } }

-- }}}

-- tmux-complete {{{

do
  local compe = require "compe"
  local Source = {}

  function Source.get_metadata(_) return { priority = 10, dup = 0, menu = "[Tmux]" } end

  function Source.determine(_, context) return compe.helper.determine(context) end

  function Source.complete(_, context)
    vim.fn["tmuxcomplete#async#gather_candidates"](
      function(items) context.callback({ items = items }) end)
  end

  compe.register_source("tmux", Source)
end

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

function _G.lsp_reinstall_all()
  local lspinstall = require "lspinstall"
  for _, server in ipairs(lspinstall.installed_servers()) do lspinstall.install_server(server) end
end

vim.cmd [[command! -nargs=0 LspReinstallAll call v:lua.lsp_reinstall_all()]]

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
-- vim.g.nvim_tree_follow = 1

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
require("telescope").load_extension("fzf")

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

local function lsp_messages()
  local msgs = {}

  for _, msg in ipairs(vim.lsp.util.get_progress_messages()) do
    local content
    if msg.progress then
      content = msg.title
      if msg.message then content = content .. " " .. msg.message end
      if msg.percentage then content = content .. " (" .. msg.percentage .. "%%)" end
    elseif msg.status then
      content = msg.content
      if msg.uri then
        local filename = vim.uri_to_fname(msg.uri)
        filename = vim.fn.fnamemodify(filename, ":~:.")
        local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))
        if #filename > space then filename = vim.fn.pathshorten(filename) end

        content = "(" .. filename .. ") " .. content
      end
    else
      content = msg.content
    end

    table.insert(msgs, "[" .. msg.name .. "] " .. content)
  end

  return table.concat(msgs, " | ")
end

require("lualine").setup {
  options = { theme = "jellybeans" },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { { "branch", icon = icons.get("git-branch") }, { "diff", colored = false } },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      lsp_messages,
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
