-- nvim --headless -u NONE --cmd "set rtp^=." -l tests/smoke.lua
local ok_all = true
local function check(cond, msg)
  if not cond then ok_all = false; print("FAIL: " .. msg) end
end
local function int(hex) return tonumber(hex:sub(2), 16) end
local function get(name) return vim.api.nvim_get_hl(0, { name = name, link = false }) end

vim.env.XDG_CACHE_HOME = vim.fn.tempname()
local ex = require("jetbrains")

-- Official values, copied by hand from intellij-community
-- (expUI_darkScheme.xml / expUI_lightScheme.xml). Kept separate from
-- palette.lua on purpose: a palette edit that drifts from the IDE fails here.
local OFFICIAL = {
  dark = {
    bg = "#1e1f22", fg = "#bcbec4", keyword = "#cf8e6d", string = "#6aab73", number = "#2aacb8",
    comment = "#7a7e85", doc_comment = "#5f826b", func = "#56a8f5", field = "#c77dbb",
    annotation = "#b3ae60", type_param = "#16baac", caret_row = "#26282e", selection = "#214283",
    line_nr = "#4b5059", line_nr_cur = "#a1a3ab", todo = "#8bb33d", tag = "#d5b778",
  },
  light = {
    bg = "#ffffff", fg = "#080808", keyword = "#0033b3", string = "#067d17", number = "#1750eb",
    comment = "#8c8c8c", doc_comment = "#8c8c8c", func = "#00627a", field = "#871094",
    annotation = "#9e880d", type_param = "#007e8a", caret_row = "#f5f8fe", selection = "#a6d2ff",
    line_nr = "#aeb3c2", line_nr_cur = "#767a8a", todo = "#008dde", tag = "#0033b3",
  },
}

for _, name in ipairs({ "jetbrains-light", "jetbrains-dark", "jetbrains" }) do
  local ok, err = pcall(vim.cmd.colorscheme, name)
  check(ok, name .. ": " .. tostring(err))
  check(vim.g.colors_name == name, name .. ": colors_name=" .. tostring(vim.g.colors_name))
  local v = vim.o.background
  local want = OFFICIAL[v]
  local normal = get("Normal")
  check(normal.fg == int(want.fg) and normal.bg == int(want.bg), name .. ": Normal is TEXT")

  local fg_of = {
    Keyword = want.keyword, ["@keyword"] = want.keyword, ["@keyword.return"] = want.keyword,
    ["@boolean"] = want.keyword, ["@constant.builtin"] = want.keyword, ["@type.builtin"] = want.keyword,
    String = want.string, ["@string"] = want.string,
    Number = want.number, ["@number"] = want.number,
    Comment = want.comment, ["@comment"] = want.comment,
    ["@comment.documentation"] = want.doc_comment, ["@string.documentation"] = want.doc_comment,
    ["@function"] = want.func, ["@function.method"] = want.func,
    ["@lsp.typemod.function.declaration"] = want.func, ["@lsp.typemod.method.declaration"] = want.func,
    ["@property"] = want.field, ["@variable.member"] = want.field, ["@constant"] = want.field,
    ["@attribute"] = want.annotation, ["@lsp.type.typeParameter"] = want.type_param,
    ["@comment.todo"] = want.todo, ["@tag"] = want.tag,
    LineNr = want.line_nr, CursorLineNr = want.line_nr_cur,
    -- plain text, like the IDE: calls, classes, variables, parameters, operators
    ["@function.call"] = want.fg, ["@function.method.call"] = want.fg, ["@lsp.type.function"] = want.fg,
    ["@type"] = want.fg, ["@variable"] = want.fg, ["@variable.parameter"] = want.fg, ["@operator"] = want.fg,
  }
  for g, color in pairs(fg_of) do
    local h = get(g)
    check(h.fg == int(color), ("%s: %s fg %s ~= %s"):format(name, g, tostring(h.fg and ("#%06x"):format(h.fg)), color))
  end
  check(get("CursorLine").bg == int(want.caret_row), name .. ": CursorLine is CARET_ROW_COLOR")
  check(get("Visual").bg == int(want.selection), name .. ": Visual is SELECTION_BACKGROUND")

  -- the IDE's own font styles
  check(get("Comment").italic == (v == "light" or nil), name .. ": line comments italic only in Light")
  check(get("@comment.documentation").italic, name .. ": doc comments italic")
  check(get("@constant").italic, name .. ": constants italic")
  check(not get("@keyword").bold, name .. ": keywords not bold")
  check(get("@lsp.typemod.method.static").italic, name .. ": static methods italic")
  check(get("@lsp.mod.mutable").underline, name .. ": mutable variables underlined")

  -- color where the IDE has it
  local c = ex.colors(v)
  check(get("GitSignsAdd").fg == int(c.gutter_add) and get("GitSignsDelete").fg == int(c.gutter_delete), name .. ": gitsigns use gutter colors")
  check(get("BlinkCmpKindFunction").fg ~= get("BlinkCmpKindVariable").fg, name .. ": kinds differ")
  check(get("MiniIconsRed").fg ~= nil, name .. ": mini.icons")
  check(get("SpellBad").sp == int(c.typo), name .. ": SpellBad uses TYPO green")
  check(get("@lsp.type.unresolvedReference").fg == int(c.error), name .. ": unresolved reference is red")
  check(vim.g.terminal_color_1 ~= nil, name .. ": terminal colors")
