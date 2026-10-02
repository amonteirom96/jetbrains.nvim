-- Reports the WCAG contrast of every syntax and diagnostic color against the
-- editor background and the caret row.
-- Usage: nvim --headless -u NONE --cmd "set rtp^=." -l scripts/contrast.lua
--
-- The syntax colors are the IDE's own, and some of them (gray comments,
-- Python keyword arguments) sit below AA on purpose. So this does not demand
-- AA from them: it fails only when a color drops under 3:1 (AA for large
-- text), which would mean a palette edit made code hard to read.

local util = require("jetbrains.util")
local palette = require("jetbrains.palette")

local AA, MIN = 4.5, 3.0
local keys = {
  "fg", "keyword", "string", "number", "comment", "doc_comment", "func", "field", "annotation",
  "type_param", "escape", "tag", "attribute", "link", "regexp", "todo", "self", "builtin", "kwarg",
  "error", "warn", "info", "hint", "ok",
}
-- Official colors known to sit below 3:1; reported, never failed.
local exempt = { dark = { kwarg = true, self = true }, light = {} }
local failed = false
local function say(...)
  io.write(string.format(...), "\n")
end

for _, variant in ipairs({ "light", "dark" }) do
  local c = palette.get(variant, {})
  say("\n%s  bg=%s  caret_row=%s", variant:upper(), c.bg, c.caret_row)
  for _, k in ipairs(keys) do
    local r = util.contrast(c[k], c.bg)
    local r2 = util.contrast(c[k], c.caret_row)
    local low = math.min(r, r2)
    local grade = low >= AA and "AA" or low >= MIN and "AA-large" or "LOW"
    local bad = low < MIN and not exempt[variant][k]
    failed = failed or bad
    say(
      "  %-12s %s  on bg %5.2f  on caret row %5.2f  %s%s",
      k, c[k], r, r2, grade, bad and "  FAIL" or (low < MIN and "  (official, exempt)" or "")
    )
  end
  say("  %-12s %s  on bg %5.2f  (UI chrome)", "line_nr", c.line_nr, util.contrast(c.line_nr, c.bg))
  say("  %-12s %s  on bg %5.2f  (UI chrome)", "muted", c.muted, util.contrast(c.muted, c.bg))
end

if failed then
  os.exit(1)
end
