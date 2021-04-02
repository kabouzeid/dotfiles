-- Credits: contains some code snippets from https://github.com/norcalli/nvim-colorizer.lua

local function percent_or_hex(v)
  if v:sub(-1,-1) == "%" then
    return tonumber(v:sub(1,-2))/100*255
  end
  local x = tonumber(v)
  if x > 255 then return end
  return x
end

local bit = require 'bit'

local CSS_RGB_MIN_LEN = #'rgb(0,0,0)'
function _G.css_rgb_to_hex(color)
  if #color < CSS_RGB_MIN_LEN then return end
  local r, g, b, match_end = color:match("^rgb%(%s*(%d+%%?)%s*,%s*(%d+%%?)%s*,%s*(%d+%%?)%s*%)()")
  if not match_end then return end
  r = percent_or_hex(r) if not r then return end
  g = percent_or_hex(g) if not g then return end
  b = percent_or_hex(b) if not b then return end
  return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
end

local CSS_RGBA_MIN_LEN = #'rgba(0,0,0,0)'
local function css_rgba_to_hex(color)
  if #color < CSS_RGBA_MIN_LEN then return end
  local r, g, b, a, match_end = color:match("^rgba%(%s*(%d+%%?)%s*,%s*(%d+%%?)%s*,%s*(%d+%%?)%s*,%s*([.%d]+)%s*%)()")
  if not match_end then return end
  a = tonumber(a) if not a or a > 1 then return end
  r = percent_or_hex(r) if not r then return end
  g = percent_or_hex(g) if not g then return end
  b = percent_or_hex(b) if not b then return end
  return bit.tohex(bit.bor(bit.lshift(math.floor(r*a), 16), bit.lshift(math.floor(g*a), 8), math.floor(b*a)), 6)
end

function _G.css_color_to_hex(color)
  return css_rgba_to_hex(color) or css_rgb_to_hex(color)
end

-- Determine whether to use black or white text
-- Ref: https://stackoverflow.com/a/1855903/837964
-- https://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color
local function color_is_bright(r, g, b)
  -- Counting the perceptive luminance - human eye favors green color
  local luminance = (0.299*r + 0.587*g + 0.114*b)/255
  if luminance > 0.5 then
    return true -- Bright colors, black font
  else
    return false -- Dark colors, white font
  end
end

local function generate_id()
	-- --- returns HEX of 16 random bytes
  -- local id = ""
  -- for _ = 1, 16, 1 do
    -- id = id .. string.format('%.2X', math.random(0, 255))
  -- end
  -- return id

	-- this is also works and is probably more efficient than string formatting
	return math.random(1, 2^64)
end

local NAMESPACE = vim.api.nvim_create_namespace("tailwindcss")
local HIGHLIGHT_NAME_PREFIX = "tailwindcss"
local HIGHLIGHT_MODE_NAMES = { background = "mb"; foreground = "mf"; }

local HIGHLIGHT_CACHE = {}

--- Make a deterministic name for a highlight given these attributes
local function make_highlight_name(rgb, mode)
  return table.concat({HIGHLIGHT_NAME_PREFIX, HIGHLIGHT_MODE_NAMES[mode], rgb}, '_')
end

local function create_highlight(rgb_hex, options)
  local mode = options.mode or 'background'
  local cache_key = table.concat({HIGHLIGHT_MODE_NAMES[mode], rgb_hex}, "_")
  local highlight_name = HIGHLIGHT_CACHE[cache_key]

  if highlight_name then return highlight_name end

  -- Create the highlight
  highlight_name = make_highlight_name(rgb_hex, mode)
  if mode == 'foreground' then
    vim.api.nvim_command(string.format("highlight %s guifg=#%s", highlight_name, rgb_hex))
  else
    local r, g, b = rgb_hex:sub(1,2), rgb_hex:sub(3,4), rgb_hex:sub(5,6)
    r, g, b = tonumber(r,16), tonumber(g,16), tonumber(b,16)
    local fg_color
    if color_is_bright(r,g,b) then fg_color = "Black" else fg_color = "White" end
    vim.api.nvim_command(string.format("highlight %s guifg=%s guibg=#%s", highlight_name, fg_color, rgb_hex))
  end
  HIGHLIGHT_CACHE[cache_key] = highlight_name

  return highlight_name
end

local ATTACHED_BUFFERS = {}

local function buf_set_highlights(bufnr, colors, options)
  vim.api.nvim_buf_clear_namespace(bufnr, NAMESPACE, 0, -1)

  for _, color_info in pairs(colors) do
    local rgb_hex = css_color_to_hex(color_info.color)
    local highlight_name = create_highlight(rgb_hex, options)
    local range = color_info.range
    vim.api.nvim_buf_add_highlight(bufnr, NAMESPACE, highlight_name, range.start.line, range.start.character, range["end"].character)
  end
end

local document_color_callback

local function update_highlight(bufnr, options)
  local id = generate_id()
  document_color_callback = function (params)
    if not params.id == id then return end
    buf_set_highlights(bufnr, params.colors, options)
  end
  vim.lsp.buf_notify(bufnr, "tailwindcss/getDocumentColors", {
    _id=id,
    document=vim.uri_from_bufnr(bufnr)
  })
end

vim.lsp.handlers["tailwindcss/getDocumentColorsResponse"] = function(_, _, params, _, _, _)
  if document_color_callback then
    document_color_callback(params)
  end
end

local M = {}

local function expand_bufnr(bufnr)
  if bufnr == 0 or bufnr == nil then
    return vim.api.nvim_get_current_buf()
  else
    return bufnr
  end
end

--- Should be called `on_attach` when the LSP client attaches
function M.buf_attach(bufnr, options)
  bufnr = expand_bufnr(bufnr)
  if ATTACHED_BUFFERS[bufnr] then return end
  ATTACHED_BUFFERS[bufnr] = true

  options = options or { mode = 'background' }

  -- VSCode extension also does 200ms debouncing
  local trigger_update_highlight, timer = require'defer'.debounce_trailing(update_highlight, 200, false)

  update_highlight(bufnr, options)
  -- react to changes
  vim.api.nvim_buf_attach(bufnr, false, {
    on_lines = function()
      if not ATTACHED_BUFFERS[bufnr] then return true end
      trigger_update_highlight(bufnr, options)
    end,
    on_detach = function()
      timer:close()
      ATTACHED_BUFFERS[bufnr] = true
    end
  })
end

--- Can be used to detach from the buffer
function M.buf_detach(bufnr)
  bufnr = expand_bufnr(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, NAMESPACE, 0, -1)
  ATTACHED_BUFFERS[bufnr] = nil
end

--- To be used with nvim-lspconfig
function M.wrap_on_attach(on_attach, options)
  return function(client, bufnr)
    on_attach(client, bufnr)
    M.buf_attach(bufnr, options)
  end
end

return M
