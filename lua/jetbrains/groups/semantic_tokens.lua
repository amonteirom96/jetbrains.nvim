--- LSP semantic tokens. The IDE's highlighting is semantic, so this is where
--- the theme gets closest to it:
---   - a function *declaration* is blue, a *call* is plain text (or blue with
---     `colored_calls`), as in Java/Kotlin/Python;
---   - static members are italic, on top of their color;
---   - reassigned / mutable variables are underlined (`underline_mutable`);
---   - an unresolved reference turns red, like WRONG_REFERENCES_ATTRIBUTES.
--- Modifier groups set only attributes, so they combine with the type color.

---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local s = o.styles
  local call = vim.tbl_extend("force", { fg = c.calls }, s.calls)
  local func = vim.tbl_extend("force", { fg = c.func }, s.functions)
  local const = vim.tbl_extend("force", { fg = c.field, italic = true }, s.constants)
  local mutable = o.underline_mutable and { underline = true, sp = c.muted } or {}

  return {
    ["@lsp.type.comment"] = {}, -- let treesitter keep TODO markers
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfTypeKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.formatSpecifier"] = { fg = c.escape },
    ["@lsp.type.escapeSequence"] = { fg = c.escape },
    ["@lsp.type.label"] = { fg = c.label },

    -- Declarations vs. calls
    ["@lsp.type.function"] = call,
    ["@lsp.type.method"] = call,
    ["@lsp.typemod.function.declaration"] = func,
    ["@lsp.typemod.function.definition"] = func,
    ["@lsp.typemod.method.declaration"] = func,
    ["@lsp.typemod.method.definition"] = func,
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.type.macro"] = func,

    -- Types: class references stay plain; type parameters get their own teal
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { fg = c.type_param },
    ["@lsp.type.lifetime"] = { fg = c.type_param, italic = true },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.decorator"] = { fg = c.annotation },
    ["@lsp.type.attribute"] = { fg = c.annotation },
    ["@lsp.type.builtinAttribute"] = { fg = c.annotation },
    ["@lsp.type.derive"] = { fg = c.annotation },

    -- Fields, constants, enum members (DEFAULT_INSTANCE_FIELD / CONSTANT)
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.enumMember"] = const,
    ["@lsp.type.const"] = const,
    ["@lsp.type.constant"] = const,
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.variable"] = {}, -- keep treesitter (builtins, members)

    -- Modifiers (attributes only, combined with the token's color)
    ["@lsp.mod.static"] = { italic = true },
    ["@lsp.typemod.method.static"] = { italic = true },
    ["@lsp.typemod.function.static"] = { italic = true },
    ["@lsp.typemod.property.static"] = { italic = true },
    ["@lsp.typemod.variable.static"] = { fg = c.field, italic = true },
    ["@lsp.mod.mutable"] = mutable,
    ["@lsp.mod.reassigned"] = mutable,
    ["@lsp.mod.deprecated"] = { strikethrough = true },

    ["@lsp.type.unresolvedReference"] = { fg = c.error },

    -- Python (pyright / basedpyright / pylance)
    ["@lsp.type.selfParameter"] = { fg = c.self },
    ["@lsp.type.clsParameter"] = { fg = c.self },
    ["@lsp.typemod.function.builtin"] = { fg = c.builtin },
    ["@lsp.typemod.class.builtin"] = { fg = c.builtin },
    ["@lsp.typemod.function.defaultLibrary.python"] = { fg = c.builtin },
    ["@lsp.typemod.class.defaultLibrary.python"] = { fg = c.builtin },
    ["@lsp.typemod.variable.defaultLibrary.python"] = { fg = c.builtin },
  }
end
