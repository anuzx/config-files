-- init.lua
-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
  -- LazyVim core (provides sensible defaults)
  { "folke/LazyVim", import = "lazyvim.plugins" },

  -- UI & Icons
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim" },

  -- File Explorer
  { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = { "MunifTanjim/nui.nvim" } },

  -- Telescope (fuzzy finder, like VSCode search)
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Syntax highlighting & code structure
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- LSP (IntelliSense)
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" }, -- easy installer for LSP/formatters
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" }, -- autocompletion
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- Git Integration
  { "lewis6991/gitsigns.nvim" },

  -- Commenting
  { "numToStr/Comment.nvim", opts = {} },

  -- Auto pairs (brackets, quotes)
  { "windwp/nvim-autopairs", opts = {} },

  -- Formatter
  { "jose-elias-alvarez/null-ls.nvim" },

  -- Colorscheme (like vscode dark+)
  { "Mofiqul/vscode.nvim" },
})

-- ==============================
-- General Settings (VS Code Feel)
-- ==============================
vim.o.number = true         -- Line numbers
vim.o.relativenumber = true -- Relative line numbers
vim.o.termguicolors = true  -- True color
vim.o.mouse = "a"           -- Mouse support
vim.o.clipboard = "unnamedplus" -- Use system clipboard
vim.o.expandtab = true      -- Spaces instead of tabs
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Colorscheme
vim.cmd([[colorscheme vscode]])

-- Statusline
require("lualine").setup({
  options = { theme = "vscode" },
})

-- Git signs
require("gitsigns").setup()

-- Neo-tree keymap
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })

-- Telescope keymaps (like VSCode Ctrl+P, Ctrl+Shift+F)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })

-- Autopairs
require("nvim-autopairs").setup()

-- Mason (LSP installer)
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "tsserver", "pyright", "html", "cssls" }, -- auto install common LSPs
})
require("lspconfig").lua_ls.setup({})
require("lspconfig").tsserver.setup({})
require("lspconfig").pyright.setup({})
require("lspconfig").html.setup({})
require("lspconfig").cssls.setup({})

-- Autocomplete
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
  }),
})

