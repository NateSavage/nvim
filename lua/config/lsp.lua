local roslyn_status = require('config.roslyn_status')

-- Set default root markers for all clients
--vim.lsp.config('*', {
--  root_markers = { '.git' },
--})

vim.lsp.enable('lua')
vim.lsp.enable('gdscript')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('astro')
vim.lsp.enable('nix')
vim.lsp.enable('just')

-- lazy initialization for csharp-ls matched on .sln files
vim.lsp.config('roslyn', {
    on_new_config = function(new_config, root_dir)
        local cs_solution = vim.fs.find(function(name)
            return name:match('%.sln$') ~= nil
        end, { path = root_dir, upward = true, type = 'file' })[1]

        if cs_solution then
            -- csharp-ls loads the solution via MSBuildWorkspace, which does not restore NuGet packages automatically.
            local restore = vim.system({ 'dotnet', 'restore', cs_solution }, { text = true }):wait()
            if restore.code ~= 0 then
                roslyn_status.restore_error = ('restore failed: %s'):format(vim.fs.basename(cs_solution))
                vim.notify(
                    ('dotnet restore failed for %s:\n%s'):format(
                        cs_solution,
                        restore.stderr ~= '' and restore.stderr or restore.stdout
                    ),
                    vim.log.levels.ERROR
                )
            else
                roslyn_status.restore_error = nil
            end

            new_config.cmd = { 'csharp-ls', '--solution', cs_solution }
        end
    end,
})
vim.lsp.enable('roslyn')
--vim.lsp.enable('gdshader')

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- mark buffers as loading when a managed filetype is opened without an active client
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'cs', 'csproj', 'lua', 'gdscript', 'html', 'css', 'scss', 'less', 'astro', 'nix', 'just' },
    callback = function(ev)
        if #vim.lsp.get_clients({ bufnr = ev.buf }) == 0 then
            vim.b[ev.buf].lsp_loading = true
        end
    end,
})

vim.api.nvim_create_autocmd('LspDetach', {
    callback = function(ev)
        if vim.b[ev.buf].lsp_client_name then
            vim.b[ev.buf].lsp_stopped = vim.b[ev.buf].lsp_client_name
            vim.b[ev.buf].lsp_client_name = nil
        end
    end,
})

-- global settings when an LSP is available
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.b[ev.buf].lsp_loading = false
    vim.b[ev.buf].lsp_stopped = nil
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then vim.b[ev.buf].lsp_client_name = client.name end

    if client and client.name == 'roslyn' then
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(ev.buf) then
          vim.lsp.semantic_tokens.force_refresh(ev.buf)
        end
      end, 2000)
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_definition) then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_declaration) then
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
    end

  end,
})

-- Diagnostics
-- diagnositc levels are ERROR, WARN, INFO, and HINT
vim.diagnostic.config({
    underline = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            --[vim.diagnositc.severity.INFO] = '', -- warn and info don't seem to have assignable signs yet
            --[vim.diagnositc.severity.HINT] = ''
        },
    },

    -- display hits, info, and warnings underneath a line only when the line is selected
    virtual_lines = {
        current_line = true,
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
        }
    },

    -- display error messages inline always
    --[[
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.ERROR,
            max = vim.diagnostic.severity.ERROR,
        }
    },
    --]]
})
