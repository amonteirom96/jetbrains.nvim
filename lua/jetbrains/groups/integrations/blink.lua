--- blink.cmp styled like the IDE's completion lookup: popup background,
--- blue list selection, matched characters in CompletionPopup.matchForeground.
---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local hl = {
    BlinkCmpMenu = { link = "Pmenu" },
    BlinkCmpMenuBorder = { link = "PmenuBorder" },
    BlinkCmpMenuSelection = { link = "PmenuSel" },
    BlinkCmpScrollBarThumb = { link = "PmenuThumb" },
    BlinkCmpScrollBarGutter = { link = "PmenuSbar" },
    BlinkCmpLabel = { fg = c.fg },
    BlinkCmpLabelDeprecated = { fg = c.muted, strikethrough = true },
    BlinkCmpLabelMatch = { fg = c.match, bold = true },
    BlinkCmpLabelDetail = { fg = c.muted },
    BlinkCmpLabelDescription = { fg = c.muted },
    BlinkCmpSource = { fg = c.subtle },
    BlinkCmpKind = { fg = c.muted },
    BlinkCmpGhostText = { fg = c.inlay_fg },
    BlinkCmpDoc = { link = "NormalFloat" },
    BlinkCmpDocBorder = { link = "FloatBorder" },
    BlinkCmpDocSeparator = { fg = c.popup_border },
    BlinkCmpDocCursorLine = { link = "CursorLine" },
    BlinkCmpSignatureHelp = { link = "NormalFloat" },
    BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
    BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },
  }

  -- Colored kinds. Blink links BlinkCmpKind<X> -> CmpItemKind<X> when
  -- `use_nvim_cmp_as_default` is on, so set both.
  for kind, key in pairs(require("jetbrains.kinds")) do
    local spec = { fg = c[key] }
    hl["BlinkCmpKind" .. kind] = spec
    hl["CmpItemKind" .. kind] = spec
  end
  hl.CmpItemAbbrMatch = { fg = c.match, bold = true }
  hl.CmpItemAbbrMatchFuzzy = { fg = c.match, bold = true }
  hl.CmpItemAbbrDeprecated = { fg = c.muted, strikethrough = true }
  hl.CmpItemMenu = { fg = c.muted }

  return hl
end
