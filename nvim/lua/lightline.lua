local M = {}

function M.lsp_status()
  local diagnostics = {}

  local errors = vim.lsp.diagnostic.get_count(0, "Error")
  if errors > 0 then table.insert(diagnostics, "%#LspDiagnosticsSignError# " .. tostring(errors)) end

  local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
  if warnings > 0 then table.insert(diagnostics, "%#LspDiagnosticsSignWarning# " .. tostring(warnings)) end

  local hints = vim.lsp.diagnostic.get_count(0, "Hint")
  if hints > 0 then table.insert(diagnostics, "%#LspDiagnosticsSignHint# " .. tostring(hints)) end

  local info = vim.lsp.diagnostic.get_count(0, "Information")
  if info > 0 then table.insert(diagnostics, "%#LspDiagnosticsSignInformation# " .. tostring(info)) end

  return table.concat(diagnostics, " ")
end

function M.lsp_servers()
  local clients = vim.lsp.buf_get_clients(0)
  if vim.tbl_isempty(clients) then return "" end

  local client_names = {}
  for _, client in pairs(clients) do table.insert(client_names, client.name) end

  return " " .. table.concat(client_names, "|")
end

return M
