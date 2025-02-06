--LOAD LAZY
require("config.lazy")

--Catppuccin theme
vim.cmd.colorscheme("catppuccin")

--Allow hyprlang to recognise hyprland files 
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

