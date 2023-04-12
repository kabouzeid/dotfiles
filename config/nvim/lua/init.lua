require("lsp")

vim.api.nvim_create_user_command("SentenceSplit", [[s/\. /.\r/g]], { range = true })
