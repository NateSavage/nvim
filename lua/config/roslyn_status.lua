-- Tiny shared state module so lualine.lua can show what the dotnet restore
-- step in lsp.lua's on_new_config actually did, instead of that only ever
-- surfacing as a one-off vim.notify popup that's easy to miss.
return {
    -- Set to a short message on the most recent `dotnet restore` failure for
    -- a csharp-ls root, or nil once a restore succeeds (or hasn't run yet).
    restore_error = nil,
}
