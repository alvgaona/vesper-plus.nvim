local variant = vim.o.background == "light" and "light" or "dark"
local p = require("vesper-plus.palette").get(variant)

local function mode(color)
  return {
    a = { fg = p.bg, bg = color, gui = "bold" },
    b = { fg = p.fg, bg = p.bg_hover },
    c = { fg = p.fg_muted, bg = p.bg_cursorline },
  }
end

return {
  normal = mode(p.accent),
  insert = mode(p.string),
  visual = mode(p.fg_muted),
  replace = mode(p.error),
  command = mode(p.accent_hover),
  terminal = mode(p.string),
  inactive = {
    a = { fg = p.fg_dim, bg = p.bg },
    b = { fg = p.fg_dim, bg = p.bg },
    c = { fg = p.fg_dim, bg = p.bg },
  },
}
