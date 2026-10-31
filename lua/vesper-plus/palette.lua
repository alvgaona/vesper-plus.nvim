-- Colors mirror themes/vesper-dark.json in alvgaona/vesper-plus (the Zed theme).
-- Keep them in sync: reuse a Zed color rather than inventing a new one.

local M = {}

M.dark = {
  bg = "#101010",
  bg_cursorline = "#161616",
  bg_float = "#1A1A1A",
  bg_hint = "#1C1C1C",
  bg_select = "#232323",
  bg_hover = "#282828",
  border = "#282828",
  guide = "#282828",
  guide_active = "#343434",
  search = "#575757",

  fg = "#FFFFFF",
  fg_muted = "#A0A0A0",
  fg_dim = "#7E7E7E",
  line_nr = "#505050",
  line_nr_active = "#FFFFFF",
  predictive = "#585858",

  -- Syntax
  keyword = "#A0A0A0",
  operator = "#A0A0A0",
  punctuation = "#A0A0A0",
  attribute = "#A0A0A0",
  comment = { "#8B8B8B", 0x94 }, -- color with alpha, blended over bg
  accent = "#FFC799",
  accent_hover = "#FFCFA8",
  string = "#99FFE4",

  -- Status
  error = "#FF8080",
  warning = "#FFC799",
  info = "#7E7E7E",
  hint = "#A0A0A0",
  success = "#99FFE4",
  added = "#99FFE4",
  deleted = "#FF8080",
  modified = "#FFC799",

  -- Second cursor color in Zed, used here for secondary highlights
  secondary = "#99FFE4",

  terminal = {
    "#101010", "#f5a191", "#90b99f", "#e6b99d", "#aca1cf", "#e29eca", "#ea83a5", "#A0A0A0",
    "#7E7E7E", "#ff8080", "#99FFE4", "#FFC799", "#b9aeda", "#ecaad6", "#f591b2", "#ffffff",
  },
}

M.light = {
  bg = "#FFFFFF",
  bg_cursorline = "#F7F7F7",
  bg_float = "#FAFAFA",
  bg_hint = "#F2F2F2",
  bg_select = "#F2F2F2",
  bg_hover = "#EDEDED",
  border = "#EDEDED",
  guide = "#EDEDED",
  guide_active = "#CFCFCF",
  search = "#CFCFCF",

  fg = "#1A1A1A",
  fg_muted = "#555555",
  fg_dim = "#808080",
  line_nr = "#C0C0C0",
  line_nr_active = "#707070",
  predictive = "#B0B0B0",

  keyword = "#606060",
  operator = "#707070",
  punctuation = "#808080",
  attribute = "#6A6A6A",
  comment = "#B5B5B5",
  accent = "#E0A96D",
  accent_hover = "#E0A96D",
  string = "#00A88B",

  error = "#E57373",
  warning = "#FFC107",
  info = "#757575",
  hint = "#9E9E9E",
  success = "#4CAF50",
  added = "#00A88B",
  deleted = "#E57373",
  modified = "#E0A96D",

  secondary = "#00A88B",

  terminal = {
    "#333333", "#E57373", "#66BB6A", "#FFB74D", "#64B5F6", "#F48FB1", "#80DEEA", "#BDBDBD",
    "#A1A1A1", "#EF5350", "#81C784", "#FFD54F", "#42A5F5", "#EC407A", "#4DD0E1", "#FFFFFF",
  },
}

--- Mix `fg` over `bg`; `alpha` is 0-255, matching Zed's #RRGGBBAA colors.
function M.blend(fg, bg, alpha)
  local a = alpha / 255
  local function ch(hex, i)
    return tonumber(hex:sub(i, i + 1), 16)
  end
  local out = "#"
  for _, i in ipairs({ 2, 4, 6 }) do
    out = out .. string.format("%02X", math.floor(ch(fg, i) * a + ch(bg, i) * (1 - a) + 0.5))
  end
  return out
end

--- Returns the palette for "dark" or "light" with alpha colors resolved.
function M.get(variant)
  local p = vim.deepcopy(M[variant])
  for k, v in pairs(p) do
    if type(v) == "table" and k ~= "terminal" then
      p[k] = M.blend(v[1], p.bg, v[2])
    end
  end
  -- Zed tints selections and diff backgrounds with 0x3d alpha.
  p.visual = M.blend(p.accent, p.bg, 0x3d)
  p.diff_add = M.blend(p.added, p.bg, 0x3d)
  p.diff_delete = M.blend(p.deleted, p.bg, 0x3d)
  p.diff_change = M.blend(p.modified, p.bg, 0x26)
  p.diff_text = M.blend(p.modified, p.bg, 0x4d)
  p.error_bg = M.blend(p.error, p.bg, 0x3d)
  p.warning_bg = M.blend(p.warning, p.bg, 0x3d)
  p.info_bg = M.blend(p.info, p.bg, 0x3d)
  p.success_bg = M.blend(p.success, p.bg, 0x3d)
  return p
end

return M
