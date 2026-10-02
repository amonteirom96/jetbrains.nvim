--- dropbar.nvim as the New UI breadcrumbs: muted path, current item in the
--- text color, kind icons colored like the completion menu.
---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local hl = {
    DropBarCurrentContext = { bg = c.hover },
    DropBarCurrentContextIcon = { bg = c.hover },
    DropBarCurrentContextName = { fg = c.fg, bg = c.hover },
    DropBarHover = { bg = c.hover },
    DropBarIconHover = { bg = c.hover },
    DropBarIconUIIndicator = { fg = c.muted },
    DropBarIconUIPickPivot = { fg = c.match, bold = true },
    DropBarIconUISeparator = { fg = c.subtle },
    DropBarIconUISeparatorMenu = { fg = c.subtle },
    DropBarMenuCurrentContext = { bg = c.list_sel },
    DropBarMenuHoverEntry = { bg = c.list_sel },
    DropBarMenuHoverIcon = { bg = c.list_sel },
    DropBarMenuHoverSymbol = { bold = true },
    DropBarMenuNormalFloat = { link = "NormalFloat" },
    DropBarMenuFloatBorder = { link = "FloatBorder" },
    DropBarMenuSbar = { link = "PmenuSbar" },
    DropBarMenuThumb = { link = "PmenuThumb" },
    DropBarFzfMatch = { fg = c.match, bold = true },
    DropBarPreview = { bg = c.ref },
    DropBarKindDir = { fg = c.muted },
    DropBarKindFile = { fg = c.fg },
    DropBarIconKindFolder = { fg = c.muted },
    DropBarIconKindTerminal = { fg = c.green },
    DropBarKindTerminal = { fg = c.fg },
  }

  -- Kind icons colored exactly like the completion menu. Names stay plain.
  for kind, key in pairs(require("jetbrains.kinds")) do
    hl["DropBarIconKind" .. kind] = { fg = c[key] }
  end

  -- Icons for dropbar's treesitter-only kinds
  for kind, key in pairs({
    Call = "func",
    Declaration = "func",
    Element = "tag",
    Identifier = "fg",
    List = "orange",
    MarkdownH1 = "keyword",
    Pair = "field",
    Scope = "keyword",
    Section = "keyword",
    Specifier = "keyword",
    Statement = "keyword",
    Table = "blue",
    Type = "blue",
    Macro = "annotation",
    Repeat = "keyword",
    IfStatement = "keyword",
    ElseStatement = "keyword",
    ForStatement = "keyword",
    WhileStatement = "keyword",
    DoStatement = "keyword",
    SwitchStatement = "keyword",
    CaseStatement = "keyword",
    BreakStatement = "keyword",
    ContinueStatement = "keyword",
    GotoStatement = "keyword",
    ReturnStatement = "keyword",
    Delete = "orange",
    Rule = "keyword",
    RuleSet = "keyword",
    BlockMappingPair = "field",
    Unit = "number",
  }) do
    hl["DropBarIconKind" .. kind] = { fg = c[key] }
  end

  return hl
end
