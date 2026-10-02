--- gitsigns as the IDE's change markers: added green, modified blue and
--- deleted gray (ADDED/MODIFIED/DELETED_LINES_COLOR). Line highlights use the
--- diff viewer backgrounds (DIFF_INSERTED/MODIFIED/DELETED).
---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local blend = require("jetbrains.util").blend
  local hl = {
    -- Inline blame is an inlay without background in the IDE
    GitSignsCurrentLineBlame = { fg = c.inlay_fg },
    GitSignsVirtLnum = { fg = c.line_nr },
    GitSignsNoEOLPreview = { fg = c.subtle },
  }

  local line = { add = c.diff_add, change = c.diff_change, delete = c.diff_delete }
  local sets = {
    Add = "add",
    Change = "change",
    Delete = "delete",
    Changedelete = "change",
    Topdelete = "delete",
    Untracked = "add",
  }

  for kind, role in pairs(sets) do
    local color, ln = c.git[role], line[role]
    local strong = role == "change" and c.diff_text or blend(color, c.bg, 0.45)
    local g = "GitSigns" .. kind
    hl[g] = { fg = color }
    hl[g .. "Nr"] = { fg = color, bg = blend(color, c.bg, 0.14), bold = true }
    hl[g .. "Ln"] = { bg = ln }
    hl[g .. "Cul"] = { fg = color, bg = c.caret_row }
    hl[g .. "Preview"] = { bg = ln }
    hl[g .. "Inline"] = { bg = strong }
    hl[g .. "LnInline"] = { bg = strong }
    hl[g .. "VirtLn"] = { bg = ln }
    hl[g .. "VirtLnInline"] = { bg = strong }
    -- staged: same hue, quieter
    local staged = blend(color, c.bg, 0.55)
    hl["GitSignsStaged" .. kind] = { fg = staged }
    hl["GitSignsStaged" .. kind .. "Nr"] = { fg = staged, bg = blend(color, c.bg, 0.07) }
    hl["GitSignsStaged" .. kind .. "Ln"] = { bg = blend(ln, c.bg, 0.5) }
  end
  hl.GitSignsDeleteVirtLn = { fg = c.subtle, bg = c.diff_delete }

  return hl
end
