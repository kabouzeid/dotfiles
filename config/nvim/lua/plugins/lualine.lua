local function lsp_servers_status()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    return ""
  end

  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end

  -- return require("nvim-nonicons").get("zap") .. " " .. table.concat(client_names, ":")
  return table.concat(client_names, ",")
end

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
        globalstatus = vim.fn.has("nvim-0.7"),
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "filename",
          {
            "encoding",
            cond = function()
              return vim.bo.fileencoding and #vim.bo.fileencoding > 0 and vim.bo.fileencoding ~= "utf-8"
            end,
          },
          {
            "fileformat",
            cond = function()
              return vim.bo.fileformat ~= "unix"
            end,
            icons_enabled = false,
          },
        },
        lualine_c = { { "branch", icon = require("nvim-nonicons").get("git-branch") }, "diff" },

        lualine_x = {
          {
            "lsp_progress",
            display_components = { "lsp_client_name", { "title", "message", "percentage" }, "spinner" },
            separators = {
              component = " ",
              progress = " | ",
              message = { pre = "(", post = ")" },
              percentage = { pre = " ", post = "%%" },
              title = { pre = "", post = ": " },
              lsp_client_name = { pre = "[", post = "]" },
              spinner = { pre = "", post = "" },
            },
            spinner_symbols = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
          },
          {
            "diagnostics",
            symbols = {
              error = require("nvim-nonicons").get("x-circle") .. " ",
              warn = require("nvim-nonicons").get("alert") .. " ",
              info = require("nvim-nonicons").get("info") .. " ",
              hint = require("nvim-nonicons").get("comment") .. " ",
            },
            sources = { "nvim_diagnostic" },
          },
        },
        lualine_y = {
        },
        lualine_z = { lsp_servers_status },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "toggleterm", "quickfix" },
    })
  end,
}
