vim.lsp.enable({ 'lua_ls', 'gopls', 'rust_analyzer' })

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    prefix = '●',
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buf = ev.buf, desc = desc })
    end

    -- Keymaps
    map('n', '<leader>d', vim.diagnostic.open_float, 'LSP: Show Diagnostic')
    map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover docs')
    map('n', 'gK', vim.lsp.buf.signature_help, 'LSP: Signature help')
    map('i', '<C-k>', vim.lsp.buf.signature_help, 'LSP: Signature help')

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
    -- Enable inlayHints
    if client and client:supports_method('textDocument/inlayHint') and vim.bo[ev.buf].filetype == 'go' then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
    -- Auto-format ("lint") on save.
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
