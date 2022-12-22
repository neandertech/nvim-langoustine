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

What this plugin does is replace the original command `cmd` which was used to start LSP server 
with a modified command that prepends langoustine tracer parameters.

By default it prepends `langoustine-tracer trace` - assuming you have a `langoustine-tracer` binary set up
globally.

You can modify that by configuring the extensions section when you set up telescope:

```lua 
  require("telescope").setup({
    extensions = {
      langoustine = {
        command_prefix = { "langoustine-tracer-dev", "trace" }
      }
    }
  })
```
