# vesper-plus.nvim

Minimal Neovim colorscheme with warm orange accents, ported from the [Vesper Plus](https://github.com/alvgaona/vesper-plus) Zed theme. It includes _Vesper_ (dark) and _Vesper Light_, and picks one from `'background'`.

## Install

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "alvgaona/vesper-plus.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("vesper-plus").setup({}) -- optional
    vim.cmd.colorscheme("vesper-plus")
  end,
}
```

Use `vim.o.background = "light"` for Vesper Light.

## Options

```lua
require("vesper-plus").setup({
  transparent = false,     -- leave the editor background unset
  italic_comments = false,
  overrides = {},          -- { Group = { fg = ... } }, or function(palette) returning that
})
```

Lualine: `theme = "vesper-plus"`.

## Development

Colors live in `lua/vesper-plus/palette.lua` and mirror `themes/vesper-dark.json` in vesper-plus. Zed's translucent colors (`#RRGGBBAA`) are blended over the background, since Neovim has no alpha. Highlight groups are in `lua/vesper-plus/highlights.lua`.

## License

MIT
