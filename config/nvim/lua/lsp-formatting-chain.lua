local M = {}

--- Formats the current buffer by chaining formatting and/or range_formatting requests to all
--- attached clients of the current buffer.
---
--- Useful for running on save, to make sure buffer is formatted prior to being
--- saved. {timeout_ms} is passed on to the |vim.lsp.client| `request_sync` method. Example:
---
--- <pre>
--- vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_chain_sync()]]
--- </pre>
---
--@param options (optional, table) `FormattingOptions` entries
--@param timeout_ms (optional, number) Request timeout
--@param order (optional, table) List of client names. The buffer is formatted with all capable
---      clients in the following order: first all clients that are not in the `order` list, then
---      the remaining clients in the order as they occur in the `order` list.
function M.formatting_chain_sync(options, timeout_ms, order)
  local clients = vim.tbl_values(vim.lsp.buf_get_clients());

  -- sort the clients according to `order`
  for _, client_name in ipairs(order or {}) do
    -- if the client exists, move to the end of the list
    for i, client in ipairs(clients) do
      if client.name == client_name then
        table.insert(clients, table.remove(clients, i))
        break
      end
    end
  end

  local function handle_request_result(result)
    if not result then return end
    if not result.result then return end
    vim.lsp.util.apply_text_edits(result.result)
  end
  -- loop through the clients and make synchronous formatting requests
  for _, client in ipairs(clients) do
    if client.resolved_capabilities.document_formatting then
      local result = client.request_sync("textDocument/formatting", vim.lsp.util.make_formatting_params(options), timeout_ms)
      handle_request_result(result)
    elseif client.resolved_capabilities.document_range_formatting then
      local last_line = vim.fn.line("$")
      local last_col = vim.fn.col({ last_line, "$" })
      local params = vim.lsp.util.make_given_range_params({ 1, 0 }, {
        last_line, last_col
      })
      params.options = vim.lsp.util.make_formatting_params(options).options
      local result = client.request_sync("textDocument/rangeFormatting", params, timeout_ms)
      handle_request_result(result)
    end
  end
end

return M
