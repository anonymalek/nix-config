local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<Space>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<Space>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger"
    }
  }
}

return M
