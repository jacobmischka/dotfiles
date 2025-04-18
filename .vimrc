" Current config assumes nvim and vim-plug

" Disable this to disable heavier config options for lightweight environments
let g:full_config = 1

" vim mode preferred!
set nocompatible

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
	set termguicolors
endif

" set xterm title, and inform vim of screen/tmux's syntax for doing the same
set titlestring=nvim\ %{expand(\"%t\")}
if &term =~ "^screen"
	" pretend this is xterm.  it probably is anyway, but if term is left as
	" `screen`, vim doesn't understand ctrl-arrow.
	if &term == "screen-256color"
		set term=xterm-256color
	else
		set term=xterm
	endif

	" gotta set these *last*, since `set term` resets everything
	set t_ts=k
	set t_fs=\
endif
set title

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" backups and other junky files
set backupdir=~/.vim/backup     " get backups outta here
set directory=~/.vim/swap       " get swapfiles outta here
set writebackup                 " temp backup during write
set undodir=~/.vim/undo         " persistent undo storage
set undofile                    " persistent undo on

" user interface
set history=1000                " remember command mode history
set laststatus=2                " always show status line
set lazyredraw                  " don't update screen inside macros, etc
set number                      " line numbers
set matchtime=2                 " ms to show the matching paren for showmatch
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set showmatch                   " show matching brackets while typing
"set relativenumber              " line numbers spread out from 0
set cursorline                  " highlight current line
set display=lastline,uhex       " show last line even if too long; use <xx>

" Naive native indent guides
" set list lcs=tab:\|\

" regexes
set incsearch                   " do incremental searching
set ignorecase                  " useful more often than not
set smartcase                   " case-sens when capital letters
set gdefault	                " s///g by default

" whitespace
set autoindent                  " keep indenting on <CR>
set shiftwidth=4                " one tab = four spaces (autoindent)
set softtabstop=-1              " Disable sts
set tabstop=4					" Tabs are 4 characters
set shiftround                  " only indent to multiples of shiftwidth
set fileformats=unix,dos        " unix linebreaks in new files please
set listchars=tab:↹·,extends:⇉,precedes:⇇,trail:␠,nbsp:␣,space:⋅,eol:↴
                                " appearance of invisible characters
set formatoptions=crqlj         " wrap comments, never autowrap long lines

" wrapping
"set colorcolumn=+1              " highlight 81st column
set linebreak                   " break on what looks like boundaries
set showbreak=↳\                " shown at the start of a wrapped line
set virtualedit=block           " allow moving visual block into the void


" gui stuff
set mouse=a                     " terminal mouse when possible
set guifont=Fira\ Code\ Retina:h9
set guicursor+=a:blinkon1000

" unicode
set encoding=utf-8              " best default encoding
setglobal fileencoding=utf-8    " ...
set nobomb                      " do not write utf-8 BOM!
set fileencodings=ucs-bom,utf-8,iso-8859-1
                                " order to detect Unicodeyness

set updatetime=250

" miscellany
set autoread                    " reload changed files
set scrolloff=2                 " always have 2 lines of context on the screen
set foldmethod=syntax
set foldlevel=99
set timeoutlen=1000				" wait 1s for mappings to finish
set ttimeoutlen=0				" wait 0s for xterm keycodes to finish
set nrformats-=octal            " don't try to auto-increment 'octal'
set grepprg=rg\ --vimgrep

set splitright
set splitbelow
set diffopt+=vertical
set hidden
set wildmode=longest,list,full
set wildmenu

set completeopt=menuone,noselect

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings

" Stuff that clobbers default bindings
" Force ^U and ^W in insert mode to start a new undo group
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Leader
let mapleader = ' '
let g:mapleader = ' '
let maplocalleader = ','
let g:maplocalleader = ','

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'

" For vim-table-mode to not clobber with Align
let g:table_mode_tableize_map = '<Leader>tct'

" Disable F1 Help
map <F1> <Esc>
imap <F1> <Esc>

" Ctrl+backspace delete word
" Doesn't work in gnome-terminal, works in neovim-qt
imap <C-BS> <C-W>

" System clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y

vnoremap <leader>d "+d
nnoremap <leader>D "+dg_
nnoremap <leader>d "+d

vnoremap <leader>x "+x
nnoremap <leader>X "+xg_
nnoremap <leader>x "+x

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Copy current paths to system clipboard
" Relative path
nnoremap <leader>cf :let @+=expand("%")<CR>
" Absolute path
nnoremap <leader>cF :let @+=expand("%:p")<CR>
" Basename
nnoremap <leader>ct :let @+=expand("%:t)<CR>
" Parent directory
nnoremap <leader>ch :let @+=expand("%:p:h")<CR>

imap <C-C> "+y
imap <C-X> "+x
inoremap <C-Q> <C-V>
cnoremap <C-Q> <C-V>
imap <C-V> <C-R>+
cmap <C-V> <C-R>+

" Saving
nmap <C-S> :w<CR>
imap <C-S> <Esc>:w<CR>a

" Reload all open buffers
nmap <A-y> :bufdo e<CR>

" Text objects
" ib = inner buffer
onoremap ib :exec "normal! ggVG"<CR>

" iv = current viewable text in the buffer
onoremap iv :exec "normal! HVL"<CR>

" Insert date
nnoremap <F5> "=strftime("%Y-%m-%d")<CR>p
nnoremap <leader><F5> "=strftime("%Y-%m-%d")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>

" From http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines
" Shift-Alt-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><S-A-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><S-A-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Move lines
" From http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Scroll faster
nnoremap <C-e> 10<C-e>
nnoremap <C-y> 10<C-y>

nnoremap <C-CR> i<CR><Esc>

nmap <silent> ]h :cn<CR>
nmap <silent> [h :cp<CR>

" Select previous paste
nnoremap gp `[v`]

" Search for current word
" http://vim.wikia.com/wiki/Search_for_current_word_in_multiple_files
nnoremap gr :grep <cword><CR>

inoremap <silent><F2> <Esc>v`^me<Esc>gi<C-o>:call Ender()<CR>
function! Ender()
	let endchar = nr2char(getchar())
	execute "normal \<End>a".endchar
	normal `e
	normal me
endfunction

" Disable arrow movement in normal mode, resize splits instead.
nnoremap <C-Up>    :resize +1<CR>
nnoremap <C-Down>  :resize -1<CR>
nnoremap <C-Left>  :vertical resize -1<CR>
nnoremap <C-Right> :vertical resize +1<CR>
nnoremap <Up>    :resize +10<CR>
nnoremap <Down>  :resize -10<CR>
nnoremap <Left>  :vertical resize -10<CR>
nnoremap <Right> :vertical resize +10<CR>

" Highlight current line (requires LineHighlight highlight definition)
nnoremap <leader>l :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>

" Clear all highlights
nnoremap <leader>cl :call clearmatches()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous autocmds

" Automatically delete swapfiles older than the actual file.
" Look at this travesty.  vim already has this information but doesn't expose
" it, so I have to reparse the swap file.  Ugh.
function! s:SwapDecide()
python << endpython
import os
import struct

import vim

# Format borrowed from:
# https://github.com/nyarly/Vimrc/blob/master/swapfile_parse.rb
SWAPFILE_HEADER = "=BB10sLLLL40s40s898scc"
size = struct.calcsize(SWAPFILE_HEADER)
with open(vim.eval('v:swapname'), 'rb') as f:
    buf = f.read(size)
(
    id0, id1, vim_version, pagesize, writetime,
    inode, pid, uid, host, filename, flags, dirty
) = struct.unpack(SWAPFILE_HEADER, buf)

try:
    # Test whether the pid still exists.  Could get fancy and check its name
    # or owning uid but :effort:
    os.kill(pid, 0)
except OSError:
    # NUL means clean, \x55 (U) means dirty.  Yeah I don't know either.
    if dirty == b'\x00':
        # Appears to be from a crash, so just nuke it
        vim.command('let v:swapchoice = "d"')

endpython
endfunction

if has("python")
    augroup eevee_swapfile
        autocmd!
        autocmd SwapExists * call s:SwapDecide()
    augroup END
endif

let g:markdown_fenced_languages = ['html', 'javascript', 'python', 'rust', 'svelte', 'c', 'bash']

let g:polyglot_disabled = ['autoindent', 'svelte']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
call plug#begin('~/.vim/plugged')

" Essentials
Plug 'tiagovla/scope.nvim'
Plug 'akinsho/bufferline.nvim'

Plug 'sheerun/vim-polyglot'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

Plug 'windwp/nvim-autopairs'
Plug 'wakatime/vim-wakatime'

Plug 'kylechui/nvim-surround'

Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'chaoren/vim-wordmotion'
Plug 'gbprod/yanky.nvim'
Plug 'mhinz/vim-sayonara'

" File types and syntaxes
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rust-lang/rust.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'lervag/vimtex'

" Colorschemes
Plug 'sainnhe/gruvbox-material'
Plug 'folke/tokyonight.nvim'
Plug 'sainnhe/edge'
Plug 'RRethy/nvim-base16'
Plug 'lourenci/github-colors'
Plug 'sainnhe/sonokai'
Plug 'dracula/vim'
Plug 'Mofiqul/adwaita.nvim'
Plug 'glepnir/zephyr-nvim'
Plug 'savq/melange'
Plug 'tjdevries/colorbuddy.vim'
Plug 'bkegley/gloombuddy'

" Heavier
if get(g:, 'full_config')
	Plug 'folke/snacks.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'simrat39/rust-tools.nvim'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'nvim-tree/nvim-tree.lua'
	Plug 'ray-x/lsp_signature.nvim'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'folke/lsp-colors.nvim'
	Plug 'windwp/nvim-ts-autotag'

	Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	" Plug 'zbirenbaum/neodim'
	Plug 'p00f/nvim-ts-rainbow'
	Plug 'JoosepAlviste/nvim-ts-context-commentstring'

	Plug 'cshuaimin/ssr.nvim'
	Plug 'sindrets/diffview.nvim'
	Plug 'numToStr/Comment.nvim'
	Plug 'kazhala/close-buffers.nvim'
	Plug 'kana/vim-repeat'
	Plug 'kshenoy/vim-signature'
	Plug 'Valloric/MatchTagAlways'
	Plug 'justinmk/vim-gtfo'
	Plug 'arthurxavierx/vim-caser'
	Plug 'DougBeney/pickachu'
	Plug 'xolox/vim-misc'
	Plug 'xolox/vim-session'
	Plug 'luochen1990/rainbow'
	Plug 'lukas-reineke/indent-blankline.nvim'

	Plug 'junegunn/fzf'
	Plug 'nvim-lua/plenary.nvim'
	" Plug 'nvim-telescope/telescope.nvim'
	" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }
	" Plug 'nvim-telescope/telescope-ui-select.nvim'
	Plug 'mcchrish/nnn.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'severin-lemaignan/vim-minimap', {'do': ':!cargo install --locked code-minimap'}
	Plug 'kevinhwang91/nvim-bqf'
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-abolish'
	Plug 'ap/vim-css-color'
	Plug 'NvChad/nvim-colorizer.lua'
	Plug 'amadeus/vim-convert-color-to'
	Plug 'Quramy/vim-js-pretty-template'
	Plug 'godlygeek/tabular'
	Plug 'wesQ3/vim-windowswap'
	Plug 'moll/vim-node'
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
	Plug 'majutsushi/tagbar'
	Plug 'vim-php/tagbar-phpctags.vim', {'do': 'make'}
	Plug 'ryanoasis/vim-devicons'
	Plug 'mbbill/undotree'

	Plug 'cplaursen/vim-isabelle'
	Plug 'whonore/Coqtail'

	" Formatters
	Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
	" After upgrading python, nvim will usually launch with an error
	" saying that the black module can't be found.
	" To fix this, `rm -r ~/.local/share/nvim/black` and relaunch.
	Plug 'psf/black', { 'branch': 'stable' }
	Plug 'vim-scripts/Align'
	Plug 'vim-scripts/SQLUtilities'

	" Git
	Plug 'gregsexton/gitv'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
	Plug 'tommcdo/vim-fubitive'
	Plug 'shumphrey/fugitive-gitlab.vim'
	Plug 'christoomey/vim-conflicted'
	Plug 'rhysd/conflict-marker.vim'
endif

call plug#end()

let g:html_indent_style1 = 'inc'
let g:html_indent_script1 = 'inc'
let g:html_indent_inctags = 'html,body,head,tbody,p'

let g:wordmotion_mappings = {
\	'w': '<A-w>',
\	'b': '<A-b>',
\	'e': '<A-e>',
\	'ge': 'g<A-e>',
\	'aw': 'a<A-w>',
\	'iw': 'i<A-w>',
\	'<C-R><C-W>': '<C-R><A-w>'
\}

let g:WebDevIconsUnicodeDecorateFolderNodes = 1

let g:jsx_ext_required = 0

let g:rustfmt_autosave = 1

let g:AutoPairsCenterLine = 0

let g:pandoc#formatting#mode = 'h'
let g:pandoc#modules#disabled = ['completion']
let g:pandoc#filetypes#pandoc_markdown = 0

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:vimtex_compiler_progname = 'nvr'
set conceallevel=1
let g:tex_conceal='abdmg'

" Settings
if get(g:, 'full_config')

	let g:session_autoload = 'no'
	let g:session_autosave = 'no'
	let g:session_menu = 0

	" use <tab> for trigger completion and navigate to the next complete item
	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
	endfunction

	let g:mta_filetypes = {
	\	'html': 1,
	\	'htmldjango': 1,
	\	'javascript.jsx': 1,
	\	'jsx': 1,
	\	'njk': 1,
	\	'svelte': 1,
	\	'vue': 1,
	\	'xhtml': 1,
	\	'xml': 1
	\}

	let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.njk,*.svelte,*.js,*.jsx,*.tsx,*.vue,*.blade.php'
	let g:closetag_filetypes = 'xml,html,xhtml,htmldjango,svelte,jsx,javascript.jsx,typescriptreact,vue,blade'

	let g:pickachu_default_date_format = "%Y-%m-%d"

	let g:yoinkIncludeDeleteOperations = 1

	let g:nremap = {'[e': '', ']e': ''}

	call jspretmpl#register_tag('css', 'css')
	" call jspretmpl#register_tag('gql', 'graphql')

	let g:rainbow_active = 1

	let g:prettier#autoformat_config_present = 1
	let g:prettier#autoformat_require_pragma = 0
	let g:prettier#autoformat_config_files = [".prettierrc.json", ".prettierrc"]

	let g:svelte_preprocessors = ['typescript']
endif

" Keymaps
map <C-H> :BufferLineCyclePrev<CR>
map <C-L> :BufferLineCycleNext<CR>
" map <C-L> <Plug>(wintabs_next)
map <C-T>h :BufferLineMovePrev<CR>
map <C-T>l :BufferLineMoveNext<CR>
map <C-T>o :BufferLineCloseOthers<CR>
" map <C-T>l <Plug>(wintabs_move_right)
" map <C-T>w <Plug>(wintabs_close)
" map <C-T>c <Plug>(wintabs_close)
" map <C-T>o <Plug>(wintabs_only)
" map <C-W>c <Plug>(wintabs_close_window)
" map <C-W>o <Plug>(wintabs_only_window)
map <C-_> gcc

nmap - <Plug>(YankyPreviousEntry)
nmap + <Plug>(YankyNextEntry)

nmap y <Plug>(YankyYank)
xmap y <Plug>(YankyYank)
nmap p <Plug>(YankyPutAfter)
xmap p <Plug>(YankyPutAfter)
nmap P <Plug>(YankyPutBefore)
xmap P <Plug>(YankyPutBefore)

if get(g:, 'full_config')
	nmap <F8> :TagbarToggle<CR>
	command! Tabc WintabsCloseVimtab
	command! Tabo WintabsOnlyVimtab
	command! Tags TagbarToggle

	map <A-c> :Pickachu<CR>
	map <A-o> :Pickachu file<CR>
	map <A-d> :Pickachu date<CR>

	nmap <Leader>= <Plug>(PrettierAsync)

	nmap <silent> <A-m> :MinimapToggle<CR>

	nmap <F4> :UndotreeToggle<CR>

lua << EOF
	require('snacks').setup({
	    bigfile = { enabled = true },
	    bufdelete = { enabled = true },
	    quickfile = { enabled = true },
	    rename = { enabled = true },
	    input = {},
	    picker = {},
	    -- explorer = { replace_netrw = true },
	    -- notifier = { enabled = true },
	    -- words = { enabled = true },
	})
	vim.keymap.set('n', '<C-p>', Snacks.picker.smart)
	vim.keymap.set('n', '<Leader><C-p>', Snacks.picker.files)
	vim.keymap.set('n', '<C-;>', Snacks.picker.buffers)
	vim.keymap.set('n', '<C-g>', Snacks.picker.git_log)
	vim.keymap.set('n', '<Leader><C-g>', Snacks.picker.git_branches)
	vim.keymap.set('n', '<Leader>sc', Snacks.picker.colorschemes)
	vim.keymap.set('n', '<Leader><C-z>', Snacks.picker.undo)
	-- vim.keymap.set('n', '<Bslash>', Snacks.explorer.open)
	-- vim.keymap.set('n', '<Leader><Bslash>', Snacks.explorer.reveal)
	vim.keymap.set('n', '<C-t>c', Snacks.bufdelete.delete)

	require('lualine').setup({
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'diff', 'diagnostics'},
			lualine_c = {{'filename', path=1}},
			lualine_x = {'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
	})
	require('scope').setup()
	require('bufferline').setup({
		options = {
			close_command = "lua Snacks.bufdelete.delete(%d)",
			right_mouse_command = "lua Snacks.bufdelete.delete(%d)",
			separator_style = 'thin',
			diagnostics = 'nvim_lsp',
			hover = {
				enabled = true,
				delay = 200,
				reveal = {'close'}
			},
			offsets = {
				{
					filetype = 'NvimTree',
					text = '',
					text_align = 'left',
					separator = true,
				}
			}
		}
	})
	require('Comment').setup()
	require('nvim-surround').setup()
	require('nvim-autopairs').setup({
		check_ts = true,
	})

	require('yanky').setup({
		preserve_cursor_position = {
			enabled = true,
		},
		system_clipboard = {
			sync_with_ring = false,
		},
		highlight = {
			on_put = false,
			on_yank = false,
			timer = 200,
		},
	})

	require('ibl').setup({
	    enabled = false,
	    exclude = { filetypes = { "help" } },
	})

	-- local action_layout = require('telescope.actions.layout')
	-- local telescope = require('telescope')
	-- local themes = require('telescope.themes')
	-- telescope.setup({
	--     defaults = {
	-- 	preview = {
	-- 	    hide_on_startup = true
	-- 	},
	-- 	mappings = {
	-- 	    n = {
	-- 		['<A-p>'] = action_layout.toggle_preview
	-- 	    },
	-- 	    i = {
	-- 		-- Close pane with Esc directly from insert mode
	-- 		-- ["<Esc>"] = actions.close,
	-- 		['<A-p>'] = action_layout.toggle_preview
	-- 	    }
	-- 	}
	--     },
	--     extensions = {
	-- 	fzf = {
	-- 	    fuzzy = true,
	-- 	    override_generic_sorter = true,
	-- 	    override_file_sorter = true,
	-- 	    case_mode = 'smart_case',
	-- 	},
	-- 	['ui-select'] = {
	-- 	    themes.get_dropdown()
	-- 	}
	--     },
	-- })
	--
	-- telescope.load_extension('fzf')
	-- telescope.load_extension('scope')
	-- telescope.load_extension('ui-select')

	require('gitsigns').setup({
	    on_attach = function (bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
		    opts = opts or {}
		    opts.buffer = bufnr
		end

		local opts = { noremap=true, silent=true }
		vim.api.nvim_buf_set_keymap(bufnr, 'n', ']c', '<cmd>Gitsigns next_hunk<CR>', opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', '[c', '<cmd>Gitsigns prev_hunk<CR>', opts)

		vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitGutterAdd' })
		vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitGutterChange' })
		vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitGutterDelete' })
		vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitGutterDelete' })
		vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitGutterChange' })
	    end
	})

	require('nvim-tree').setup({
		disable_netrw = false,
		system_open = {
			cmd = "xdg-open",
		},
		update_cwd = true,
		diagnostics = {
			enable = true,
		},
		modified = {
			enable = true,
		},
		git = {
			ignore = false
		}
	})

	vim.g.skip_ts_context_commentstring = true

	require('nvim-treesitter.configs').setup({
		ensure_installed = "all",
		ignore_install = { "phpdoc" },
		highlight = {
			enable = true, -- false will disable the whole extension

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = 'gnn',
				node_incremental = 'grn',
				scope_incremental = 'grc',
				node_decremental = 'grm',
			},
		},
		-- indent = {
			-- enable = true,
		-- },
		textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				[']m'] = '@function.outer',
				[']]'] = '@class.outer',
			},
			goto_next_end = {
				[']M'] = '@function.outer',
				[']['] = '@class.outer',
			},
			goto_previous_start = {
				['[m'] = '@function.outer',
				['[['] = '@class.outer',
			},
			goto_previous_end = {
				['[M'] = '@function.outer',
				['[]'] = '@class.outer',
			},
		},
		},
		-- nvim-ts-rainbow
		rainbow = {
			enable = false,
			extended_mode = true,
		},
	})

	require('nvim-ts-autotag').setup()

	require('ts_context_commentstring').setup()

	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
	})

	-- require('neodim').setup()

	-- Matches default nvim-tree icons
	vim.diagnostic.config({
	    signs = {
		text = {
		    [vim.diagnostic.severity.ERROR] = ' ',
		    [vim.diagnostic.severity.WARN] = ' ',
		    [vim.diagnostic.severity.HINT] = ' ',
		    [vim.diagnostic.severity.INFO] = ' ',
		},
		numhl = {
		    [vim.diagnostic.severity.WARN] = 'WarningMsg',
		},
	    },
	})


	local lspconfig = require('lspconfig')
	local lsp_signature = require('lsp_signature')
	lspconfig_on_attach = function(client, buffer)
		local opts = { noremap = true, silent = true, buffer = buffer }
		local snacks_lsp_opts = { include_current = true, focus = 'list' }
		vim.keymap.set('n', ']e', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<Leader>gd', function() Snacks.picker.lsp_definitions(snacks_lsp_opts) end, opts)
		vim.keymap.set('n', '<Leader>gy', function() Snacks.picker.lsp_type_definitions(snacks_lsp_opts) end, opts)
		vim.keymap.set('n', '<Leader>gD', function() Snacks.picker.lsp_declarations(snacks_lsp_opts) end, opts)
		vim.keymap.set('n', '<Leader>gi', function() Snacks.picker.lsp_implementations(snacks_lsp_opts) end, opts)
		vim.keymap.set('n', '<Leader>gr', function() Snacks.picker.lsp_references(snacks_lsp_opts) end, opts)
		vim.keymap.set('n', '<Leader>gs', function() Snacks.picker.lsp_symbols(snacks_lsp_opts) end, opts)
		vim.keymap.set('n', '<Leader>=', vim.lsp.buf.format, opts)
		vim.keymap.set('n', '<A-h>', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<A-a>', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<A-f>', function() vim.lsp.buf.code_action({ context = { only = {"source.fixAll"} }, apply = true }) end, opts)
		vim.keymap.set('n', '<A-r>', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<A-q>', function() vim.lsp.stop_client(vim.lsp.get_active_clients()) end, opts)

		vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
		vim.cmd [[ command! LSPInfo execute 'lua print(vim.inspect(vim.lsp.buf_get_clients()))' ]]

		vim.cmd [[ autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"}) ]]

		lsp_signature.on_attach({
		    hint_enable = false,
		    cursorhold_update = false,
		}, buffer)
	end

	lspconfig_capabilities = require('cmp_nvim_lsp').default_capabilities()

	-- npm i -g vscode-langservers-extracted svelte-language-server @tailwindcss/language-server intelephense
	-- pacman -S rust-analyzer pyright typescript-language-server
	local lsp_servers = {
		'cssls', -- https://github.com/hrsh7th/vscode-langservers-extracted
		'eslint', -- https://github.com/hrsh7th/vscode-langservers-extracted
		'html', -- https://github.com/hrsh7th/vscode-langservers-extracted
		'intelephense', -- https://intelephense.com/
		'jsonls', -- https://github.com/hrsh7th/vscode-langservers-extracted
		'svelte', -- https://github.com/sveltejs/language-tools/tree/master/packages/language-server
		'tailwindcss', -- https://github.com/tailwindlabs/tailwindcss-intellisense
		'jdtls', -- https://projects.eclipse.org/projects/eclipse.jdt.ls
		'gopls', -- https://github.com/golang/tools/tree/master/gopls

		--  configured automatically with rust-rools
		-- 'rust_analyzer', -- https://github.com/rust-analyzer/rust-analyzer

		-- more configured manually below
	}

	for _, lsp in ipairs(lsp_servers) do
		lspconfig[lsp].setup({
			on_attach = lspconfig_on_attach,
			capabilities = lspconfig_capabilities,
		})
	end

	-- https://github.com/denoland/deno
	lspconfig.denols.setup({
		on_attach = lspconfig_on_attach,
		capabilities = lspconfig_capabilities,
		root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		settings = {
			deno = {
				enable = true,
				lint = true,
				unstable = true,
			}
		}
	})


	-- https://github.com/typescript-language-server/typescript-language-server
	lspconfig.ts_ls.setup({
		on_attach = lspconfig_on_attach,
		capabilities = lspconfig_capabilities,
		root_dir = function (filename, bufnr)
			local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename)
			if denoRootDir then return nil end

			return lspconfig.util.root_pattern("package.json")(filename)
		end,
		single_file_support = false,
	})

	-- https://github.com/microsoft/pyright
	lspconfig.pyright.setup({
		on_attach = function(client, buffer)
			lspconfig_on_attach(client, buffer)
			local opts = { noremap=true, silent=true, buffer=buffer }
			-- disable rename in favor of pyright
			vim.keymap.set(
				'n',
				'<A-r>',
				function() vim.lsp.buf.rename(nil, { name = "pyright" }) end,
				opts
			)
		end,
		capabilities = lspconfig_capabilities
	})

	-- https://github.com/python-lsp/python-lsp-server
	lspconfig.pylsp.setup({
		on_attach = function(client, buffer)
		lspconfig_on_attach(client, buffer)
			local opts = { noremap=true, silent=true, buffer=buffer }
			-- disable rename in favor of pyright
			vim.keymap.set(
				'n',
				'<A-r>',
				function() vim.lsp.buf.rename(nil, { name = "pyright" }) end,
				opts
			)
		end,
		capabilities = lspconfig_capabilities,
		settings = {
			pylsp = {
				plugins = {
					-- https://github.com/python-lsp/python-lsp-ruff
					ruff = {
						enabled = true,
					},
					jedi_completion = {
						enabled = false
					},
					jedi_definition = {
						enabled = false
					},
					jedi_hover = {
						enabled = false
					},
					jedi_references = {
						enabled = false
					},
					jedi_signature_help = {
						enabled = false
					},
					jedi_symbols = {
						enabled = false
					},
					mccabe = {
						enabled = false
					},
					preload = {
						enabled = false
					},
					yapf = {
						enabled = false
					},
					pylint = {
						-- disabled by default
						enabled = false,
						-- Use pylint binary, slower but basically required
						executable = "pylint",
					},
				}
			}
		}
	})

	-- rust-tools

	local rt = require 'rust-tools'
	rt.setup({
		server  = {
			on_attach = lspconfig_on_attach,
			capabilities = lspconfig_capabilities,
			standalone = true,
		},
		tools = {
			inlay_hints = { auto = false }
		}
	})

	-- luasnip
	local luasnip = require 'luasnip'

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	-- nvim-cmp
	local cmp = require 'cmp'
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		preselect = cmp.PreselectMode.None,
		mapping = cmp.mapping.preset.insert({
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.close(),
			['<CR>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			['<Tab>'] = function(fallback)
				if cmp.visible() then
				cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
				elseif has_words_before() then
				cmp.complete()
				else
				fallback()
				end
			end,
			['<S-Tab>'] = function(fallback)
				if cmp.visible() then
				cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
				else
				fallback()
				end
			end,
		}),
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		},
	})

	vim.keymap.set({ "n", "x" }, "<Leader>sr", function() require('ssr').open() end)
EOF


	" tab-complete
	inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

	" nvim-tree.lua
	" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
	let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
	let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
	let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
	let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
	" let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
	let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
	" let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
	" let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
	" let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
	let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
	let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
	nnoremap \ :NvimTreeToggle<CR>
	nnoremap <leader>\ :NvimTreeFindFile<CR>
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and syntax
" in GUI or color console, enable coloring and search highlighting
if &t_Co > 2 || has("gui_running")
  syntax enable
  set background=dark
  set hlsearch
endif

set t_Co=256  " force 256 colors

function! SourceIfExists(path)
	if filereadable(expand(a:path))
		execute 'source' expand(a:path)
	endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmd
if has("autocmd")
	" Filetypes and indenting settings
	filetype plugin indent on

	autocmd CursorHold * checktime

	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text,markdown setlocal textwidth=78
	autocmd FileType text,markdown,tex,gitcommit setlocal spell spelllang=en_us


	autocmd BufNewFile,BufRead *.cool set filetype=scala
	autocmd BufNewFile,BufRead *.md set filetype=markdown.pandoc
	autocmd BufNewFile,BufRead *.markdown set filetype=markdown.pandoc
	autocmd BufRead,BufNewFile *.thy setfiletype isabelle
	autocmd BufRead,BufNewFile *.thy set conceallevel=2

	" Manually sync syntax in Vue files
	" https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
	autocmd FileType vue syntax sync fromstart

	autocmd FileType coq call coquille#FNMapping()

	autocmd BufWritePre *.py execute ':Black'

	autocmd DirChanged * call SourceIfExists(expand("%:h") .. "/.vimrc.local")
	autocmd DirChanged * call SourceIfExists(expand("%:h") .. "/.vim/.vimrc")
	autocmd DirChanged * call SourceIfExists(expand("%:h") .. "/.vim/init.vim")
	autocmd DirChanged * call SourceIfExists(expand("%:h") .. "/.vim/init.lua")

endif " has("autocmd")

let g:onedark_terminal_italics=1

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'

let g:enable_bold_font = 1
let g:enable_italic_font = 1

" Helpers to change between light and dark themes
function! DarkTheme()
	colorscheme base16-rose-pine-moon
	set background=dark
	call OverrideHighlights()
endfunction

function! LightTheme()
	colorscheme adwaita
	set background=light
	call OverrideHighlights()
endfunction

function! OverrideHighlights()
	" trailing whitespace and column; must define AFTER colorscheme, setf, etc!
	hi ColorColumn ctermbg=black guibg=darkgray
	hi WhitespaceEOL ctermbg=red guibg=red
	match WhitespaceEOL /\s\+\%#\@<!$/

	" Fix Conceal (not sure why this is needed honestly)
	hi Conceal guibg=bg

	hi DiagnosticError ctermfg=9 guifg=#ff0000
	hi DiagnosticWarn ctermfg=130 guifg=#ff922b
	hi DiagnosticInfo ctermfg=11 guifg=#fab005
	hi DiagnosticHint ctermfg=12 guifg=#15aabf

	hi DiagnosticUnderlineError cterm=undercurl gui=undercurl ctermbg=9 guisp=#ff0000
	hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurl ctermbg=130 guisp=#ff922b
	hi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl ctermbg=11 guisp=#fab005
	hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl ctermbg=12 guisp=#15aabf

	" Add line highlight
	hi LineHighlight ctermbg=darkgray guibg=darkgray

	" Add search special color
	hi Search guisp=Magenta
endfunction

" Default to dark theme
call DarkTheme()

lua require('colorizer').setup()

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last but not least, allow for local overrides
call SourceIfExists("~/.vimrc.local")
call SourceIfExists(expand("%:h") .. "/.vimrc.local")
call SourceIfExists(expand("%:h") .. "/.vim/.vimrc")
call SourceIfExists(expand("%:h") .. "/.vim/init.vim")
call SourceIfExists(expand("%:h") .. "/.vim/init.lua")
