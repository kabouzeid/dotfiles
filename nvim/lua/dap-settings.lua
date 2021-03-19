local dap = require('dap')

vim.cmd "nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>"
vim.cmd "nnoremap <silent> <leader>dn :lua require'dap'.step_over()<CR>"
vim.cmd "nnoremap <silent> <leader>dsi :lua require'dap'.step_into()<CR>"
vim.cmd "nnoremap <silent> <leader>dsu :lua require'dap'.step_out()<CR>"
vim.cmd "nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>"
vim.cmd "nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
vim.cmd "nnoremap <silent> <leader>dl :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
vim.cmd "nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle()<CR>"
vim.cmd "nnoremap <silent> <leader>dK :lua require'dap.ui.variables'.hover()<CR>"
vim.cmd "nnoremap <silent> <leader>df :lua require'dap.ui.variables'.scopes()<CR>"

vim.g.dap_virtual_text = true

dap.adapters.cpp = {
  type = 'executable',
  attach = {
    pidProperty = "pid",
    pidSelect = "ask"
  },
  command = 'lldb-vscode',
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
  },
  name = "lldb"
}


local function lldb_configuration(program, args, env)
  return {
    name = "lldb",
    type = "cpp",
    request = "launch",
    program = program,
    args = args,
    cwd = vim.fn.getcwd(),
    env = env,
    externalConsole = true,
    MIMode = "lldb",
    MIDebuggerPath = "lldb"
  }
end

dap.configurations.cpp = {
  lldb_configuration(
  function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end
  )
}

local M = {}

-- meant to be called from a vim command
M.cmd_run_lldb = function(args)
  if args and #args > 0 then
    local program = table.remove(args, 1)

    local env = {}
    for k, v in pairs(vim.fn.environ()) do
      table.insert(env, string.format("%s=%s", k, v))
    end

    dap.run(lldb_configuration(program, args, env))
  else
    print('No binary to debug set!')
  end
end

vim.cmd 'command! -complete=file -nargs=* DapLLDB lua require "dap-settings".cmd_run_lldb({<f-args>})'

return M
