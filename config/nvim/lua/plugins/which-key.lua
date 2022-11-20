local wk = require("which-key")

wk.setup({
  plugins = {
    spelling = {
      enabled = true,
    },
  },
})

wk.register({
  ["?"] = { "<cmd>Telescope commands<cr>", "Commands" },
  ["w"] = {
    name = "+windows",
    ["w"] = { "<C-W>p", "other-window" },
    ["n"] = { "<C-W>n", "new-window" },
    ["q"] = { "<C-W>c", "close-window" },
    ["o"] = { "<C-W>o", "close-other-windows" },
    ["h"] = { "<C-W>h", "window-left" },
    ["j"] = { "<C-W>j", "window-below" },
    ["l"] = { "<C-W>l", "window-right" },
    ["k"] = { "<C-W>k", "window-up" },
    ["H"] = { "<C-W>H", "move-window-left" },
    ["J"] = { "<C-W>J", "move-window-bottom" },
    ["L"] = { "<C-W>L", "move-window-right" },
    ["K"] = { "<C-W>K", "move-window-top" },
    ["t"] = { "<C-W>T", "move-window-tab" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
    ["z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },
  },
  s = {
    function()
      require("telescope.builtin").lsp_document_symbols({
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "String",
        },
      })
    end,
    "Document Symbols",
  },
  S = {
    function()
      require("telescope.builtin").lsp_workspace_symbols({
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "String",
        },
      })
    end,
    "Workspace Symbols",
  },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
  D = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
  f = { "<cmd>Telescope find_files<cr>", "Files" },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search in Project" },
  b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  g = { "<cmd>LazyGit<cr>", "Lazygit" },
  z = { name = "zk" },
  x = { name = "dap" },
  h = { name = "hunk" },
  t = { "<cmd>NvimTreeToggle<cr>", "File Tree" },
}, { prefix = "<leader>" })

wk.register({ g = { name = "goto" } })
