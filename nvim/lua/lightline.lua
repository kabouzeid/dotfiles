local M = {}

function M.lsp_status()
  local clients = vim.lsp.buf_get_clients(0)
  if vim.tbl_isempty(clients) then return '' end

  local client_names = {}
  for _, client in pairs(clients) do table.insert(client_names, client.name) end

  local errors = vim.lsp.diagnostic.get_count(0, "Error")
  local warnings = vim.lsp.diagnostic.get_count(0, "Warning")

  return "E:" .. tostring(errors) .. " W:" .. tostring(warnings) .. " [" .. table.concat(client_names, ",") .. "]"
end

return M
