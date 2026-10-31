local M = {}

M.config = {
  transparent = false, -- leave the editor background unset
  italic_comments = false,
  overrides = {}, -- table of highlight groups, or function(palette) returning one
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "vesper-plus"

  local variant = vim.o.background == "light" and "light" or "dark"
  local p = require("vesper-plus.palette").get(variant)
  local groups = require("vesper-plus.highlights").get(p, M.config)

  local overrides = M.config.overrides
  if type(overrides) == "function" then
    overrides = overrides(p)
  end
  groups = vim.tbl_extend("force", groups, overrides or {})

  for name, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, name, spec)
  end

  for i, color in ipairs(p.terminal) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

return M
