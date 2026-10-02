-- Renders assets/banner.svg and assets/preview.svg from the real palette.
-- Usage: nvim --headless -u NONE --cmd "set rtp^=." -l scripts/assets.lua

local ex = require("jetbrains")
local util = require("jetbrains.util")
local L, D = ex.colors("light"), ex.colors("dark")

local FONT = "'JetBrains Mono','SF Mono','Cascadia Code',Menlo,Consolas,monospace"
local SANS = "'Inter','SF Pro Display','Segoe UI',Helvetica,Arial,sans-serif"
local fmt, concat = string.format, table.concat

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function write(path, s)
  local f = assert(io.open(path, "w"))
  f:write(s)
  f:close()
end

local ACCENTS = { "keyword", "string", "number", "func", "field", "annotation", "type_param", "todo" }

-------------------------------------------------------------------------------
-- Banner
-------------------------------------------------------------------------------
local function banner()
  local W, H = 1280, 420
  local o = {}
  local function add(...)
    o[#o + 1] = fmt(...)
  end

  add('<svg xmlns="http://www.w3.org/2000/svg" width="%d" height="%d" viewBox="0 0 %d %d">', W, H, W, H)
  add("<defs>")
  add('<clipPath id="left"><polygon points="0,0 %d,0 %d,%d 0,%d"/></clipPath>', W / 2 + 70, W / 2 - 70, H, H)
  add('<clipPath id="right"><polygon points="%d,0 %d,0 %d,%d %d,%d"/></clipPath>', W / 2 + 70, W, W, H, W / 2 - 70, H)
  add('<clipPath id="card"><rect width="%d" height="%d" rx="24"/></clipPath>', W, H)
  add("</defs>")
  add('<g clip-path="url(#card)">')
  add('<rect width="%d" height="%d" fill="%s"/>', W, H, L.bg)
  add('<rect width="%d" height="%d" fill="%s" clip-path="url(#right)"/>', W, H, D.bg)

  local function title(c, clip)
    add('<g clip-path="url(#%s)">', clip)
    add(
      '<text x="%d" y="200" text-anchor="middle" font-family="%s" font-size="104" font-weight="700" letter-spacing="-3" fill="%s">jetbrains<tspan fill="%s">.nvim</tspan></text>',
      W / 2, SANS, c.fg, c.accent
    )
    add(
      '<text x="%d" y="258" text-anchor="middle" font-family="%s" font-size="24" fill="%s" letter-spacing="0.5">the IntelliJ New UI default schemes, Dark and Light, for Neovim</text>',
      W / 2, SANS, c.fg
    )
    add(
      '<text x="%d" y="372" text-anchor="middle" font-family="%s" font-size="17" fill="%s" letter-spacing="4">NEOVIM · GHOSTTY · KITTY · LAZYGIT</text>',
      W / 2, FONT, c.muted
    )
    add("</g>")
  end
  title(L, "left")
  title(D, "right")

  -- syntax dots: each drawn in the variant it sits on
  local n, gap, r = #ACCENTS, 38, 9
  local x0 = W / 2 - (n - 1) * gap / 2
  for i, k in ipairs(ACCENTS) do
    local x = x0 + (i - 1) * gap
    local c = x < W / 2 and L or D
    add('<circle cx="%d" cy="310" r="%d" fill="%s"/>', x, r, c[k])
  end
  add("</g>")
  add("</svg>")
  return concat(o, "\n")
end

-------------------------------------------------------------------------------
-- Preview: an editor mock-up rendered in both variants
-------------------------------------------------------------------------------
-- token = { text, style } where style:
-- nil | "kw" | "str" | "num" | "fn" | "field" | "const" | "ann" | "comment" | "doc" | "todo" | "err"
local CODE = {
  { { "@Service", "ann" } },
  { { "public class", "kw" }, { " Greeter {" } },
  { { "    " }, { "private static final int", "kw" }, { " " }, { "MAX", "const" }, { " = " }, { "3", "num" }, { ";" } },
  { { "    " }, { "private final", "kw" }, { " String " }, { "name", "field" }, { " = " }, { '"World"', "str" }, { ";" } },
  {},
  { { "    /** Greets the caller. */", "doc" } },
  { { "    " }, { "public", "kw" }, { " String " }, { "greet", "fn" }, { "(" }, { "int", "kw" }, { " times) {" } },
  { { "        // ", "comment" }, { "TODO: cache the result", "todo" } },
  { { "        " }, { "return", "kw" }, { " " }, { "name", "field" }, { "." }, { "re", "err" } },
  { { "    }" } },
  { { "}" } },
}
local CURSOR = 9
-- line -> git kind (the IDE's thin change markers in the gutter)
local GIT = { [3] = "change", [4] = "add", [6] = "add", [7] = "add" }

local MENU = {
  { "repeat", "(int count)", "String", "m", "func" },
  { "replace", "(char, char)", "String", "m", "func" },
  { "regionMatches", "(int, …)", "boolean", "m", "func" },
  { "resolveConstantDesc", "(Lookup)", "String", "m", "func" },
  { "result", "", "int", "f", "field" },
}

local function editor(c, ox, oy, w, h, label)
  local o = {}
  local function add(...)
    o[#o + 1] = fmt(...)
  end
  local fs, lh = 15, 26
  local cw = fs * 0.6
  local gutter = 52
  local top = oy + 48

  local id = "clip" .. label
  add('<clipPath id="%s"><rect x="%d" y="%d" width="%d" height="%d" rx="14"/></clipPath>', id, ox, oy, w, h)
  add('<g font-family="%s" font-size="%d" clip-path="url(#%s)">', FONT, fs, id)
  add('<rect x="%d" y="%d" width="%d" height="%d" rx="14" fill="%s"/>', ox, oy, w, h, c.bg)

  -- editor tabs: same background as the editor, accent underline on the selected tab
  add('<rect x="%d" y="%d" width="%d" height="1" fill="%s"/>', ox, oy + 36, w, c.border)
  add('<text x="%d" y="%d" fill="%s"><tspan fill="%s" font-weight="700">C</tspan> Greeter.java</text>', ox + 22, oy + 24, c.fg, c.blue)
  add('<rect x="%d" y="%d" width="138" height="3" rx="1.5" fill="%s"/>', ox + 14, oy + 34, c.accent)
  add('<text x="%d" y="%d" fill="%s"><tspan fill="%s" font-weight="700">K</tspan> Main.kt</text>', ox + 172, oy + 24, c.muted, c.purple)
  add('<text x="%d" y="%d" fill="%s" font-family="%s" font-size="13" text-anchor="end" letter-spacing="2">%s</text>', ox + w - 16, oy + 24, c.muted, SANS, label)

  for i, line in ipairs(CODE) do
    local y = top + (i - 1) * lh
    local base = y + lh * 0.68
    if i == CURSOR then
      add('<rect x="%d" y="%d" width="%d" height="%d" fill="%s"/>', ox, y, w, lh, c.caret_row)
    end
    local g = GIT[i]
    if g then
      add('<rect x="%d" y="%d" width="3" height="%d" fill="%s"/>', ox + gutter - 8, y, lh, c.git[g])
    end
    add('<text x="%d" y="%d" text-anchor="end" fill="%s">%d</text>', ox + gutter - 16, base, i == CURSOR and c.line_nr_cur or c.line_nr, i)

    local parts = {}
    for _, tok in ipairs(line) do
      local text, style = tok[1], tok[2]
      local t = esc(text)
      if style == "kw" then
        parts[#parts + 1] = fmt('<tspan fill="%s">%s</tspan>', c.keyword, t)
      elseif style == "str" then
        parts[#parts + 1] = fmt('<tspan fill="%s">%s</tspan>', c.string, t)
      elseif style == "num" then
        parts[#parts + 1] = fmt('<tspan fill="%s">%s</tspan>', c.number, t)
      elseif style == "fn" then
        parts[#parts + 1] = fmt('<tspan fill="%s">%s</tspan>', c.func, t)
      elseif style == "field" then
        parts[#parts + 1] = fmt('<tspan fill="%s">%s</tspan>', c.field, t)
      elseif style == "const" then
        parts[#parts + 1] = fmt('<tspan fill="%s" font-style="italic">%s</tspan>', c.field, t)
      elseif style == "ann" then
        parts[#parts + 1] = fmt('<tspan fill="%s">%s</tspan>', c.annotation, t)
      elseif style == "comment" then
        parts[#parts + 1] = fmt('<tspan fill="%s"%s>%s</tspan>', c.comment, c.variant == "light" and ' font-style="italic"' or "", t)
      elseif style == "doc" then
        parts[#parts + 1] = fmt('<tspan fill="%s" font-style="italic">%s</tspan>', c.doc_comment, t)
      elseif style == "todo" then
        parts[#parts + 1] = fmt('<tspan fill="%s" font-style="italic">%s</tspan>', c.todo, t)
      elseif style == "err" then
        parts[#parts + 1] = fmt('<tspan fill="%s">%s</tspan>', c.error, t)
      else
        parts[#parts + 1] = t
      end
    end
    add('<text x="%d" y="%d" fill="%s" xml:space="preserve">%s</text>', ox + gutter, base, c.fg, concat(parts))
  end

  -- caret after `name.re`, and the unresolved-reference wave under `re`
  local dy = top + (CURSOR - 1) * lh
  local col = 20
  add('<rect x="%d" y="%d" width="2" height="%d" fill="%s"/>', ox + gutter + col * cw, dy + 4, lh - 8, c.caret)
  local ux = ox + gutter + (col - 2) * cw
  add('<path d="M%d %d q2 -3 4 0 t4 0 t4 0 t4 0" fill="none" stroke="%s" stroke-width="1.3"/>', ux, dy + lh - 4, c.diag.error)
  -- diagnostic virtual text
  local dx = ox + gutter + (col + 3) * cw
  add('<rect x="%d" y="%d" width="%d" height="%d" rx="4" fill="%s"/>', dx, dy + 3, 30 * cw, lh - 6, util.blend(c.diag.error, c.bg, 0.10))
  add('<text x="%d" y="%d" fill="%s" xml:space="preserve">■ Cannot resolve symbol &apos;re&apos;</text>', dx + 8, dy + lh * 0.68, c.diag.error)

  -- completion lookup under the caret
  local mx, my = ox + gutter + (col - 2) * cw - 30, top + CURSOR * lh + 2
  local mw, mh = 360, #MENU * 24 + 12
  add('<rect x="%d" y="%d" width="%d" height="%d" rx="8" fill="%s" stroke="%s"/>', mx, my, mw, mh, c.popup, c.popup_border)
  for j, item in ipairs(MENU) do
    local iy = my + 6 + (j - 1) * 24
    if j == 1 then
      add('<rect x="%d" y="%d" width="%d" height="24" rx="4" fill="%s"/>', mx + 4, iy, mw - 8, c.list_sel)
    end
    local kind = c[item[5]]
    add('<circle cx="%d" cy="%d" r="8" fill="%s"/>', mx + 18, iy + 12, util.blend(kind, c.popup, 0.22))
    add('<text x="%d" y="%d" fill="%s" font-size="11" font-weight="700" text-anchor="middle">%s</text>', mx + 18, iy + 16, kind, item[4])
    add(
      '<text x="%d" y="%d" fill="%s"><tspan fill="%s" font-weight="700">re</tspan>%s<tspan fill="%s">%s</tspan></text>',
      mx + 34, iy + 17, c.fg, c.match, esc(item[1]:sub(3)), c.muted, esc(item[2])
    )
    add('<text x="%d" y="%d" fill="%s" text-anchor="end" font-size="13">%s</text>', mx + mw - 12, iy + 17, c.muted, item[3])
  end

  -- status bar: breadcrumbs left, caret position and encoding right
  local sy = oy + h - 32
  add('<rect x="%d" y="%d" width="%d" height="32" fill="%s"/>', ox, sy, w, c.panel)
  add('<rect x="%d" y="%d" width="%d" height="1" fill="%s"/>', ox, sy, w, c.border)
  add('<rect x="%d" y="%d" width="62" height="32" fill="%s"/>', ox, sy, c.blue)
  add('<text x="%d" y="%d" fill="%s" font-weight="700">NOR</text>', ox + 16, sy + 21, c.bg)
  add('<text x="%d" y="%d" fill="%s" font-family="%s" font-size="13">greeter  ›  src  ›  <tspan fill="%s">Greeter</tspan>  ›  <tspan fill="%s">greet</tspan></text>', ox + 76, sy + 21, c.muted, SANS, c.fg, c.fg)
  add('<text x="%d" y="%d" fill="%s" text-anchor="end" font-family="%s" font-size="13"><tspan fill="%s">● 1</tspan>   9:23   LF   UTF-8</text>', ox + w - 16, sy + 21, c.muted, SANS, c.diag.error)
  add("</g>")
  add('<rect x="%d" y="%d" width="%d" height="%d" rx="14" fill="none" stroke="%s"/>', ox, oy, w, h, c.popup_border)
  return concat(o, "\n")
end

local function preview()
  local W, H = 1280, 500
  local ew, eh = 610, 460
  return concat({
    fmt('<svg xmlns="http://www.w3.org/2000/svg" width="%d" height="%d" viewBox="0 0 %d %d">', W, H, W, H),
    editor(L, 20, 20, ew, eh, "LIGHT"),
    editor(D, W - ew - 20, 20, ew, eh, "DARK"),
    "</svg>",
  }, "\n")
end

vim.fn.mkdir("assets", "p")
write("assets/banner.svg", banner())
write("assets/preview.svg", preview())
print("assets/banner.svg, assets/preview.svg written")
