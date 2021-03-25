local M = {}

function M.lsp_status()
  local clients = vim.lsp.buf_get_clients(0)
  if vim.tbl_isempty(clients) then return '' end

  local clients_str = ""
  for k, client in pairs(clients) do
    clients_str = clients_str .. (function() if k == 1 then return "" else return ", " end end)() .. client.name
  end

  local errors = vim.lsp.diagnostic.get_count(0, "Error")
  local warnings = vim.lsp.diagnostic.get_count(0, "Warning")

  return "E:" .. tostring(errors) .. " W:" .. tostring(warnings) .. " [" .. clients_str .. "]"
end

return M
