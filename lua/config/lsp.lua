return {
  servers = {
    -- Replace pyright with basedpyright
    basedpyright = {
      settings = {
        python = {
          analysis = {
            django = true, -- Critical for Django ORM/template support
            typeCheckingMode = "basic", -- or "strict"
          },
        },
      },
    },

    -- Django Template LSP (unchanged)
    django_template = {
      cmd = { "django-lsp" },
      filetypes = { "htmldjango", "html" },
      init_options = {
        settings = {
          django = {
            template_tags = true,
            filters = true,
          },
        },
      },
    },
  },
}
