local util = require("jetbrains.util")

local M = {}

--- Base palettes, copied from the IntelliJ Platform's New UI default schemes:
---   Dark  = platform/platform-resources/src/themes/expUI/expUI_darkScheme.xml  (+ Darcula parent)
---   Light = platform/platform-resources/src/themes/expUI/expUI_lightScheme.xml (+ Default parent)
--- UI tones (panels, popups, list selection, accent) come from the matching
--- `expUI_{dark,light}.theme.json` color ramps (Gray1..14, Blue1..13, ...).
--- The comment after each value names the IntelliJ attribute it comes from.
---@type table<"light"|"dark", jetbrains.BasePalette>
M.base = {
  dark = {
    bg = "#1e1f22", -- TEXT.BACKGROUND
    fg = "#bcbec4", -- TEXT.FOREGROUND

    -- Syntax ------------------------------------------------------------------
    keyword = "#cf8e6d", -- DEFAULT_KEYWORD
    string = "#6aab73", -- DEFAULT_STRING
    number = "#2aacb8", -- DEFAULT_NUMBER
    comment = "#7a7e85", -- DEFAULT_LINE_COMMENT / DEFAULT_BLOCK_COMMENT
    doc_comment = "#5f826b", -- DEFAULT_DOC_COMMENT (italic)
    doc_tag = "#67a37c", -- DEFAULT_DOC_COMMENT_TAG (underlined)
    doc_tag_value = "#abadb3", -- DEFAULT_DOC_COMMENT_TAG_VALUE
    func = "#56a8f5", -- DEFAULT_FUNCTION_DECLARATION
    field = "#c77dbb", -- DEFAULT_INSTANCE_FIELD (static fields and constants: italic)
    annotation = "#b3ae60", -- DEFAULT_METADATA / ANNOTATION_NAME_ATTRIBUTES
    type_param = "#16baac", -- TYPE_PARAMETER_NAME_ATTRIBUTES
    label = "#32b8af", -- KOTLIN_LABEL
    escape = "#cf8e6d", -- DEFAULT_VALID_STRING_ESCAPE
    tag = "#d5b778", -- HTML_TAG_NAME / XML_TAG_NAME
    attribute = "#bababa", -- HTML_ATTRIBUTE_NAME
    custom_tag = "#2fbaa3", -- HTML_CUSTOM_TAG_NAME
    link = "#548af7", -- HYPERLINK_ATTRIBUTES
    regexp = "#42c3d4", -- JS.REGEXP
    todo = "#8bb33d", -- TODO_DEFAULT_ATTRIBUTES (italic)
    self = "#94558d", -- PY.SELF_PARAMETER
    builtin = "#8888c6", -- PY.BUILTIN_NAME
    kwarg = "#aa4926", -- PY.KEYWORD_ARGUMENT
    unused = "#6f737a", -- NOT_USED_ELEMENT_ATTRIBUTES
    typo = "#7ec482", -- TYPO (green wave under misspelled words)
    code_bg = "#303235", -- MARKDOWN_CODE_SPAN.BACKGROUND

    -- Editor ------------------------------------------------------------------
    caret = "#ced0d6", -- CARET_COLOR
    caret_row = "#26282e", -- CARET_ROW_COLOR
    selection = "#214283", -- SELECTION_BACKGROUND
    selection_inactive = "#4c4f56", -- SELECTION_BACKGROUND_INACTIVE
    line_nr = "#4b5059", -- LINE_NUMBERS_COLOR
    line_nr_cur = "#a1a3ab", -- LINE_NUMBER_ON_CARET_ROW_COLOR
    indent = "#313438", -- INDENT_GUIDE
    indent_active = "#666870", -- SELECTED_INDENT_GUIDE
    whitespace = "#6f737a", -- WHITESPACES
    margin = "#393b40", -- RIGHT_MARGIN_COLOR
    search = "#114957", -- TEXT_SEARCH_RESULT_ATTRIBUTES
    ref = "#373b39", -- IDENTIFIER_UNDER_CARET_ATTRIBUTES
    ref_write = "#402f33", -- WRITE_IDENTIFIER_UNDER_CARET_ATTRIBUTES
    brace = "#43454a", -- MATCHED_BRACE_ATTRIBUTES
    folded_fg = "#868991", -- FOLDED_TEXT_ATTRIBUTES
    folded_bg = "#393b40",
    inlay_fg = "#868a91", -- INLAY_DEFAULT
    inlay_bg = "#393b40",

    -- UI (expUI_dark.theme.json) --------------------------------------------
    panel = "#2b2d30", -- Gray2: tool windows, status bar
    popup = "#2b2d30", -- LOOKUP_COLOR: completion and floats
    popup_border = "#43454a", -- Popup.borderColor (Gray4)
    border = "#393b40", -- separatorColor (Gray3)
    list_sel = "#2e436e", -- selectionBackground (Blue2)
    hover = "#393b40", -- hoverBackground (Gray3)
    muted = "#868a91", -- Gray8: secondary UI text
    subtle = "#6f737a", -- Gray7: infoForeground
    accent = "#3574f0", -- focusColor / underlineColor (Blue6)
    match = "#548af7", -- CompletionPopup.matchForeground (Blue8)

    -- Diff and VCS ------------------------------------------------------------
    diff_add = "#294436", -- DIFF_INSERTED
    diff_change = "#385570", -- DIFF_MODIFIED
    diff_delete = "#484a4a", -- DIFF_DELETED
    diff_conflict = "#45302b", -- DIFF_CONFLICT
    gutter_add = "#549159", -- ADDED_LINES_COLOR
    gutter_change = "#375fad", -- MODIFIED_LINES_COLOR
    gutter_delete = "#868a91", -- DELETED_LINES_COLOR
    vcs_added = "#73bd79", -- FILESTATUS_ADDED
    vcs_modified = "#70aeff", -- FILESTATUS_MODIFIED
    vcs_deleted = "#6f737a", -- FILESTATUS_DELETED
    vcs_untracked = "#e88f89", -- FILESTATUS_UNKNOWN
    vcs_ignored = "#d69a6b", -- FILESTATUS_IDEA_FILESTATUS_IGNORED
    vcs_conflict = "#de6a66", -- FILESTATUS_..._MERGED_WITH_CONFLICTS
    vcs_merged = "#cf84cf", -- FILESTATUS_MERGED

    -- Diagnostics -------------------------------------------------------------
    error = "#f75464", -- WRONG_REFERENCES_ATTRIBUTES
    warn = "#f2c55c", -- WARNING_ATTRIBUTES.EFFECT_COLOR (Yellow7)
    info = "#548af7", -- Blue8
    hint = "#42b1a4", -- Teal8
    ok = "#73bd79", -- Green8

    -- Hues from the New UI color ramps, for icons, kinds and the statusline ---
    red = "#db5c5c", -- Red7
    orange = "#e08855", -- Orange6
    yellow = "#f2c55c", -- Yellow7
    green = "#5fad65", -- Green7
    teal = "#24a394", -- Teal7
    blue = "#548af7", -- Blue8
    purple = "#a571e6", -- Purple8
  },

  light = {
    bg = "#ffffff", -- TEXT.BACKGROUND
    fg = "#080808", -- TEXT.FOREGROUND

    -- Syntax ------------------------------------------------------------------
    keyword = "#0033b3", -- DEFAULT_KEYWORD
    string = "#067d17", -- DEFAULT_STRING
    number = "#1750eb", -- DEFAULT_NUMBER
    comment = "#8c8c8c", -- DEFAULT_LINE_COMMENT (italic)
    doc_comment = "#8c8c8c", -- DEFAULT_DOC_COMMENT (italic)
    doc_tag = "#8c8c8c", -- DEFAULT_DOC_COMMENT_TAG (underlined)
    doc_tag_value = "#3d3d3d", -- DEFAULT_DOC_COMMENT_TAG_VALUE
    func = "#00627a", -- DEFAULT_FUNCTION_DECLARATION
    field = "#871094", -- DEFAULT_INSTANCE_FIELD (static fields and constants: italic)
    annotation = "#9e880d", -- DEFAULT_METADATA
    type_param = "#007e8a", -- TYPE_PARAMETER_NAME_ATTRIBUTES
    label = "#080808", -- DEFAULT_LABEL (underlined only)
    escape = "#0037a6", -- DEFAULT_VALID_STRING_ESCAPE
    tag = "#0033b3", -- XML_TAG_NAME -> DEFAULT_KEYWORD
    attribute = "#174ad4", -- DEFAULT_ATTRIBUTE
    custom_tag = "#008077", -- XML_CUSTOM_TAG_NAME
    link = "#006dcc", -- HYPERLINK_ATTRIBUTES
    regexp = "#264eff", -- JS.REGEXP
    todo = "#008dde", -- TODO_DEFAULT_ATTRIBUTES (italic)
    self = "#94558d", -- PY.SELF_PARAMETER
    builtin = "#000080", -- PY.BUILTIN_NAME
    kwarg = "#660099", -- PY.KEYWORD_ARGUMENT
    unused = "#808080", -- NOT_USED_ELEMENT_ATTRIBUTES
    typo = "#b0d1ab", -- TYPO (green wave under misspelled words)
    code_bg = "#f4f7f9", -- MARKDOWN_CODE_SPAN.BACKGROUND

    -- Editor ------------------------------------------------------------------
    caret = "#000000", -- CARET_COLOR
    caret_row = "#f5f8fe", -- CARET_ROW_COLOR
    selection = "#a6d2ff", -- SELECTION_BACKGROUND
    selection_inactive = "#d4e2ff", -- Blue11
    line_nr = "#aeb3c2", -- LINE_NUMBERS_COLOR
    line_nr_cur = "#767a8a", -- LINE_NUMBER_ON_CARET_ROW_COLOR
    indent = "#ebecf0", -- INDENT_GUIDE
    indent_active = "#aeb3c2", -- SELECTED_INDENT_GUIDE
    whitespace = "#adadad", -- WHITESPACES
    margin = "#ebecf0", -- RIGHT_MARGIN_COLOR
    search = "#fcd47e", -- TEXT_SEARCH_RESULT_ATTRIBUTES
    ref = "#edebfc", -- IDENTIFIER_UNDER_CARET_ATTRIBUTES
    ref_write = "#fce8f4", -- WRITE_IDENTIFIER_UNDER_CARET_ATTRIBUTES
    brace = "#93d9d9", -- MATCHED_BRACE_ATTRIBUTES
    folded_fg = "#414d41", -- FOLDED_TEXT_ATTRIBUTES
    folded_bg = "#e9f5e6",
    inlay_fg = "#7a7a7a", -- INLAY_DEFAULT
    inlay_bg = "#ededed",

    -- UI (expUI_light.theme.json) -------------------------------------------
    panel = "#f7f8fa", -- Gray13: tool windows, status bar
    popup = "#ffffff", -- LOOKUP_COLOR
    popup_border = "#b9bdc9", -- windowsPopupBorder
    border = "#dfe1e5", -- Gray11
    list_sel = "#d4e2ff", -- selectionBackground (Blue11)
    hover = "#edf3ff", -- hoverBackground (Blue12)
    muted = "#818594", -- Gray7: secondary UI text
    subtle = "#a8adbd", -- Gray8
    accent = "#3574f0", -- focusColor / underlineColor (Blue4)
    match = "#3574f0", -- CompletionPopup.matchForeground (Blue4)

    -- Diff and VCS ------------------------------------------------------------
    diff_add = "#bee6be", -- DIFF_INSERTED
    diff_change = "#c2d8f2", -- DIFF_MODIFIED
    diff_delete = "#d6d6d6", -- DIFF_DELETED
    diff_conflict = "#ffd5cc", -- DIFF_CONFLICT
    gutter_add = "#7fc784", -- ADDED_LINES_COLOR
    gutter_change = "#88adf7", -- MODIFIED_LINES_COLOR
    gutter_delete = "#767a8a", -- DELETED_LINES_COLOR
    vcs_added = "#067d17", -- FILESTATUS_ADDED
    vcs_modified = "#0033b3", -- FILESTATUS_MODIFIED
    vcs_deleted = "#6c707e", -- FILESTATUS_DELETED
    vcs_untracked = "#b23247", -- FILESTATUS_UNKNOWN
    vcs_ignored = "#8c4f00", -- FILESTATUS_IDEA_FILESTATUS_IGNORED
    vcs_conflict = "#de1b2e", -- FILESTATUS_..._MERGED_WITH_CONFLICTS
    vcs_merged = "#643cb8", -- FILESTATUS_MERGED

    -- Diagnostics (New UI ramps, picked for WCAG AA on white) -----------------
    error = "#cc3645", -- Red3
    warn = "#a46704", -- Yellow1
    info = "#315fbd", -- Blue2
    hint = "#077a7f", -- Teal2
    ok = "#1f8039", -- Green3

    -- Hues from the New UI color ramps, for icons, kinds and the statusline ---
    red = "#cc3645", -- Red3
    orange = "#ce6117", -- Orange3
    yellow = "#a46704", -- Yellow1
    green = "#208a3c", -- Green4
    teal = "#077a7f", -- Teal2
    blue = "#3574f0", -- Blue4
    purple = "#834df0", -- Purple4
  },
}

