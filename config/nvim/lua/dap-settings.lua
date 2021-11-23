local dap = require("dap")

vim.cmd("nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>")
vim.cmd("nnoremap <silent> <leader>dn :lua require'dap'.step_over()<CR>")
vim.cmd("nnoremap <silent> <leader>dsi :lua require'dap'.step_into()<CR>")
vim.cmd("nnoremap <silent> <leader>dsu :lua require'dap'.step_out()<CR>")
vim.cmd("nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>")
vim.cmd("nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.cmd(
  "nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
)
vim.cmd("nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>")
vim.cmd("nnoremap <silent> <leader>dK :lua require'dap.ui.variables'.hover()<CR>")
vim.cmd("nnoremap <silent> <leader>df :lua require'dap.ui.variables'.scopes()<CR>")
vim.cmd("nnoremap <silent> <leader>du :lua require'dapui'.toggle()<CR>")

require("nvim-dap-virtual-text").setup()
require("dapui").setup()

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
