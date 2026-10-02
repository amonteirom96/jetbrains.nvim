local util = require("jetbrains.util")

---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local blend = util.blend
  local bg = o.transparent and c.none or c.bg
  local float_bg = o.transparent and c.none or (o.float.solid and c.panel or c.bg_float)
  local float_border = o.float.solid and { fg = float_bg, bg = float_bg } or { fg = c.popup_border, bg = float_bg }

  local hl = {
    -- Base -------------------------------------------------------------------
    Normal = { fg = c.fg, bg = bg },
    NormalNC = { fg = c.fg, bg = (o.dim_inactive and not o.transparent) and c.bg_dim or bg },
    NormalFloat = { fg = c.fg, bg = float_bg },
    FloatBorder = float_border,
    FloatTitle = { fg = c.fg, bg = float_bg, bold = true },
    FloatFooter = { fg = c.muted, bg = float_bg },
    FloatShadow = { bg = "#000000", blend = 80 },
    FloatShadowThrough = { bg = "#000000", blend = 100 },
    MsgArea = { fg = c.fg },
    MsgSeparator = { fg = c.border, bg = bg },
    ModeMsg = { fg = c.fg, bold = true },
    MoreMsg = { fg = c.match, bold = true },
    Question = { fg = c.match },
    ErrorMsg = { fg = c.error, bold = true },
    WarningMsg = { fg = c.warn },
    OkMsg = { fg = c.ok },
    StderrMsg = { fg = c.error },
    StdoutMsg = { fg = c.fg },
    NvimInternalError = { fg = c.bg, bg = c.error },
    Title = { fg = c.fg, bold = true },
    Directory = { fg = c.fg, bold = true },
    Conceal = { fg = c.subtle },
    NonText = { fg = c.whitespace },
    EndOfBuffer = { fg = c.line_nr },
    Whitespace = { fg = c.whitespace },
    SpecialKey = { fg = c.whitespace },

    -- Cursor & lines (caret row, gutter) -------------------------------------
    Cursor = { fg = c.bg, bg = c.caret },
    lCursor = { fg = c.bg, bg = c.caret },
    CursorIM = { fg = c.bg, bg = c.caret },
    TermCursor = { reverse = true },
    CursorLine = { bg = c.caret_row },
    CursorColumn = { bg = c.caret_row },
    ColorColumn = { bg = c.caret_row },
    LineNr = { fg = c.line_nr },
    LineNrAbove = { fg = c.line_nr },
    LineNrBelow = { fg = c.line_nr },
    CursorLineNr = { fg = c.line_nr_cur },
    CursorLineSign = { bg = c.none },
    CursorLineFold = { fg = c.line_nr_cur },
    SignColumn = { fg = c.line_nr, bg = bg },
    FoldColumn = { fg = c.line_nr, bg = bg },
    Folded = { fg = c.folded_fg, bg = c.folded_bg },
    QuickFixLine = { bg = c.list_sel },

    -- Selection & search -----------------------------------------------------
    Visual = { bg = c.selection },
    VisualNOS = { bg = c.selection_inactive },
    Search = { fg = c.fg, bg = c.search },
    CurSearch = { fg = c.fg, bg = c.selection, bold = true },
    IncSearch = { fg = c.fg, bg = c.selection, bold = true },
    Substitute = { fg = c.fg, bg = blend(c.orange, c.bg, 0.35), bold = true },
    MatchParen = c.variant == "dark" and { bg = c.brace, bold = true } or { bg = c.brace },

    -- Windows, bars ----------------------------------------------------------
    WinSeparator = { fg = c.border, bg = bg },
    VertSplit = { fg = c.border, bg = bg },
    StatusLine = { fg = c.fg, bg = c.panel },
    StatusLineNC = { fg = c.muted, bg = c.panel },
    StatusLineTerm = { fg = c.fg, bg = c.panel },
    StatusLineTermNC = { fg = c.muted, bg = c.panel },
    -- Editor tabs: same background as the editor, accent underline on the
    -- selected one, like the New UI.
    TabLine = { fg = c.muted, bg = bg },
    TabLineFill = { bg = bg },
    TabLineSel = { fg = c.fg, bg = bg, sp = c.accent, underline = true },
    WinBar = { fg = c.muted, bg = bg },
    WinBarNC = { fg = c.subtle, bg = bg },
    WildMenu = { fg = c.fg, bg = c.list_sel },

    -- Popup menu (completion lookup) -----------------------------------------
    Pmenu = { fg = c.fg, bg = float_bg },
    PmenuSel = { bg = c.list_sel },
    PmenuKind = { fg = c.muted, bg = float_bg },
    PmenuKindSel = { fg = c.fg, bg = c.list_sel },
    PmenuExtra = { fg = c.muted, bg = float_bg },
    PmenuExtraSel = { fg = c.muted, bg = c.list_sel },
    PmenuMatch = { fg = c.match, bold = true },
    PmenuMatchSel = { fg = c.match, bg = c.list_sel, bold = true },
    PmenuSbar = { bg = float_bg },
    PmenuThumb = { bg = c.border },
    PmenuBorder = float_border,
    PmenuShadow = { bg = "#000000", blend = 80 },
    PmenuShadowThrough = { bg = "#000000", blend = 100 },
    ComplMatchIns = { fg = c.muted },
    ComplHint = { fg = c.inlay_fg },
    ComplHintMore = { fg = c.inlay_fg },

    -- Snippets (live templates: a box around the variable) -------------------
    SnippetTabstop = { bg = c.hover, sp = c.accent, underline = true },
    SnippetTabstopActive = { bg = c.list_sel, sp = c.accent, underline = true },

    -- Spell (TYPO: a green wave, not an error) -------------------------------
    SpellBad = { sp = c.typo, undercurl = true },
    SpellCap = { sp = c.warn, undercurl = true },
    SpellLocal = { sp = c.hint, undercurl = true },
    SpellRare = { sp = c.info, undercurl = true },

    -- Diff & git -------------------------------------------------------------
    -- Text that names a change (`git diff` output, diff headers) uses the file
    -- status colors; deleted text is red so a diff stays readable.
    Added = { fg = c.vcs.added },
    Changed = { fg = c.vcs.modified },
    Removed = { fg = c.red },
    DiffAdd = { bg = c.diff_add },
    DiffChange = { bg = c.diff_change },
    DiffDelete = { fg = c.subtle, bg = c.diff_delete },
    DiffText = { bg = c.diff_text },
    DiffTextAdd = { bg = blend(c.gutter_add, c.bg, c.variant == "light" and 0.5 or 0.45) },
    diffAdded = { fg = c.vcs.added },
    diffChanged = { fg = c.vcs.modified },
    diffRemoved = { fg = c.red },
    diffFile = { fg = c.fg, bold = true },
    diffLine = { fg = c.match },
    diffIndexLine = { fg = c.muted },

    -- Diagnostics ------------------------------------------------------------
    DiagnosticDeprecated = { sp = c.fg, strikethrough = true },
    DiagnosticUnnecessary = { fg = c.unused },

    -- LSP (identifier under caret, inlays, code vision) ----------------------
    LspReferenceText = { bg = c.ref },
    LspReferenceRead = { bg = c.ref },
    LspReferenceWrite = { bg = c.ref_write },
    LspReferenceTarget = { bg = c.ref },
    LspInlayHint = { fg = c.inlay_fg, bg = c.inlay_bg },
    LspCodeLens = { fg = c.muted },
    LspCodeLensSeparator = { fg = c.border },
    LspSignatureActiveParameter = { fg = c.match, bold = true },
    LspInfoBorder = float_border,

    -- Health -----------------------------------------------------------------
    healthError = { fg = c.error },
    healthSuccess = { fg = c.ok },
    healthWarning = { fg = c.warn },

    -- Redraw debug -----------------------------------------------------------
    RedrawDebugNormal = { reverse = true },
    RedrawDebugClear = { bg = c.yellow },
    RedrawDebugComposed = { bg = c.green },
    RedrawDebugRecompose = { bg = c.red },
  }

  -- Errors and warnings get the IDE's wave underline; weak warnings (hints) a
  -- quieter dotted line.
  for name, color in pairs({ Error = c.diag.error, Warn = c.diag.warn, Info = c.diag.info, Hint = c.diag.hint, Ok = c.diag.ok }) do
    local tint = blend(color, c.bg, 0.10)
    hl["Diagnostic" .. name] = { fg = color }
    hl["DiagnosticSign" .. name] = { fg = color, bg = bg }
    hl["DiagnosticFloating" .. name] = { fg = color }
    hl["DiagnosticVirtualText" .. name] = { fg = color, bg = tint }
    hl["DiagnosticVirtualLines" .. name] = { fg = color }
    hl["DiagnosticUnderline" .. name] = name == "Hint" and { sp = color, underdotted = true }
      or { sp = color, undercurl = true }
    hl["DiagnosticLine" .. name] = { bg = tint }
  end

  return hl
end
