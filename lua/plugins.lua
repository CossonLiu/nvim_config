local vim_plug = require'cossonleo.vim_plug'
local use = vim_plug.use

local config = {}

local function plug_list()
	use 'kshenoy/vim-signature'
	use 'terryma/vim-multiple-cursors'
	--use 'cossonleo/neo-comment.nvim'
	use 'psliwka/vim-smoothie'
	use 'tpope/vim-surround'
	use 'jiangmiao/auto-pairs'
	------ use 'chrisbra/csv.vim'
	use 'kyazdani42/nvim-web-devicons'
	--use 'nvim-lua/popup.nvim'
	--use 'nvim-lua/plenary.nvim'
	use 'whiteinge/diffconflicts'
	--use 'cossonleo/dirdiff.nvim'
	--use { 'luochen1990/rainbow', config = config.rainbow }
	--use { 'joshdick/onedark.vim', config = config.onedark }
	--use {'preservim/nerdtree', config = config.nerdtree}
	use {'overcache/NeoSolarized', config = config.solarized}
	use { 'voldikss/vim-floaterm', config = config.vim_floaterm }
	--use { 'norcalli/nvim-colorizer.lua', config = config.nvim_colorizer }
	use { 'voldikss/vim-translator', config = config.vim_translator }
	use { 'nvim-treesitter/nvim-treesitter', config = config.nvim_treesitter }
	--use 'p00f/nvim-ts-rainbow'
	use { 'neovim/nvim-lspconfig', config = config.nvim_lsp }
	-- use { 'kyazdani42/nvim-tree.lua', config = config.nvim_tree }
end

function config.onedark()
	vim.g.onedark_color_overrides = {black = {gui = "#000000", cterm = "235", cterm16 = 0}}
	pcall(vim.cmd, [[ colorscheme onedark ]])
end

function config.solarized()
	vim.o.background = 'light'
	pcall(vim.cmd, [[ colorscheme NeoSolarized ]])
end

function config.vim_floaterm()
	vim.g.floaterm_winblend = 10
	vim.g.floaterm_width = 0.7
	vim.g.floaterm_height = 0.8
	vim.g.floaterm_position = 'center'
	vim.g.floaterm_keymap_toggle = '<F4>'
	vim.g.floaterm_keymap_new    = '<leader><F4>'
	vim.g.floaterm_keymap_next   = '<F16>'
	vim.g.floaterm_border_color = "#FFFFFF"
end

function config.nvim_colorizer()
	local has, c = pcall(require, 'colorizer')
	if not has then return end
	c.setup(nil, { css = true; })
end

function config.vim_translator()
	vim.g.EasyMotion_do_mapping = 0
	vim.cmd[[nnoremap <silent> <leader>a :TranslateW<CR>]]
end

function config.nvim_treesitter()
	local has, ts = pcall(require, 'nvim-treesitter.configs')
	if not has then return end

	ts.setup {
		ensure_installed = 'all', -- one of 'all', 'language', or a list of languages
		highlight = { 
			enable = true, 
		},
		ident = {
			enable = true
		},
		incremental_selection = {
			enable = false,
		},
		--rainbow	= {
		--	enable	= true,
		--},
	}
end

function config.nvim_lsp()
	require("lsp_ext")
end

function config.diagnostic_nvim()
	vim.g.diagnostic_insert_delay = 1
	vim.g.diagnostic_enable_virtual_text = 1
	vim.g.space_before_virtual_text = 5
	vim.g.space_before_virtual_text = 5
	vim.g.diagnostic_enable_underline = 0

	vim.cmd[[nnoremap <silent> ]e <cmd>NextDiagnosticCycle<cr>]]
	vim.cmd[[nnoremap <silent> [e <cmd>PrevDiagnosticCycle<cr>]]
	vim.cmd[[nnoremap <silent> <leader>d <cmd>OpenDiagnostic<cr>]]
end

plug_list()

vim_plug.load()
