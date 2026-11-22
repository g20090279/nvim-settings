# Local debugger configuration

The shared debugger configuration works without a local file. To add private
paths, adapter locations, or project-specific launch configurations:

1. Copy `lua/config/debugger_local.example.lua` to
   `lua/config/debugger_local.lua`. If you already have a local file, keep it
   and use the example as a guide instead of overwriting it.
2. Edit the local file: uncomment the examples you need and replace their
   placeholder paths and arguments with your own.
3. Restart Neovim. The local file is loaded after the shared DAP configuration.

`debugger_local.lua` is ignored by Git; the example file is intended to be
tracked. Keep private information in the local file, not the example. Ignoring
a file does not remove information already committed to Git history.
