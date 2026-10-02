---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  return {
    MasonNormal = { link = "NormalFloat" },
    MasonBackdrop = { bg = "#000000", blend = 100 },
    MasonHeader = { fg = c.on_accent, bg = c.accent, bold = true },
    MasonHeaderSecondary = { fg = c.bg, bg = c.green, bold = true },
    MasonHeading = { fg = c.fg, bold = true },
    MasonHighlight = { fg = c.match },
    MasonHighlightSecondary = { fg = c.green },
    MasonHighlightBlock = { fg = c.on_accent, bg = c.accent },
    MasonHighlightBlockBold = { fg = c.on_accent, bg = c.accent, bold = true },
    MasonHighlightBlockSecondary = { fg = c.bg, bg = c.green },
    MasonHighlightBlockBoldSecondary = { fg = c.bg, bg = c.green, bold = true },
    MasonLink = { fg = c.link, underline = true },
    MasonMuted = { fg = c.muted },
    MasonMutedBlock = { fg = c.fg, bg = c.hover },
    MasonMutedBlockBold = { fg = c.fg, bg = c.hover, bold = true },
    MasonError = { fg = c.error },
    MasonWarning = { fg = c.warn },
  }
end
