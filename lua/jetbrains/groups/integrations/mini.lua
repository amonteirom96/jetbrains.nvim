--- mini.icons, mini.pick, mini.extra, mini.files, mini.tabline
---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local util = require("jetbrains.util")
  local float_bg = o.transparent and c.none or (o.float.solid and c.panel or c.bg_float)
  local bg = o.transparent and c.none or c.bg

  return {
    -- mini.icons: the New UI color ramps
    MiniIconsAzure = { fg = c.vcs_modified },
    MiniIconsBlue = { fg = c.blue },
    MiniIconsCyan = { fg = c.teal },
    MiniIconsGreen = { fg = c.green },
    MiniIconsGrey = { fg = c.muted },
    MiniIconsOrange = { fg = c.orange },
    MiniIconsPurple = { fg = c.purple },
    MiniIconsRed = { fg = c.red },
    MiniIconsYellow = { fg = c.yellow },

    -- mini.pick / mini.extra (Search Everywhere)
    MiniPickNormal = { fg = c.fg, bg = float_bg },
    MiniPickBorder = { link = "FloatBorder" },
    MiniPickBorderBusy = { fg = c.accent, bg = float_bg },
    MiniPickBorderText = { fg = c.fg, bg = float_bg, bold = true },
    MiniPickCursor = { blend = 100, nocombine = true },
    MiniPickHeader = { fg = c.fg, bold = true },
    MiniPickIconDirectory = { fg = c.muted },
    MiniPickIconFile = { fg = c.fg },
    MiniPickMatchCurrent = { bg = c.list_sel },
    MiniPickMatchMarked = { bg = util.blend(c.accent, c.bg, 0.18) },
    MiniPickMatchRanges = { fg = c.match, bold = true },
    MiniPickPreviewLine = { bg = c.caret_row },
    MiniPickPreviewRegion = { bg = c.selection },
    MiniPickPrompt = { fg = c.fg, bg = float_bg },
    MiniPickPromptCaret = { fg = c.caret, bg = float_bg },
    MiniPickPromptPrefix = { fg = c.match, bg = float_bg, bold = true },
    MiniExtraPickers = { fg = c.fg },

    -- mini.files (Project tool window)
    MiniFilesNormal = { fg = c.fg, bg = float_bg },
    MiniFilesBorder = { link = "FloatBorder" },
    MiniFilesBorderModified = { fg = c.vcs.modified, bg = float_bg },
    MiniFilesCursorLine = { bg = c.list_sel },
    MiniFilesDirectory = { fg = c.fg },
    MiniFilesFile = { fg = c.fg },
    MiniFilesTitle = { fg = c.muted, bg = float_bg },
    MiniFilesTitleFocused = { fg = c.fg, bg = float_bg, bold = true },

    -- mini.tabline: editor tabs with the accent underline; modified buffers
    -- take the FILESTATUS_MODIFIED color, like the IDE's tab titles.
    MiniTablineCurrent = { fg = c.fg, bg = bg, sp = c.accent, underline = true },
    MiniTablineVisible = { fg = c.fg, bg = bg },
    MiniTablineHidden = { fg = c.muted, bg = bg },
    MiniTablineModifiedCurrent = { fg = c.vcs.modified, bg = bg, sp = c.accent, underline = true },
    MiniTablineModifiedVisible = { fg = c.vcs.modified, bg = bg },
    MiniTablineModifiedHidden = { fg = util.blend(c.vcs.modified, c.bg, 0.7), bg = bg },
    MiniTablineFill = { bg = bg },
    MiniTablineTabpagesection = { fg = c.on_accent, bg = c.accent, bold = true },
    MiniTablineTrunc = { fg = c.muted, bg = bg },
  }
end
