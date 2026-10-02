local M = {}

--- The IDE's own console palette (CONSOLE_*_OUTPUT foregrounds), so
--- `:terminal`, Ghostty and Kitty print exactly what the Run tool window does.
--- Index order follows ANSI: black, red, green, yellow, blue, magenta, cyan,
--- gray ("white"), then dark gray ("bright black") and the bright variants.
---@type table<"light"|"dark", string[]>
M.console = {
  dark = {
    [0] = "#000000",
    "#f0524f",
    "#5c962c",
    "#a68a0d",
    "#3993d4",
    "#a771bf",
    "#00a3a3",
    "#808080",
    "#595959",
    "#ff4050",
    "#4fc414",
    "#e5bf00",
    "#1fb0ff",
    "#ed7eed",
    "#00e5e5",
    "#ffffff",
  },
  light = {
    [0] = "#000000",
    "#ce0505",
    "#067d17",
    "#b28c00",
    "#063fdb",
    "#b309b3",
    "#028e8e",
    "#929292",
    "#656565",
    "#ff1616",
    "#16b42c",
    "#ecc32c",
    "#2d61f0",
    "#e617e6",
    "#15c1c1",
    "#c9c9c9",
  },
}

--- ANSI 16-color table for a palette. Returns a copy, so `on_colors` tweaks to
--- the console table never leak between variants.
---@param c jetbrains.Colors
---@return string[] 0-indexed colors
function M.ansi(c)
  local src = M.console[c.variant]
  local out = {}
  for i = 0, 15 do
    out[i] = src[i]
  end
  return out
end

return M
