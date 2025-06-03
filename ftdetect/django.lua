-- ~/.config/nvim/ftdetect/django.lua
vim.filetype.add({
  extension = {
    html = function()
      if vim.fn.search("{%", "nw") > 0 then
        return "htmldjango"
      end
      return "html"
    end,
  },
})