end

-- background switch follows for "jetbrains"
vim.cmd.colorscheme("jetbrains")
vim.o.background = "light"
check(get("Normal").bg == 0xffffff, "auto variant follows background=light")
vim.o.background = "dark"
check(get("Normal").bg == 0x1e1f22, "auto variant follows background=dark")

-- cache written and setup invalidates key
local dir = vim.fn.stdpath("cache") .. "/jetbrains"
check(#vim.fn.readdir(dir) >= 3, "cache files exist")
ex.setup({ transparent = true })
vim.cmd.colorscheme("jetbrains-dark")
check(get("Normal").bg == nil, "transparent applied after setup")
ex.setup({ on_highlights = function(hl) hl.Normal.fg = "#ff0000" end })
vim.cmd.colorscheme("jetbrains-dark")
check(get("Normal").fg == 0xff0000, "on_highlights applied")

-- options
ex.setup({ colored_calls = true })
vim.cmd.colorscheme("jetbrains-dark")
check(get("@function.call").fg == 0x56a8f5, "colored_calls: calls in the declaration blue")
check(get("@lsp.type.method").fg == 0x56a8f5, "colored_calls: semantic calls in blue")

ex.setup({ styles = { comments = { italic = false }, keywords = { bold = true } } })
vim.cmd.colorscheme("jetbrains-light")
check(not get("Comment").italic, "styles.comments overrides the Light italic")
check(get("@keyword").bold and get("Keyword").bold, "styles.keywords applied")

ex.setup({ underline_mutable = false })
vim.cmd.colorscheme("jetbrains-dark")
check(not get("@lsp.mod.mutable").underline, "underline_mutable = false")

ex.setup({ on_colors = function(c) c.keyword = "#123456" end })
vim.cmd.colorscheme("jetbrains-dark")
check(get("@keyword").fg == 0x123456, "on_colors applied")
ex.setup({})

-- ANSI: the IDE console palette, hues readable on the editor background
for _, v in ipairs({ "light", "dark" }) do
  local c = ex.colors(v)
  local a = require("jetbrains.terminal").ansi(c)
  local contrast = require("jetbrains.util").contrast
  for i = 0, 15 do
    check(type(a[i]) == "string" and a[i]:match("^#%x%x%x%x%x%x$"), ("%s: ansi %d valid"):format(v, i))
  end
  for i = 1, 6 do
    check(contrast(a[i], c.bg) >= 3, ("%s: ansi %d readable on bg"):format(v, i))
  end
  a[1] = "#000000"
  check(require("jetbrains.terminal").ansi(c)[1] ~= "#000000", v .. ": ansi() returns a copy")
end

-- every kind maps to a real palette color
for _, v in ipairs({ "light", "dark" }) do
  local c = ex.colors(v)
  for kind, key in pairs(require("jetbrains.kinds")) do
    check(type(c[key]) == "string", ("%s: kind %s -> %s missing"):format(v, kind, key))
  end
end

-- highlights never produce invalid specs
for _, v in ipairs({ "light", "dark" }) do
  for n, spec in pairs(ex.highlights(v)) do
    for _, k in ipairs({ "fg", "bg", "sp" }) do
      local x = spec[k]
      check(x == nil or x == "NONE" or (type(x) == "string" and x:match("^#%x%x%x%x%x%x$")), ("%s %s.%s=%s"):format(v, n, k, tostring(x)))
    end
  end
end

print(ok_all and "ALL OK" or "FAILURES")
if not ok_all then os.exit(1) end
