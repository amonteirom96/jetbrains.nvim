--- Groups for a hand-written statusline (`%#StModeNormal#`, `%#StGit#`, ...).
--- The bar itself is the IDE's status bar (panel background); each mode gets a
--- filled block from the New UI ramps plus a `Sep` group for the powerline edge.

---@param c jetbrains.Colors
---@param o jetbrains.Config
return function(c, o)
  local bg = c.panel
  local hl = {
    StProject = { fg = c.fg, bg = bg, bold = true },
    StGit = { fg = c.vcs.added, bg = bg },
    StError = { fg = c.diag.error, bg = bg },
    StWarn = { fg = c.diag.warn, bg = bg },
    StInfo = { fg = c.diag.info, bg = bg },
    StHint = { fg = c.diag.hint, bg = bg },
    StLsp = { fg = c.muted, bg = bg },
  }

  local modes = {
    Normal = c.blue,
    Insert = c.green,
    Visual = c.purple,
    Replace = c.orange,
    Command = c.yellow,
    Other = c.teal,
  }
  for mode, color in pairs(modes) do
    hl["StMode" .. mode] = { fg = c.bg, bg = color, bold = true }
    hl["StMode" .. mode .. "Sep"] = { fg = color, bg = bg }
  end

  return hl
end
