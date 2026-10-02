--- Legacy syntax groups, mapped onto the IntelliJ "Language Defaults":
--- keywords, strings, numbers and comments get their own color, declarations of
--- functions are blue, fields and constants purple (constants italic) and
--- annotations olive. Class names, variables, parameters and operators stay in
--- the default text color, exactly like the IDE. `true`, `false` and `null`
--- are keywords there, so they share the keyword color.

---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local s = o.styles

  ---@param color string
  ---@param style? jetbrains.Style user style, merged last
  ---@param base? jetbrains.Style the IDE's own attributes
  local function with(color, style, base)
    return vim.tbl_extend("force", { fg = color }, base or {}, style or {})
  end

  local comment = with(c.comment, s.comments, { italic = c.variant == "light" })
  local doc = with(c.doc_comment, s.doc_comments, { italic = true })
  local keyword = with(c.keyword, s.keywords)
  local func = with(c.func, s.functions)
  local str = with(c.string, s.strings)
  local num = with(c.number, s.numbers)
  local const = with(c.field, s.constants, { italic = true })
  local typ = with(c.fg, s.types)

  return {
    Comment = comment,
    SpecialComment = doc,

    Constant = const,
    String = str,
    Character = str,
    Number = num,
    Float = num,
    Boolean = keyword,

    Identifier = with(c.fg, s.variables),
    Function = func,

    Statement = keyword,
    Conditional = keyword,
    Repeat = keyword,
    Label = keyword,
    Keyword = keyword,
    Exception = keyword,
    Operator = with(c.fg, s.operators),

    PreProc = keyword,
    Include = keyword,
    Define = keyword,
    Macro = keyword,
    PreCondit = keyword,

    Type = typ,
    StorageClass = keyword,
    Structure = keyword,
    Typedef = keyword,

    Special = { fg = c.escape },
    SpecialChar = { fg = c.escape },
    Tag = { fg = c.tag },
    Delimiter = { fg = c.fg },
    Debug = { fg = c.fg },

    Underlined = { fg = c.link, underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = c.unused },
    Error = { fg = c.error },
    Todo = { fg = c.todo, italic = true },
  }
end
