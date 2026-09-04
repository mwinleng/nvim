 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#171c27',
    base01 = '#262f40',
    base02 = '#222a3a',
    base03 = '#626771',
    base04 = '#afb1b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#a866cc',
    base0A = '#6d5cd6',
    base0B = '#6793e4',
    base0C = '#cb96e9',
    base0D = '#93b2ec',
    base0E = '#a196e9',
    base0F = '#c5bef4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#171c27' })
  hi('TelescopeBorder',         { fg = '#626771',             bg = '#171c27' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#171c27' })
  hi('TelescopePromptBorder',   { fg = '#626771',             bg = '#171c27' })
  hi('TelescopePromptPrefix',   { fg = '#6793e4',             bg = '#171c27' })
  hi('TelescopePromptCounter',  { fg = '#afb1b6',  bg = '#171c27' })
  hi('TelescopePromptTitle',    { fg = '#171c27',             bg = '#6793e4' })
  hi('TelescopePreviewTitle',   { fg = '#171c27',             bg = '#6d5cd6' })
  hi('TelescopeResultsTitle',   { fg = '#171c27',             bg = '#a866cc' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#222a3a' })
  hi('TelescopeSelectionCaret', { fg = '#6793e4',             bg = '#222a3a' })
  hi('TelescopeMatching',       { fg = '#6793e4',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
