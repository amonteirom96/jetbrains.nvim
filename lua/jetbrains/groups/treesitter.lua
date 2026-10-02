--- Treesitter captures, following the IntelliJ attribute each one maps to.
--- Declarations and calls are told apart the way the IDE does it: `@function`
--- (declaration) is blue, `@function.call` is plain text unless
--- `colored_calls` is on. Language-specific captures reproduce the plugin
--- schemes (PythonDarcula/PythonDefault, XML, Markdown, JS).

---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local s = o.styles
  local fg = c.fg

  ---@param color string
  ---@param style? jetbrains.Style
  ---@param base? jetbrains.Style
  local function with(color, style, base)
    return vim.tbl_extend("force", { fg = color }, base or {}, style or {})
  end

  local keyword = with(c.keyword, s.keywords)
  local func = with(c.func, s.functions)
  local call = with(c.calls, s.calls)
  local field = with(c.field, s.fields)
  local const = with(c.field, s.constants, { italic = true })
  local str = with(c.string, s.strings)
  local num = with(c.number, s.numbers)
  local typ = with(fg, s.types)
  local var = with(fg, s.variables)
  local comment = with(c.comment, s.comments, { italic = c.variant == "light" })
  local doc = with(c.doc_comment, s.doc_comments, { italic = true })
  local todo = { fg = c.todo, italic = true }

  return {
    -- Identifiers -------------------------------------------------------------
    ["@variable"] = var,
    ["@variable.builtin"] = keyword, -- this, super, self (Rust/Lua)
    ["@variable.parameter"] = var,
    ["@variable.parameter.builtin"] = keyword,
    ["@variable.member"] = field, -- DEFAULT_INSTANCE_FIELD
    ["@property"] = field,

    ["@constant"] = const, -- DEFAULT_CONSTANT (italic)
    ["@constant.builtin"] = keyword, -- true/false/null are keywords
    ["@constant.macro"] = const,
    ["@module"] = { fg = fg },
    ["@module.builtin"] = { fg = fg },
    ["@label"] = { fg = c.label, sp = c.subtle, underline = c.variant == "light" },

    -- Literals ----------------------------------------------------------------
    ["@string"] = str,
    ["@string.documentation"] = doc, -- docstrings are doc comments
    ["@string.regexp"] = { fg = c.regexp },
    ["@string.escape"] = { fg = c.escape },
    ["@string.special"] = { fg = c.escape },
    ["@string.special.symbol"] = field,
    ["@string.special.url"] = { fg = c.link, underline = true },
    ["@string.special.path"] = str,
    ["@character"] = str,
    ["@character.special"] = { fg = c.escape },
    ["@boolean"] = keyword,
    ["@number"] = num,
    ["@number.float"] = num,

    -- Types -------------------------------------------------------------------
    ["@type"] = typ, -- class references are plain text in the IDE
    ["@type.builtin"] = keyword, -- int, boolean, void...
    ["@type.definition"] = typ,
    ["@type.qualifier"] = keyword,
    ["@attribute"] = { fg = c.annotation }, -- annotations, decorators
    ["@attribute.builtin"] = { fg = c.annotation },

    -- Functions ---------------------------------------------------------------
    ["@function"] = func, -- DEFAULT_FUNCTION_DECLARATION
    ["@function.builtin"] = call,
    ["@function.call"] = call, -- DEFAULT_FUNCTION_CALL
    ["@function.macro"] = func,
    ["@function.method"] = func,
    ["@function.method.call"] = call,
    ["@constructor"] = typ,
    ["@operator"] = with(fg, s.operators),

    -- Keywords ----------------------------------------------------------------
    ["@keyword"] = keyword,
    ["@keyword.coroutine"] = keyword,
    ["@keyword.function"] = keyword,
    ["@keyword.operator"] = keyword,
    ["@keyword.import"] = keyword,
    ["@keyword.type"] = keyword,
    ["@keyword.modifier"] = keyword,
    ["@keyword.repeat"] = keyword,
    ["@keyword.return"] = keyword,
    ["@keyword.debug"] = keyword,
    ["@keyword.exception"] = keyword,
    ["@keyword.conditional"] = keyword,
    ["@keyword.directive"] = keyword,
    ["@keyword.directive.define"] = keyword,

    -- Punctuation -------------------------------------------------------------
    ["@punctuation"] = { fg = fg },
    ["@punctuation.delimiter"] = { fg = fg },
    ["@punctuation.bracket"] = { fg = fg },
    ["@punctuation.special"] = { fg = c.keyword }, -- ${ } in template strings

    -- Comments ----------------------------------------------------------------
    ["@comment"] = comment,
    ["@comment.documentation"] = doc,
    -- TODO patterns: the IDE paints TODO and FIXME alike.
    ["@comment.todo"] = todo,
    ["@comment.note"] = todo,
    ["@comment.warning"] = todo,
    ["@comment.error"] = todo,

    -- Markup / tags -----------------------------------------------------------
    ["@tag"] = { fg = c.tag },
    ["@tag.builtin"] = { fg = c.tag },
    ["@tag.attribute"] = { fg = c.attribute },
    ["@tag.delimiter"] = { fg = c.tag },

    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = c.keyword, bold = true },
    ["@markup.heading.1.delimiter.vimdoc"] = { fg = c.subtle },
    ["@markup.heading.2.delimiter.vimdoc"] = { fg = c.subtle },
    ["@markup.quote"] = { fg = c.comment, italic = true },
    ["@markup.math"] = { fg = c.string },
    ["@markup.link"] = { fg = c.link },
    ["@markup.link.label"] = { fg = c.link, underline = true },
    ["@markup.link.url"] = { fg = c.link, underline = true },
    ["@markup.raw"] = { fg = fg, bg = c.code_bg },
    ["@markup.raw.block"] = { fg = fg },
    ["@markup.list"] = { fg = c.keyword },
    ["@markup.list.checked"] = { fg = c.ok },
    ["@markup.list.unchecked"] = { fg = c.subtle },

    ["@diff.plus"] = { fg = c.vcs.added },
    ["@diff.minus"] = { fg = c.red },
    ["@diff.delta"] = { fg = c.vcs.modified },

    -- Language specifics (plugin color schemes) -------------------------------
    -- Python: PY.SELF_PARAMETER, PY.BUILTIN_NAME, decorators, docstrings
    ["@variable.builtin.python"] = { fg = c.self },
    ["@function.builtin.python"] = { fg = c.builtin },
    ["@type.builtin.python"] = { fg = c.builtin },
    ["@attribute.python"] = { fg = c.annotation },
    -- Kotlin/Java: labels (`break@outer`), annotations
    ["@label.kotlin"] = { fg = c.label },
    ["@attribute.java"] = { fg = c.annotation },
    -- HTML / XML / JSX: custom components get HTML_CUSTOM_TAG_NAME
    ["@tag.javascript"] = { fg = c.custom_tag },
    ["@tag.tsx"] = { fg = c.custom_tag },
    ["@tag.builtin.javascript"] = { fg = c.tag },
    ["@tag.builtin.tsx"] = { fg = c.tag },
    -- JSON / YAML / TOML keys are properties
    ["@property.json"] = field,
    ["@property.yaml"] = { fg = c.keyword },
    ["@property.toml"] = { fg = c.keyword },
    -- Lua: `self`
    ["@variable.builtin.lua"] = keyword,
  }
end
