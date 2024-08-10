local lspconfig = require("lspconfig")
local coq = require("coq")

require('java').setup()

lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
}))

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup(coq.lsp_ensure_capabilities({}))
lspconfig.phpactor.setup(coq.lsp_ensure_capabilities({}))
lspconfig.jdtls.setup(coq.lsp_ensure_capabilities({}))
