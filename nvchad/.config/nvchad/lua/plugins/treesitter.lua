-- ponytail: pin to master. nvim-treesitter flipped its DEFAULT branch to `main` (a rewrite
-- that dropped `nvim-treesitter.configs`), lazy.nvim followed it, and NvChad v2.5 still
-- calls the old API. Delete this file if you ever move off the v2.5 branch.
return {
  { "nvim-treesitter/nvim-treesitter", branch = "master" },
}
