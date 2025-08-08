vim.cmd("filetype plugin indent on")

require("lazy").setup({
  -- Treesitter with explicit languages to ensure asm support
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "asm" }, -- install C and asm parsers
        highlight = { enable = true },
      }
    end,
  },

  { "neovim/nvim-lspconfig" },

  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },

  { "L3MON4D3/LuaSnip" },

  -- vim-gas is a Vim syntax plugin, no config needed but you can keep it here
  { "Shirk/vim-gas" },

  { "nvim-tree/nvim-tree.lua" },

  { "tpope/vim-sleuth" },
})

-- clangd setup for C language server
require("lspconfig").clangd.setup({})

-- nvim-cmp setup for autocompletion
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  sources = { { name = "nvim_lsp" } },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
})

-- nvim-tree setup for file explorer
require("nvim-tree").setup({})

vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Optional: indent fallback for C and asm files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "asm" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
  end,
})

