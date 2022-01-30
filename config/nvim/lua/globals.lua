---Same as vim.wait, except it returns the arguments passed to the provided callback
---
---```
---local data
---foo("bar", function(data)
---  -- do something with `data`
---end)
---```
---
---```
---local data = wait(1000, function(cb) foo("bar", cb) end, 10)
---```
---
---@param time number passed to vim.wait, maximum waiting time in milliseconds
---@param f function that has a single callback function parameter
---@param interval number? passed to vim.wait
---@param fast_only boolean? passed to vim.wait
---@return table? list of arguments that were passed to the callback function of f
---@see vim.wait
--
function _G.wait(time, f, interval, fast_only)
  local cb_args
  f(function(...)
    cb_args = { ... }
  end)

  local wait_res, wait_err = vim.wait(time, function()
    return cb_args ~= nil
  end, interval, fast_only)

  if not wait_res then
    return nil, wait_err
  end

  return cb_args
end
