local M = {}

-- SOURCE: copied from lsp.lua
local wait_result_reason = { [-1] = "timeout", [-2] = "interrupted", [-3] = "error" }

-- SOURCE: adjusted from buf_request_sync in lsp.lua
-- NOTE: this should be moved to lsp.lua as `client.request_sync`
--
-- @returns { err, result }, where `err` and `result` come from the lsp-handler
--- 				On timeout, cancel or error, returns `(nil, err)` where `err` is a
--- 			  string describing the failure reason. If the request was unsuccessful
--- 			  returns `nil`.
local function client_request_sync(client, method, params, timeout_ms, bufnr)
  local request_result = nil
  local function _sync_handler(err, _, result)
    request_result = { error = err, result = result }
  end

  local success, request_id = client.request(method, params, _sync_handler,
                                             bufnr)
  if not success then return nil end

  local wait_result, reason = vim.wait(timeout_ms or 100, function()
    return request_result ~= nil
  end, 10)

  if not wait_result then
    client.cancel_request(request_id)
    return nil, wait_result_reason[reason]
  end
  return request_result
end

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
      local result = client_request_sync(client, "textDocument/formatting", vim.lsp.util.make_formatting_params(options), timeout_ms)
      handle_request_result(result)
    elseif client.resolved_capabilities.document_range_formatting then
      local last_line = vim.fn.line("$")
      local last_col = vim.fn.col({ last_line, "$" })
      local params = vim.lsp.util.make_given_range_params({ 1, 0 }, {
        last_line, last_col
      })
      params.options = vim.lsp.util.make_formatting_params(options).options
      local result = client_request_sync(client, "textDocument/rangeFormatting", params, timeout_ms)
      handle_request_result(result)
    end
  end
end

return M
