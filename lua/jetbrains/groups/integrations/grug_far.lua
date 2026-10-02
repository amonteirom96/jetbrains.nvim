--- grug-far as the IDE's "Replace in Files": matches in the find-result
--- color, replacements in the diff viewer colors.
---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  return {
    GrugFarHelpHeader = { fg = c.muted },
    GrugFarHelpHeaderKey = { fg = c.match, bold = true },
    GrugFarHelpWinHeader = { fg = c.fg, bold = true },
    GrugFarHelpWinActionKey = { fg = c.match, bold = true },
    GrugFarHelpWinActionPrefix = { fg = c.muted },
    GrugFarHelpWinActionText = { fg = c.fg },
    GrugFarHelpWinActionDescription = { fg = c.muted },
    GrugFarInputLabel = { fg = c.fg, bold = true },
    GrugFarInputPlaceholder = { fg = c.subtle },
    GrugFarResultsHeader = { fg = c.fg, bold = true },
    GrugFarResultsStats = { fg = c.muted },
    GrugFarResultsActionMessage = { fg = c.match },
    GrugFarResultsCmdHeader = { fg = c.muted },
    GrugFarResultsPath = { fg = c.link, underline = true },
    GrugFarResultsLineNr = { fg = c.line_nr },
    GrugFarResultsColumnNr = { fg = c.line_nr },
    GrugFarResultsNumbersSeparator = { fg = c.line_nr },
    GrugFarResultsNumberLabel = { fg = c.muted },
    GrugFarResultsCursorLineNo = { fg = c.line_nr_cur },
    GrugFarResultsLongLineStr = { fg = c.subtle },
    GrugFarResultsMatch = { fg = c.fg, bg = c.search },
    GrugFarResultsMatchAdded = { fg = c.fg, bg = c.diff_add },
    GrugFarResultsMatchRemoved = { fg = c.fg, bg = c.diff_delete, strikethrough = true },
    GrugFarResultsAddIndicator = { fg = c.git.add },
    GrugFarResultsRemoveIndicator = { fg = c.git.delete },
    GrugFarResultsChangeIndicator = { fg = c.git.change },
    GrugFarResultsDiffSeparatorIndicator = { fg = c.subtle },
    GrugFarVisualBufrange = { bg = c.selection_inactive },
  }
end
