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