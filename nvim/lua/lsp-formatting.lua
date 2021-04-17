local M = {}

function M.formatting_client_name(client_name)
  for _, client in pairs(vim.lsp.buf_get_clients()) do
    if client.name == client_name then
      M.formatting_client_id(client.id)
      return
    end
  end
  print("No client with that name")
end

function M.formatting_client_name_completion()
  local client_names = {}
  local clients = vim.lsp.buf_get_clients()
  for _, client in pairs(clients) do
    if client.resolved_capabilities.document_formatting or
        client.resolved_capabilities.document_range_formatting then
      table.insert(client_names, client.name)
    end
  end
  return client_names
end

function M.formatting_client_id(client_id)
  local client = vim.lsp.get_client_by_id(client_id)
  if client.resolved_capabilities.document_formatting then
    client.request("textDocument/formatting",
                   vim.lsp.util.make_formatting_params())
  elseif client.resolved_capabilities.document_range_formatting then
    local last_line = vim.fn.line("$")
    local last_col = vim.fn.col({ last_line, "$" })
    local params = vim.lsp.util.make_given_range_params({ 1, 0 },
                                                        { last_line, last_col })
    params.options = vim.lsp.util.make_formatting_params().options
    client.request("textDocument/rangeFormatting", params)
  else
    print("Client does neither support formatting nor rangeFormatting")
  end
end

return M
