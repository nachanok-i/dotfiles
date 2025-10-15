require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Text case mappings  
map("n", "<leader>tc", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Open Text Case Telescope" })  
map("v", "<leader>tc", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Open Text Case Telescope" })  
map("n", "<leader>tq", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Quick case change" })  
map("v", "<leader>tq", "<cmd>TextCaseOpenTelescopeQuickChange<CR>", { desc = "Quick case change" })
