require("packer").init({
  max_jobs = 50, -- needed for iTerm2
})
require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  })
  -- use("nvim-treesitter/playground") -- treesitter debugging

  -- LSP
  use("neovim/nvim-lspconfig")
  use({
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
  })
  use({
    "williamboman/mason-lspconfig.nvim",
    after = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  })
  use({
    "kosayoda/nvim-lightbulb",
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
    end,
  })
  use({
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
  })
  use("arkav/lualine-lsp-progress")
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("plugins.null-ls")
    end,
  })
  use("b0o/schemastore.nvim") -- for jsonls
  use({ "barreiroleo/ltex-extra.nvim" })
  use({
    "mrshmllow/document-color.nvim",
    config = function()
      require("document-color").setup({
        mode = "single",
      })
    end,
  })

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      {
        "hrsh7th/vim-vsnip",
        requires = "kitagry/vs-snippets",
        config = function()
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
  })

  -- DAP
  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.dap")
    end,
  })
  use({ "theHamsta/nvim-dap-virtual-text", requires = "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui", requires = "mfussenegger/nvim-dap" })
  use({ "mfussenegger/nvim-dap-python", requires = "mfussenegger/nvim-dap" })

  -- Color
  use("norcalli/nvim-colorizer.lua")
  -- use("rktjmp/lush.nvim")

  -- Themes
  -- use({ "rose-pine/neovim", as = "rose-pine" })
  -- use "~/Code/rose-pine"
  use("projekt0n/github-nvim-theme")
  -- use("Pocco81/Catppuccino.nvim")
  -- use("bluz71/vim-moonfly-colors")
  -- use({ "kabouzeid/nvim-jellybeans", requires = "rktjmp/lush.nvim" })
  -- use { "~/Code/nvim-jellybeans", requires = "rktjmp/lush.nvim" }
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
  -- use({ "olimorris/onedark.nvim", requires = "rktjmp/lush.nvim" })
  -- use({ "alaric/nortia.nvim", requires = "rktjmp/lush.nvim" })
  -- use("junegunn/seoul256.vim")
  -- use("mhartington/oceanic-next")
  -- use("saltdotac/citylights.vim")

  -- Edit
  use("tpope/vim-surround")
  use("Raimondi/delimitMate")
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  })
  use("JoosepAlviste/nvim-ts-context-commentstring")

  -- Movement
  -- use("ggandor/lightspeed.nvim")

  -- UI
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  })
  use({
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
  })
  use("folke/twilight.nvim")
  use({
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("toggleterm").setup({ open_mapping = [[<c-\>]] })
    end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
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
  })
  use({
    "nvim-telescope/telescope-dap.nvim",
    config = function()
      require("telescope").load_extension("dap")
    end,
  })
  use({
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  })
  -- use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Files
  use({
    "justinmk/vim-dirvish",
    config = function()
      vim.g.loaded_netrwPlugin = 1 -- comment this out when need to download spell files
      vim.cmd([[
  command! -nargs=? -complete=dir Explore Dirvish <args>
  command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
  command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
]])
    end,
  })
  use({
    "justinmk/vim-gtfo",
    config = function()
      vim.g["gtfo#terminals"] = { unix = "kitty", mac = "iterm" }
    end,
  })
  use("tpope/vim-eunuch")
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
    end,
  })
  use("kyazdani42/nvim-web-devicons")
  use("yamatsum/nvim-nonicons")

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  })
  use("kdheepak/lazygit.nvim")

  -- Lang
  use("folke/neodev.nvim")
  use({
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = (vim.fn.has("macunix") == 1) and "skim" or "zathura"
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_syntax_enabled = 0
      vim.g.vimtex_syntax_conceal_disable = 1
    end,
  })
  -- use("petRUShka/vim-gap")
  -- use("petRUShka/vim-magma")
  -- use("kabouzeid/vim-singular")
  -- use("westeri/asl-vim") -- ACPI
  -- use("tikhomirov/vim-glsl")
  use("mattn/emmet-vim")
  use("pest-parser/pest.vim")
  use("jwalton512/vim-blade")
  use("pantharshit00/vim-prisma")
  use({
    "evanleck/vim-svelte",
    config = function()
      vim.g.svelte_preprocessor_tags = {
        { name = "ts", tag = "script", as = "typescript" },
      }
      vim.g.svelte_preprocessors = { "typescript", "ts" }
    end,
  })
  use({
    "rust-lang/rust.vim",
    config = function()
      vim.g.rust_fold = 1
    end,
  })
  use({
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
  }) -- additional rust goodies, mostly lsp related
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && yarn install",
    config = function()
      vim.g.mkdp_preview_options = {
        hide_yaml_meta = 0,
        disable_filename = 1,
      }

      vim.g.mkdp_page_title = "${name}"
    end,
  })
  use("fladson/vim-kitty")
  use("vim-scripts/fontforge_script.vim")

  -- Misc
  use("tpope/vim-sleuth")
  use("wincent/terminus")
  use("tpope/vim-unimpaired")
  use("milisims/nvim-luaref")
  use({
    "folke/which-key.nvim",
    config = function()
      require("plugins.which-key")
    end,
  })
  use("mickael-menu/zk-nvim")
  use({
    "nanotee/zoxide.vim",
    config = function()
      vim.g.zoxide_hook = "pwd"
    end,
  })
  use("trapd00r/vidir")
  use("ojroques/vim-oscyank")
  -- use("vimpostor/vim-lumen")
end)

vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost */plugins/init.lua PackerCompile
  augroup END
]])
