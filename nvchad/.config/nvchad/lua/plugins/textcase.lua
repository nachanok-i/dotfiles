-- Find and Replace preserve case
return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({
      default_keymappings_enabled = true,
      prefix = "ga",
      substitute_command_name = "Subs", -- Fixed typo here
      enabled_methods = {
        "to_upper_case",
        "to_lower_case",
        "to_snake_case",
        "to_dash_case",
        "to_constant_case",
        "to_dot_case",
        "to_comma_case",
        "to_phrase_case",
        "to_camel_case",
        "to_pascal_case",
        "to_title_case",
        "to_path_case",
        "to_upper_phrase_case",
        "to_lower_phrase_case",
      },
    })

    -- Register with telescope
    require("telescope").load_extension("textcase")
  end,
  cmd = {
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseStartReplacingCommand",
    "Subs", 
  },
  keys = {
    { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
  },
  lazy = false,
}

