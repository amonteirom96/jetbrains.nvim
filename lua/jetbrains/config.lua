local M = {}

---@alias jetbrains.Variant "light"|"dark"
---@alias jetbrains.Style vim.api.keyset.highlight
---@alias jetbrains.StyleKey "comments"|"doc_comments"|"keywords"|"functions"|"calls"|"variables"|"fields"|"strings"|"numbers"|"types"|"constants"|"operators"

---@class jetbrains.Config
---@field variant? "auto"|jetbrains.Variant  "auto" follows 'background'
---@field transparent? boolean                    no background on Normal/floats/sign column
---@field terminal_colors? boolean                set g:terminal_color_0..15 (IDE console colors)
---@field dim_inactive? boolean                   slightly different bg on unfocused windows
---@field colored_calls? boolean                  color function/method calls like declarations (JS/TS look)
---@field underline_mutable? boolean              underline reassigned/mutable variables (LSP semantic tokens)
---@field float? { solid?: boolean }              solid = filled floats without visible border
---@field styles? table<jetbrains.StyleKey, jetbrains.Style>
---@field integrations? table<string, boolean>
---@field cache? boolean                          compile highlights to bytecode (recommended)
---@field on_colors? fun(colors: jetbrains.Colors, variant: jetbrains.Variant)
---@field on_highlights? fun(hl: table<string, jetbrains.Style>, colors: jetbrains.Colors, variant: jetbrains.Variant)
M.defaults = {
  variant = "auto",
  transparent = false,
  terminal_colors = true,
  dim_inactive = false,
  colored_calls = false,
  underline_mutable = true,
  float = { solid = false },
  -- Merged over the IDE's own styles: line comments are italic in Light only,
  -- doc comments are italic in both, constants and static members are italic.
  styles = {
    comments = {},
    doc_comments = {},
    keywords = {},
    functions = {},
    calls = {},
    variables = {},
    fields = {},
    strings = {},
    numbers = {},
    types = {},
    constants = {},
    operators = {},
  },
  integrations = {
    blink = true,
    dropbar = true,
    gitsigns = true,
    grug_far = true,
    lazy = true,
    mason = true,
    mini = true, -- icons, pick, extra, files, tabline
    semantic_tokens = true,
    statusline = true, -- St* groups for a custom statusline
    treesitter = true,
  },
  cache = true,
  on_colors = nil,
  on_highlights = nil,
}

---@type jetbrains.Config
M.options = vim.deepcopy(M.defaults)

---@param opts? jetbrains.Config
function M.set(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
end

--- Deterministic serialization (sorted keys, functions as bytecode digest)
--- used to key the compiled cache. Changing any option invalidates it.
---@param v any
---@return string
local function serialize(v)
  local t = type(v)
  if t == "table" then
    local keys = vim.tbl_keys(v)
    table.sort(keys, function(a, b)
      return tostring(a) < tostring(b)
    end)
    local out = {}
    for i, k in ipairs(keys) do
      out[i] = tostring(k) .. "=" .. serialize(v[k])
    end
    return "{" .. table.concat(out, ",") .. "}"
  elseif t == "function" then
    local ok, dump = pcall(string.dump, v)
    return ok and vim.fn.sha256(dump) or tostring(v)
  end
  return tostring(v)
end

---@return string
function M.hash()
  return vim.fn.sha256(require("jetbrains").version .. serialize(M.options)):sub(1, 16)
end

return M
