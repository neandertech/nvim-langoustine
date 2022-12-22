local ok, telescope = pcall(require, 'telescope')

if not ok then
  error 'Install nvim-telescope/telescope.nvim'
end

-- local enable_lsp_tracer = require 'telescope._extensions.langoustine.enable_lsp_tracer'

local default_opts = {
  command_prefix = { "langoustine-tracer", "trace" }
}

local opts = {}

return telescope.register_extension {
  setup = function(ext_opts, _)
    opts = vim.tbl_extend('force', default_opts, ext_opts)
  end,
  exports = {
    enable_lsp_tracer = function(_) require("langoustine").enable_lsp_tracer(_, opts) end
  },
}
