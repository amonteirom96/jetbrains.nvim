---@class jetbrains
local M = {}

--- Bump to invalidate every user's compiled cache after changing highlights.
M.version = "1.0.0"

local cache_dir = vim.fn.stdpath("cache") .. "/jetbrains"
local configured = false
local key ---@type string?

---@param opts? jetbrains.Config
function M.setup(opts)
  require("jetbrains.config").set(opts)
  configured = true
  key = nil
end

---@return jetbrains.Config
local function options()
  return require("jetbrains.config").options
end

---@return string
local function cache_key()
  if not key then
    key = configured and require("jetbrains.config").hash() or ("default-" .. M.version)
  end
  return key
end

---@param name string
---@return jetbrains.Variant
local function resolve_variant(name)
  if name == "jetbrains-light" then
    return "light"
  elseif name == "jetbrains-dark" then
    return "dark"
  end
  local v = options().variant
  if v == "light" or v == "dark" then
    return v
  end
  return vim.o.background == "light" and "light" or "dark"
end

--- Full palette (base + derived) for a variant, after `on_colors`.
---@param variant? jetbrains.Variant defaults to the current 'background'
---@return jetbrains.Colors
function M.colors(variant)
  return require("jetbrains.palette").get(variant or resolve_variant("jetbrains"), options())
end

--- Final highlight table for a variant, after `on_highlights`.
---@param variant? jetbrains.Variant
---@return table<string, jetbrains.Style>
function M.highlights(variant)
  local o = options()
  return require("jetbrains.groups").get(M.colors(variant), o)
end

---@param name string
---@param variant jetbrains.Variant
---@return string
local function build(name, variant)
  local o = options()
  local c = require("jetbrains.palette").get(variant, o)
  local hl = require("jetbrains.groups").get(c, o)
  local term = o.terminal_colors and require("jetbrains.terminal").ansi(c) or nil
  return require("jetbrains.compiler").source(name, variant, hl, term)
end

---@param prefix string
---@param keep string
local function prune(prefix, keep)
  for file in vim.fs.dir(cache_dir) do
    if vim.startswith(file, prefix) and file ~= keep then
      os.remove(cache_dir .. "/" .. file)
    end
  end
end

--- Entry point used by `colors/*.lua`.
---@param name? "jetbrains"|"jetbrains-light"|"jetbrains-dark"
function M.load(name)
  name = name or "jetbrains"
  local variant = resolve_variant(name)

  if not options().cache then
    return assert(load(build(name, variant), "=jetbrains"))()
  end

  local prefix = name .. "_" .. variant .. "_"
  local file = prefix .. cache_key()
  local path = cache_dir .. "/" .. file
  local fn = loadfile(path)
  if not fn then
    fn = require("jetbrains.compiler").write(build(name, variant), path)
    prune(prefix, file)
  end
  fn()
end

--- Rebuild the cache for the active colorscheme (e.g. after editing an
--- `on_highlights` closure whose upvalues changed).
function M.compile()
  M.clear_cache()
  local name = vim.g.colors_name
  if name and vim.startswith(name, "jetbrains") then
    vim.cmd.colorscheme(name)
  end
end

function M.clear_cache()
  vim.fn.delete(cache_dir, "rf")
  key = nil
end

--- Generate terminal/tool themes (ghostty, kitty, lazygit) from the palette.
---@param dir? string output directory, defaults to `<plugin>/extras`
function M.extras(dir)
  return require("jetbrains.extras").generate(dir)
end

return M
