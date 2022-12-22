This plugin provides a VERY basic automation to restart any LSP client 
with [tracing](https://neandertech.github.io/langoustine/tracer.html) enabled.

```lua
use({
    "neandertech/nvim-langoustine",
    requires = {
      { "nvim-telescope/telescope.nvim" }
    },
})
```

It is packaged as a Telescope extension, so you will need to load it as such (this goes into your `init.lua`):

```lua
require('telescope').load_extension 'langoustine'
```

You can then invoke (or bind to a hotkey) the following command:

```lua
:Telescope langoustine enable_lsp_tracer
```

