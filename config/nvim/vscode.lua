-- TODO: somehow bundle this with VSCode

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  ---@diagnostic disable-next-line: assign-type-mismatch
  {
    "tpope/vim-surround",
    init = function ()
      vim.g["surround_no_mappings"] = 1
    end,
    config = function()
      vim.keymap.set("n", "ds", "<Plug>Dsurround")
      vim.keymap.set("n", "cs", "<Plug>Csurround")
      vim.keymap.set("n", "cS", "<Plug>CSurround")
      vim.keymap.set("n", "ys", "<Plug>Ysurround")
      vim.keymap.set("n", "yS", "<Plug>YSurround")
      vim.keymap.set("n", "yss", "<Plug>Yssurround")
      vim.keymap.set("n", "ySs", "<Plug>YSsurround")
      vim.keymap.set("n", "ySS", "<Plug>YSsurround")
      -- The conflicting ones.
      vim.keymap.set("x", "z", "<Plug>VSurround")
      vim.keymap.set("x", "Z", "<Plug>VgSurround")
    end,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
      require("leap").opts.safe_labels = {} -- disable auto jumping
    end,
  },
})

-- Helix
vim.keymap.set("", "ge", "G")
vim.keymap.set("", "gh", "0")
vim.keymap.set("", "gl", "$")
vim.keymap.set("", "gs", "^")

-- better indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Comments
vim.keymap.set({ "x", "n", "o" }, "gc", "<Plug>VSCodeCommentary")
vim.keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine")

-- whichkey
vim.keymap.set("", "<leader>", "<cmd>call VSCodeNotify('whichkey.show', 1)<cr>")

-- problems
vim.keymap.set("", "]d", "<cmd>call VSCodeNotify('editor.action.marker.next')<cr>")
vim.keymap.set("", "[d", "<cmd>call VSCodeNotify('editor.action.marker.prev')<cr>")

-- changes
vim.keymap.set("", "]c", "<cmd>call VSCodeNotify('workbench.action.editor.nextChange')<cr>")
vim.keymap.set("", "[c", "<cmd>call VSCodeNotify('workbench.action.editor.previousChange')<cr>")

-- search
vim.keymap.set("n", "/", "<cmd>call VSCodeNotify('actions.find')<cr>")

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.clipboard:append("unnamedplus")

vim.api.nvim_create_user_command("SentenceSplit", [[s/\. /.\r/g]], { range = true })
