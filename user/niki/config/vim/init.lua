vim.cmd("source ~/.vimrc")

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set({"n", "i"}, "<C-k>", vim.lsp.buf.signature_help)

vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename)
vim.keymap.set({"n", "v"}, "<Leader>c", vim.lsp.buf.code_action)

