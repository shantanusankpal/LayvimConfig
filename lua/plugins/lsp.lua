return {
  {
    "microsoft/python-type-stubs",
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = { enabled = false }

      opts.servers = opts.servers or {}

      opts.servers.basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              stubPath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "python-type-stubs"),
              typeCheckingMode = "basic",
              -- ignore = { "reportUnreachable" },
              django = true,
              disableOrganizeImports = false,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      }
      opts.servers.djlsp = {
        cmd = { "/home/shantanu/.local/share/nvim/mason/bin/djlsp" }, -- Or full path: "/path/to/django-lsp"
        filetypes = { "htmldjango", "html" },
        init_options = {
          settings = {
            django = {
              template_tags = true, -- Enable {% tag %} support
              filters = true, -- Enable {{ variable|filter }} support
            },
          },
        },
      }
    end,
  },
}
