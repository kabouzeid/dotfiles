-- adjusted from: https://github.com/zk-org/zk-nvim/blob/8fdd7032633045ece559273370fc0ec75ee8ffce/lua/zk/pickers/snacks_picker.lua

local M = {}
local H = {}
local snacks_picker = require("snacks.picker")

M.note_picker_list_api_selection = { "metadata", "path", "absPath" }

M.show_note_picker = function(notes, opts, cb)
  notes = vim.tbl_map(function(note)
    -- use metadata.title if available, otherwise use the filename without extension
    local title = note.metadata and note.metadata.title
    title = title or note.path:match("^(.*)%..+$") -- strip extension
    return { text = title, file = note.absPath, value = note }
  end, notes)
  H.item_picker(notes, opts, cb)
end

M.show_tag_picker = function(tags, opts, cb)
  opts.snacks_picker = opts.snacks_picker or {}
  opts.snacks_picker =
      vim.tbl_deep_extend("keep", { preview = "preview", layout = { preview = false } }, opts.snacks_picker)
  local width = H.max_note_count(tags)
  tags = vim.tbl_map(function(tag)
    local padded_count = H.pad(tag.note_count, width)
    return {
      text = string.format(" %s  %s", padded_count, tag.name),
      value = tag,
      preview = { text = string.format("%s notes for #%s tag", tag.note_count, tag.name) },
    }
  end, tags)
  H.item_picker(tags, opts, cb)
end

H.item_picker = function(items, opts, cb)
  opts = opts or {}
  local picker_opts = vim.tbl_deep_extend("force", {
    items = items,
    format = "text",
    sort = { fields = { "score:desc", "idx" } },
    confirm = function(picker, item)
      picker:close()
      if not opts.multi_select then
        cb(item.value)
      else
        cb(vim.tbl_map(function(i)
          return i.value
        end, picker:selected({ fallback = true })))
      end
    end,
  }, opts.snacks_picker or {})
  snacks_picker.pick(opts.title, picker_opts)
end

H.max_note_count = function(tags)
  local max_count = 0
  for _, t in ipairs(tags) do
    max_count = math.max(max_count, t.note_count)
  end
  return vim.fn.strchars(tostring(max_count))
end

H.pad = function(text, width)
  local text_width = vim.fn.strchars(text)
  return string.rep(" ", width - text_width) .. text
end

return M
