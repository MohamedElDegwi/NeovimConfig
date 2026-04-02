local root_markers1 = {
	'.emmyrc.json',
	'.luarc.json',
	'.luarc.jsonc',
}

local root_markers2 = {
	'.luacheckrc',
}

return {
cmd = { 'lua-language-server' },
filetypes = { 'lua' },
root_markers = vim.fn.has('nvim-0.12.0') == 1 and { root_markers1, root_markers2, { '.git' }},

vim.lsp.config('lua_ls', {
   on_init = function(client)
     if client.workspace_folders then
       local path = client.workspace_folders[1].name
       if
         path ~= vim.fn.stdpath('config')
         and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
       then
         return
       end
     end

     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
       runtime = {
         version = 'LuaJIT',
         path = {
           'lua/?.lua',
           'lua/?/init.lua',
         },
       },
       workspace = {
         checkThirdParty = false,
         library = {
           vim.env.VIMRUNTIME,
         },
       },
     })
   end,
   settings = {
     Lua = {
	hint = { enable = true, semicolon = 'Disable' },
     },
   },
 })
 }
