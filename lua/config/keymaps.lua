-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Map 'jk' in insert mode to escape
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>tt", ":tab split<CR>", { desc = "Move current window to new tab" })
vim.keymap.set("n", "<leader>co", function()
  -- Save current buffer first
  vim.cmd("silent! write")

  -- Get all project files of relevant types (customize extensions as needed)
  local extensions = { "py", "ts", "js", "go" } -- Add your file types
  local files = vim.fn.systemlist("git ls-files | grep -E '\\.(" .. table.concat(extensions, "|") .. ")$'")

  -- If not in git repo, fall back to current directory
  if #files == 0 or vim.v.shell_error ~= 0 then
    files = vim.fn.systemlist("find . -type f -regex '.*\\.\\(" .. table.concat(extensions, "\\|") .. "\\)'")
  end

  -- Process each file
  for _, file in ipairs(files) do
    -- Skip if file doesn't exist
    if vim.fn.filereadable(file) == 0 then
      goto continue
    end

    -- Open file in buffer
    vim.cmd("edit " .. vim.fn.fnameescape(file))

    -- Organize imports
    local success = pcall(function()
      vim.lsp.buf.code_action({
        filter = function(action)
          local title = action.title:lower()
          return title:match("organizeimports") or title:match("organize imports")
        end,
        apply = true,
      })
    end)

    -- Auto-indent whole file
    vim.cmd("normal! gg=G")

    -- Save changes
    vim.cmd("silent! write")

    ::continue::
  end

  -- Return to original buffer
  vim.cmd("buffer #")

  vim.notify("Organized imports and indented " .. #files .. " files", vim.log.levels.INFO)
end, { desc = "Organize Imports and Auto-Indent (Project-Wide)" })
-- Make <C-r> immediately show registers (like pressing ")
