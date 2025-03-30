return {
  "zk-org/zk-nvim",
  config = function()
    local zk = require("zk")
    local util = require("zk.util")
    local commands = require("zk.commands")

    zk.setup({
      picker = "snacks_picker",
    })

    local function make_edit_fn(defaults, picker_options)
      return function(options)
        options = vim.tbl_extend("force", defaults, options or {})
        zk.edit(options, picker_options)
      end
    end

    local function make_new_fn(defaults)
      return function(options)
        options = vim.tbl_extend("force", defaults, options or {})
        zk.new(options)
      end
    end

    commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
    commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))
    commands.add("ZkLiveGrep", function(options)
      options = options or {}
      local notebook_path = options.notebook_path or util.resolve_notebook_path(0)
      local notebook_root = util.notebook_root(notebook_path)
      if notebook_root then
        require("telescope.builtin").live_grep({ cwd = notebook_root, prompt_title = "Zk Live Grep" })
      else
        vim.notify("No notebook found", vim.log.levels.ERROR)
      end
    end)

    commands.add("ZkNewDaily", make_new_fn({ dir = "journal/daily" }))
    commands.add("ZkNewHealth", make_new_fn({ dir = "journal/health" }))

    commands.add("ZkDaily", make_edit_fn({ hrefs = { "journal/daily" }, sort = { "created" } }, { title = "Zk Daily" }))
    commands.add("ZkHealth",
      make_edit_fn({ hrefs = { "journal/health" }, sort = { "created" } }, { title = "Zk Health" }))

    vim.keymap.set("n", "<leader>zn", "<cmd>ZkNew<CR>", { noremap = true })
    vim.keymap.set("x", "<leader>zn", ":'<,'>ZkNewFromTitleSelection<CR>", { noremap = true })
    vim.keymap.set("x", "<leader>zn", ":'<,'>ZkNewFromContentSelection<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>ze", "<cmd>ZkNotes { sort = { 'modified' } }<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>z/", "<cmd>ZkLiveGrep<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>zt", "<cmd>ZkTags<CR>", { noremap = true })
    vim.keymap.set(
      "n",
      "<leader>zs",
      "<cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
      { noremap = true }
    )
    vim.keymap.set("n", "<leader>zb", "<cmd>ZkBacklinks<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>zl", "<cmd>ZkLinks<CR>", { noremap = true })
  end
}
