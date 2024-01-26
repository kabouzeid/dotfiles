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

require("lazy").setup({
  -- Treesitter
  ---@diagnostic disable-next-line: assign-type-mismatch
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  -- use("nvim-treesitter/playground") -- treesitter debugging

  -- LSP
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = require("nvim-nonicons").get("check-circle"),
            package_pending = require("nvim-nonicons").get("clock"),
            package_uninstalled = require("nvim-nonicons").get("circle"),
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
    end,
  },
  {
    "folke/lsp-trouble.nvim",
    config = function()
      require("trouble").setup({
        signs = {
          error = require("nvim-nonicons").get("x-circle"),
          warning = require("nvim-nonicons").get("alert"),
          information = require("nvim-nonicons").get("info"),
          hint = require("nvim-nonicons").get("comment"),
          other = require("nvim-nonicons").get("circle"),
        },
      })
    end,
  },
  { "arkav/lualine-lsp-progress" },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("plugins.null-ls")
    end,
  },
  { "b0o/schemastore.nvim" }, -- for jsonls
  { "barreiroleo/ltex-extra.nvim" },
  {
    "mrshmllow/document-color.nvim",
    config = function()
      require("document-color").setup({
        mode = "single",
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "hrsh7th/vim-vsnip",
        dependencies = "kitagry/vs-snippets",
        config = function()
          vim.cmd([[
  imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : luaeval('require("copilot.suggestion").is_visible()') ? '<cmd>lua require("copilot.suggestion").accept()<CR>' : '<Tab>'
  smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

  nmap        <C-s>   <Plug>(vsnip-select-text)
  xmap        <C-s>   <Plug>(vsnip-select-text)
  nmap        <A-s>   <Plug>(vsnip-cut-text)
  xmap        <A-s>   <Plug>(vsnip-cut-text)
]])
        end,
      },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "kdheepak/cmp-latex-symbols",
      "quangnguyen30192/cmp-nvim-tags",
      "ray-x/cmp-treesitter",
    },
    config = function()
      require("plugins.cmp")
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
        },
      })
    end,
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.dap")
    end,
  },
  { "theHamsta/nvim-dap-virtual-text", dependencies = "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui",            dependencies = "mfussenegger/nvim-dap" },
  { "mfussenegger/nvim-dap-python",    dependencies = "mfussenegger/nvim-dap" },

  -- Color
  { "norcalli/nvim-colorizer.lua" },
  -- use("rktjmp/lush.nvim")

  -- Themes
  -- use({ "rose-pine/neovim", as = "rose-pine" })
  -- use "~/Code/rose-pine"
  { "projekt0n/github-nvim-theme",     branch = "0.0.x" },
  -- use("Pocco81/Catppuccino.nvim")
  -- use("bluz71/vim-moonfly-colors")
  -- use({ "kabouzeid/nvim-jellybeans", dependencies = "rktjmp/lush.nvim" })
  -- use { "~/Code/nvim-jellybeans", dependencies = "rktjmp/lush.nvim" }
  -- use("sainnhe/sonokai")
  -- use("sainnhe/edge")
  -- use("sainnhe/everforest")
  -- use("sainnhe/gruvbox-material")
  -- use("kyazdani42/nvim-palenight.lua")
  -- use("folke/tokyonight.nvim")
  -- use("tjdevries/colorbuddy.vim")
  -- use("tjdevries/gruvbuddy.nvim")
  -- use("Th3Whit3Wolf/spacebuddy")
  -- use("Luxed/ayu-vim")
  -- use("connorholyday/vim-snazzy")
  -- use("fratajczak/one-monokai-vim")
  -- use("crusoexia/vim-monokai")
  -- use("rakr/vim-one")
  -- use("joshdick/onedark.vim")
  -- use({ "olimorris/onedark.nvim", dependencies = "rktjmp/lush.nvim" })
  -- use({ "alaric/nortia.nvim", dependencies = "rktjmp/lush.nvim" })
  -- use("junegunn/seoul256.vim")
  -- use("mhartington/oceanic-next")
  -- use("saltdotac/citylights.vim")

  -- Edit
  {
    "tpope/vim-surround",
    init = function()
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
  { "Raimondi/delimitMate" },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring" },

  -- Movement
  -- use("ggandor/lightspeed.nvim")
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
      require("leap").opts.safe_labels = {} -- disable auto jumping
    end,
  },

  -- UI
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 1,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          tmux = { enabled = true },
          twilight = { enabled = false },
        },
      })
    end,
  },
  { "folke/twilight.nvim" },
  {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("toggleterm").setup({ open_mapping = [[<c-\>]] })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    config = function()
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
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
  -- use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Files
  {
    "justinmk/vim-dirvish",
    config = function()
      vim.g.loaded_netrwPlugin = 1 -- comment this out when need to download spell files
      vim.cmd([[
  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
]])
    end,
  },
  {
    "justinmk/vim-gtfo",
    config = function()
      vim.g["gtfo#terminals"] = { unix = "kitty", mac = "iterm" }
    end,
  },
  { "tpope/vim-eunuch" },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
    end,
  },
  { "kyazdani42/nvim-web-devicons" },
  { "yamatsum/nvim-nonicons" },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  { "kdheepak/lazygit.nvim" },

  -- Lang
  { "folke/neodev.nvim" },
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = (vim.fn.has("macunix") == 1) and "skim" or "zathura"
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_syntax_conceal_disable = 1
    end,
  },
  -- use("petRUShka/vim-gap")
  -- use("petRUShka/vim-magma")
  -- use("kabouzeid/vim-singular")
  -- use("westeri/asl-vim") -- ACPI
  -- use("tikhomirov/vim-glsl")
  { "mattn/emmet-vim" },
  { "pest-parser/pest.vim" },
  { "jwalton512/vim-blade" },
  { "pantharshit00/vim-prisma" },
  {
    "evanleck/vim-svelte",
    config = function()
      vim.g.svelte_preprocessor_tags = {
        { name = "ts", tag = "script", as = "typescript" },
      }
      vim.g.svelte_preprocessors = { "typescript", "ts" }
    end,
  },
  {
    "rust-lang/rust.vim",
    config = function()
      vim.g.rust_fold = 1
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("rust-tools").setup({
        server = require("lsp").get_config("rust_analyzer"),
        tools = {
          inlay_hints = {
            highlight = "NonText",
            only_current_line = true,
          },
        },
      })
    end,
  }, -- additional rust goodies, mostly lsp related
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    config = function()
      vim.g.mkdp_preview_options = {
        hide_yaml_meta = 0,
        disable_filename = 1,
      }

      vim.g.mkdp_page_title = "${name}"
    end,
  },
  { "fladson/vim-kitty" },
  { "vim-scripts/fontforge_script.vim" },
  {
    "LhKipp/nvim-nu",
    build = ":TSInstall nu",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nu").setup()
    end,
  },

  -- Misc
  { "tpope/vim-sleuth" },
  { "wincent/terminus" },
  { "tpope/vim-unimpaired" },
  { "milisims/nvim-luaref" },
  {
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
  },
  {
    "mickael-menu/zk-nvim",
    config = function()
      require("plugins.zk")
    end,
  },
  {
    "nanotee/zoxide.vim",
    config = function()
      vim.g.zoxide_hook = "pwd"
    end,
  },
  { "trapd00r/vidir" },
  { "ojroques/vim-oscyank" },
  -- use("vimpostor/vim-lumen")
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup()
    end,
  },
})
