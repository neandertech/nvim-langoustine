return require("telescope").register_extension {
  setup = function(ext_config, config)
  end,
  exports = {
    enable_lsp_tracer = require("langoustine").enable_lsp_tracer
  },
}