---@class jetbrains.BasePalette
---@field bg string
---@field fg string
---@field keyword string
---@field string string
---@field number string
---@field comment string
---@field doc_comment string
---@field doc_tag string
---@field doc_tag_value string
---@field func string           function and method declarations
---@field field string          fields, properties, constants, enum members
---@field annotation string     annotations, decorators, attributes
---@field type_param string
---@field label string
---@field escape string
---@field tag string
---@field attribute string
---@field custom_tag string
---@field link string
---@field regexp string
---@field todo string
---@field self string           Python `self` / `cls`
---@field builtin string        Python builtins
---@field kwarg string          Python keyword arguments
---@field unused string
---@field typo string           spell-check underline
---@field code_bg string        Markdown code spans and blocks
---@field caret string
---@field caret_row string
---@field selection string
---@field selection_inactive string
---@field line_nr string
---@field line_nr_cur string
---@field indent string
---@field indent_active string
---@field whitespace string
---@field margin string
---@field search string
---@field ref string
---@field ref_write string
---@field brace string
---@field folded_fg string
---@field folded_bg string
---@field inlay_fg string
---@field inlay_bg string
---@field panel string
---@field popup string
---@field popup_border string
---@field border string
---@field list_sel string
---@field hover string
---@field muted string
---@field subtle string
---@field accent string
---@field match string
---@field diff_add string
---@field diff_change string
---@field diff_delete string
---@field diff_conflict string
---@field gutter_add string
---@field gutter_change string
---@field gutter_delete string
---@field vcs_added string
---@field vcs_modified string
---@field vcs_deleted string
---@field vcs_untracked string
---@field vcs_ignored string
---@field vcs_conflict string
---@field vcs_merged string
---@field error string
---@field warn string
---@field info string
---@field hint string
---@field ok string
---@field red string
---@field orange string
---@field yellow string
---@field green string
---@field teal string
---@field blue string
---@field purple string

