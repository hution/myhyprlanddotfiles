vim.g.rustaceanvim = {
  server = {
    -- Use the new on_attach style
    on_attach = function(client, bufnr)
      -- Optional: add keybindings here
    end,
    default_settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        },
      },
    },
  },
}
