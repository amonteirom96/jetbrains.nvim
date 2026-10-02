if vim.g.loaded_jetbrains then
  return
end
vim.g.loaded_jetbrains = true

local cmd = vim.api.nvim_create_user_command

cmd("JetbrainsCompile", function()
  require("jetbrains").compile()
end, { desc = "jetbrains: rebuild the compiled highlight cache" })

cmd("JetbrainsClearCache", function()
  require("jetbrains").clear_cache()
end, { desc = "jetbrains: delete the compiled highlight cache" })

cmd("JetbrainsExtras", function(args)
  local out = require("jetbrains").extras(args.args ~= "" and args.args or nil)
  vim.notify("jetbrains: extras written to " .. out)
end, { nargs = "?", complete = "dir", desc = "jetbrains: generate ghostty/kitty/lazygit themes" })