---@class jetbrains.Colors: jetbrains.BasePalette
---@field variant "light"|"dark"
---@field none "NONE"
---@field bg_float string
---@field bg_dim string       background for inactive windows (dim_inactive)
---@field on_accent string    text on `accent` fills (Button.default.foreground)
---@field calls string        function and method calls (fg, or `func` with colored_calls)
---@field diff_text string    changed words inside a modified line
---@field git { add: string, change: string, delete: string }
---@field vcs { added: string, modified: string, deleted: string, untracked: string, ignored: string, conflict: string, merged: string }
---@field diag { error: string, warn: string, info: string, hint: string, ok: string }

--- Build the full, derived color table for a variant.
---@param variant "light"|"dark"
---@param opts jetbrains.Config
---@return jetbrains.Colors
function M.get(variant, opts)
  local c = vim.deepcopy(M.base[variant]) --[[@as jetbrains.Colors]]
  local is_light = variant == "light"

  c.variant = variant
  c.none = "NONE"
  c.bg_float = c.popup
  c.bg_dim = is_light and c.panel or util.darken(c.bg, 0.15)
  c.on_accent = "#ffffff"
  -- IntelliJ paints calls in the default text color (Java, Kotlin, Python);
  -- only JS/TS color them. `colored_calls` gives every language the JS look.
  c.calls = opts.colored_calls and c.func or c.fg
  -- Word-level diff: the IDE draws changed fragments a step stronger.
  c.diff_text = util.blend(c.gutter_change, c.bg, is_light and 0.45 or 0.55)

  c.git = { add = c.gutter_add, change = c.gutter_change, delete = c.gutter_delete }
  c.vcs = {
    added = c.vcs_added,
    modified = c.vcs_modified,
    deleted = c.vcs_deleted,
    untracked = c.vcs_untracked,
    ignored = c.vcs_ignored,
    conflict = c.vcs_conflict,
    merged = c.vcs_merged,
  }
  c.diag = { error = c.error, warn = c.warn, info = c.info, hint = c.hint, ok = c.ok }

  if opts.on_colors then
    opts.on_colors(c, variant)
  end
  return c
end

return M
