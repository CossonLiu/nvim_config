local config = require'cossonleo.plug_config'
local vim_plug = require'cossonleo.vim_plug'
local use = vim_plug.use

use 'kshenoy/vim-signature'
use 'terryma/vim-multiple-cursors'
use 'cossonleo/neo-comment.nvim'
use 'psliwka/vim-smoothie'
use 'tpope/vim-surround'
use 'jiangmiao/auto-pairs'
use 'cossonleo/nvim-completor'
-- use 'chrisbra/csv.vim'
use 'kyazdani42/nvim-web-devicons'
use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'
use 'whiteinge/diffconflicts'
use 'cossonleo/dirdiff.nvim'
use { 'easymotion/vim-easymotion', config = config.vim_easymotion }
use { 'luochen1990/rainbow', config = config.rainbow }
use { 'joshdick/onedark.vim', config = config.onedark }
use { 'voldikss/vim-floaterm', config = config.vim_floaterm }
use { 'norcalli/nvim-colorizer.lua', config = config.nvim_colorizer }
use { 'voldikss/vim-translator', config = config.vim_translator }
use { 'nvim-treesitter/nvim-treesitter', config = config.nvim_treesitter }
use { 'neovim/nvim-lsp', config = config.nvim_lsp }
-- use { 'Shougo/echodoc.vim', config = config.echodoc }
use { 'nvim-lua/diagnostic-nvim', config = config.diagnostic_nvim }
-- use { 'nvim-lua/lsp-status.nvim', config = config.lsp_status }
use { 'kyazdani42/nvim-tree.lua', config = config.nvim_tree }
-- use { 'cossonleo/telescope.nvim', config = config.telescope }
use { 'nvim-lua/telescope.nvim', config = config.telescope }

vim_plug.load()