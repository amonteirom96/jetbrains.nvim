--- LSP CompletionItemKind / SymbolKind -> palette key.
--- Shared by blink.cmp, dropbar and anything else that shows kinds, so the same
--- symbol has the same color everywhere. Where the code has a color (strings,
--- numbers, fields, keywords, annotations) the kind uses it; the rest follow the
--- New UI node icons: classes blue, interfaces green, enums orange, methods
--- and functions in the declaration color.
return {
  Text = "muted",
  Method = "func",
  Function = "func",
  Constructor = "func",
  Field = "field",
  Variable = "purple",
  Class = "blue",
  Interface = "green",
  Module = "keyword",
  Property = "field",
  Unit = "number",
  Value = "number",
  Enum = "orange",
  Keyword = "keyword",
  Snippet = "teal",
  Color = "orange",
  File = "fg",
  Reference = "type_param",
  Folder = "muted",
  EnumMember = "field",
  Constant = "field",
  Struct = "blue",
  Event = "yellow",
  Operator = "fg",
  TypeParameter = "type_param",
  -- SymbolKind extras
  Namespace = "keyword",
  Package = "keyword",
  String = "string",
  Number = "number",
  Boolean = "keyword",
  Array = "orange",
  Object = "blue",
  Key = "field",
  Null = "keyword",
  -- Sources
  Copilot = "teal",
  Codeium = "teal",
  Supermaven = "teal",
}
