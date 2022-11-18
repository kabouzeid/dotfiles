local dap = require("dap")

vim.keymap.set("n", "<leader>xc", require("dap").continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>xn", require("dap").step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>xsi", require("dap").step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>xso", require("dap").step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>xb", require("dap").toggle_breakpoint, { desc = "Breakpoint" })
vim.keymap.set(
  "n",
  "<leader>xB",
  ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Conditional Breakpoint" }
)
vim.keymap.set(
  "n",
  "<leader>xl",
  ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  { desc = "Logging Breakpoint" }
)
vim.keymap.set("n", "<leader>xr", require("dap").repl.toggle, { desc = "REPL" })

---@diagnostic disable-next-line: missing-parameter
require("nvim-dap-virtual-text").setup()
require("dapui").setup()

vim.keymap.set("n", "<leader>xu", require("dapui").toggle, { desc = "UI" })

require("dap-python").setup("python")

dap.adapters.lldb = { type = "executable", command = "lldb-vscode", name = "lldb" }

local lldb_configuration = {
  type = "lldb",
  program = function()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end,
  cwd = "${workspaceFolder}",
}

dap.configurations.cpp = {
  vim.tbl_extend("force", lldb_configuration, {
    name = "Launch",
    request = "launch",
    stopOnEntry = false,
    runInTerminal = false,
  }),

  vim.tbl_extend("force", lldb_configuration, {
    name = "Launch with arguments",
    request = "launch",
    stopOnEntry = false,
    runInTerminal = false,
    args = function()
      local args_string = vim.fn.input("Arguments: ")
      ---@diagnostic disable-next-line: missing-parameter
      return vim.split(args_string, " +")
    end,
  }),

  vim.tbl_extend("force", lldb_configuration, {
    name = "Attach to process",
    request = "attach",
    pid = require("dap.utils").pick_process,
  }),
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- for more compatibility set the workspace folder as cwd
for _, value in pairs(dap.configurations.python) do
  if not value.cwd then
    value.cwd = "${workspaceFolder}"
  end
end
