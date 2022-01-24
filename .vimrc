" Current config assumes nvim and vim-plug

" Disable this to disable heavier config options for lightweight environments
let g:full_config = 1

" Use built-in nvim lsp instead of coc.nvim
let g:use_nvim_lsp = 1

" vim mode preferred!
set nocompatible

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
set softtabstop=0               " Disable sts
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
set guifont=Fira\ Code\ Regular:h9
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

nnoremap - ,
nnoremap + ;

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
:nnoremap <F5> "=strftime("%Y-%m-%d")<CR>p
:nnoremap <leader><F5> "=strftime("%Y-%m-%d")<CR>P
:inoremap <F5> <C-R>=strftime("%Y-%m-%d")<CR>

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

nnoremap <CR> i<CR><Esc>

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
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'zefei/vim-wintabs'
Plug 'jiangmiao/auto-pairs'
Plug 'tyru/caw.vim'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'jacobmischka/vim-sleuth'
Plug 'chaoren/vim-wordmotion'
Plug 'tmilloff/vim-address-bar'
Plug 'svermeulen/vim-subversive'
Plug 'svermeulen/vim-yoink'
Plug 'mhinz/vim-sayonara'

" File types and syntaxes
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rust-lang/rust.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'lervag/vimtex'
Plug 'https://bitbucket.org/ccorrodi/sasylfvim.git'
Plug 'lepture/vim-jinja'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'danilo-augusto/vim-afterglow'
Plug 'joshdick/onedark.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'chriskempson/base16-vim'
Plug 'jacoborus/tender.vim'
Plug 'nightsense/carbonized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'liuchengxu/space-vim-dark'
Plug 'cormacrelf/vim-colors-github'
Plug 'KKPMW/oldbook-vim'
Plug 'haishanh/night-owl.vim'
Plug 'rainglow/vim'
Plug 'jaredgorski/SpaceCamp'

" Heavier
if get(g:, 'full_config')
	if get(g:, 'use_nvim_lsp')
		Plug 'neovim/nvim-lspconfig'
		Plug 'hrsh7th/nvim-cmp'
		Plug 'hrsh7th/cmp-nvim-lsp'
		Plug 'kyazdani42/nvim-web-devicons'
		Plug 'kyazdani42/nvim-tree.lua'
		Plug 'ray-x/lsp_signature.nvim'
		Plug 'lewis6991/gitsigns.nvim'
		Plug 'saadparwaiz1/cmp_luasnip'
		Plug 'L3MON4D3/LuaSnip'
		Plug 'folke/lsp-colors.nvim'
	else
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
	endif

	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'p00f/nvim-ts-rainbow'
	Plug 'JoosepAlviste/nvim-ts-context-commentstring'

	Plug 'alvan/vim-closetag'
	Plug 'kana/vim-repeat'
	Plug 'kshenoy/vim-signature'
	Plug 'Valloric/MatchTagAlways'
	Plug 'justinmk/vim-gtfo'
	Plug 'arthurxavierx/vim-caser'
	Plug 'DougBeney/pickachu'
	Plug 'gcmt/taboo.vim'
	Plug 'xolox/vim-misc'
	Plug 'xolox/vim-session'
	Plug 'luochen1990/rainbow'
	Plug 'lukas-reineke/indent-blankline.nvim'

	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }
	Plug 'mcchrish/nnn.vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'severin-lemaignan/vim-minimap', {'do': ':!cargo install --locked code-minimap'}
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-abolish'
	Plug 'ap/vim-css-color'
	Plug 'amadeus/vim-convert-color-to'
	Plug 'Quramy/vim-js-pretty-template'
	Plug 'godlygeek/tabular'
	Plug 'wesQ3/vim-windowswap'
	Plug 'moll/vim-node'
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
	Plug 'majutsushi/tagbar'
	Plug 'vim-php/tagbar-phpctags.vim', {'do': 'make'}
	Plug 'ryanoasis/vim-devicons'

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

	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	let g:airline_symbols.colnr = ' :'
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ' :'
	let g:airline_symbols.maxlinenr = ''

	call jspretmpl#register_tag('css', 'css')
	" call jspretmpl#register_tag('gql', 'graphql')

	let g:rainbow_active = 1

	let g:prettier#autoformat_config_present = 1
	let g:prettier#autoformat_require_pragma = 0
	let g:prettier#autoformat_config_files = [".prettierrc.json", ".prettierrc"]

	let g:svelte_preprocessors = ['typescript']
endif

" Keymaps
map <C-P> :Telescope git_files<CR>
map <Leader><C-P> :Telescope find_files<CR>
map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
map <C-T>h <Plug>(wintabs_move_left)
map <C-T>l <Plug>(wintabs_move_right)
map <C-T>w <Plug>(wintabs_close)
map <C-T>c <Plug>(wintabs_close)
map <C-T>o <Plug>(wintabs_only)
map <C-W>c <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
map <C-_> gcc

nmap s <Plug>(SubversiveSubstitute)
nmap ss <Plug>(SubversiveSubstituteLine)
nmap S <Plug>(SubversiveSubstituteToEndOfLine)

nmap <leader>s <Plug>(SubversiveSubstituteRange)
xmap <leader>s <Plug>(SubversiveSubstituteRange)
nmap <leader>ss <Plug>(SubversiveSubstituteWordRange)

xmap p <Plug>(SubversiveSubstitute)
xmap P <Plug>(SubversiveSubstitute)

nmap <C-[> <Plug>(YoinkPostPasteSwapBack)
nmap <C-]> <Plug>(YoinkPostPasteSwapForward)

nmap p <Plug>(YoinkPaste_p)
nmap P <Plug>(YoinkPaste_P)

nmap [y <Plug>(YoinkRotateBack)
nmap ]y <Plug>(YoinkRotateForward)

nmap <localleader>y <Plug>(YoinkYankPreserveCursorPosition)
xmap <localleader>y <Plug>(YoinkYankPreserveCursorPosition)

if get(g:, 'full_config')
	nmap <F8> :TagbarToggle<CR>
	command! Tabc WintabsCloseVimtab
	command! Tabo WintabsOnlyVimtab
	command! Tags TagbarToggle

	map <A-c> :Pickachu<CR>
	map <A-f> :Pickachu file<CR>
	map <A-d> :Pickachu date<CR>

	nmap <Leader>= <Plug>(PrettierAsync)

	nmap <silent> <A-m> :MinimapToggle<CR>

	" exclude overwrite statusline of list filetype
	let g:airline_exclude_filetypes = ["list"]

lua << EOF
	require("indent_blankline").setup {
		enabled = false,
		show_end_of_line = false,
		show_first_indent_level = true,
		space_char_blankline = " ",
		space_char = " ",
		filetype_exclude = {"help", "coc-explorer"}
	}

	local action_layout = require('telescope.actions.layout')
	require('telescope').setup {
		defaults = {
			preview = {
				hide_on_startup = true
			},
			mappings = {
				n = {
					['<A-p>'] = action_layout.toggle_preview
				},
				i = {
					-- Close pane with Esc directly from insert mode
					-- ["<Esc>"] = actions.close,
					['<A-p>'] = action_layout.toggle_preview
				}
			}
		}
	}

	require('telescope').load_extension('fzf')
EOF

	if get(g:, 'use_nvim_lsp')
lua << EOF
		require('gitsigns').setup {
		  signs = {
			add = { hl = 'GitGutterAdd', text = '+' },
			change = { hl = 'GitGutterChange', text = '~' },
			delete = { hl = 'GitGutterDelete', text = '_' },
			topdelete = { hl = 'GitGutterDelete', text = '‾' },
			changedelete = { hl = 'GitGutterChange', text = '~' },
		  },
		}

		require('nvim-tree').setup {
		  disable_netrw = false,
		  system_open = {
			cmd = "xdg-open",
		  },
		  update_cwd = true,
		  diagnostics = {
			enable = true,
			icons = {
			  hint = "",
			  info = "",
			  warning = "",
			  error = "",
			}
		  },
		  git = {
			ignore = false,
		  }
		}

		require('nvim-treesitter.configs').setup {
		  ensure_installed = "maintained",
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
			enable = true,
			extended_mode = true,
		  },
		  -- context-commentstring
		  context_commentstring = {
			enable = true
		  },
		}

		vim.diagnostic.config({
		  virtual_text = false,
		  severity_sort = true,
		})

		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end


		local lspconfig = require('lspconfig')
		local on_attach = function(client, bufnr)
			local opts = { noremap=true, silent=true }
			vim.api.nvim_buf_set_keymap(bufnr, 'n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-h>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-a>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-r>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
			vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
			vim.cmd [[ command! LSPInfo execute 'lua print(vim.inspect(vim.lsp.buf_get_clients()))' ]]

			require'lsp_signature'.on_attach()
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

		-- npm i -g vscode-langservers-extracted svelte-language-server @tailwindcss/language-server intelephense
		-- pacman -S rust-analyzer pyright typescript-language-server
		local lsp_servers = {
			'cssls', -- https://github.com/hrsh7th/vscode-langservers-extracted
			'eslint', -- https://github.com/hrsh7th/vscode-langservers-extracted
			'html', -- https://github.com/hrsh7th/vscode-langservers-extracted
			'intelephense', -- https://intelephense.com/
			'jsonls', -- https://github.com/hrsh7th/vscode-langservers-extracted
			'pyright', -- https://github.com/microsoft/pyright
			'rust_analyzer', -- https://github.com/rust-analyzer/rust-analyzer
			'svelte', -- https://github.com/sveltejs/language-tools/tree/master/packages/language-server
			'tailwindcss', -- https://github.com/tailwindlabs/tailwindcss-intellisense
			'tsserver', -- https://github.com/typescript-language-server/typescript-language-server
		}

		for _, lsp in ipairs(lsp_servers) do
			lspconfig[lsp].setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
		end

		local luasnip = require 'luasnip'

		-- nvim-cmp
		local cmp = require 'cmp'
		cmp.setup {
		  snippet = {
			expand = function(args)
			  luasnip.lsp_expand(args.body)
			end,
		  },
		  mapping = {
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
		  },
		  sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
		  },
		}
EOF

		autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
		nnoremap <A-q> :lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

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
	else

		nmap \ :CocCommand explorer<CR>
		nmap <silent> ]e <Plug>(coc-diagnostic-next)
		nmap <silent> [e <Plug>(coc-diagnostic-prev)
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> gr <Plug>(coc-references)
		nmap <silent> <A-r> <Plug>(coc-rename)
		nmap <silent> <A-i> <Plug>(coc-diagnostic-info)
		nmap <silent> <A-h> :<C-U>call CocAction('doHover')<CR>
		nmap <silent> <A-a> :CocAction<CR>
		nmap <silent> <A-l> :IndentBlanklineToggle<CR>
		nmap <silent> [g <Plug>(coc-git-prevchunk)
		nmap <silent> ]g <Plug>(coc-git-nextchunk)
		nmap <silent> [c <Plug>(coc-git-prevconflict)
		nmap <silent> ]c <Plug>(coc-git-nextconflict)
		nmap <silent> gs <Plug>(coc-git-chunkinfo)
		nmap <silent> gc <Plug>(coc-git-commit)
		omap <silent> ig <Plug>(coc-git-chunk-inner)
		xmap <silent> ig <Plug>(coc-git-chunk-inner)
		omap <silent> ag <Plug>(coc-git-chunk-outer)
		xmap <silent> ag <Plug>(coc-git-chunk-outer)

		autocmd FileType rust nmap <silent> <A-x> :CocCommand rust-analyzer.explainError<CR>
		autocmd FileType rust nmap <A-q> :CocCommand rust-analyzer.reload<CR>

		autocmd FileType svelte nmap <A-q> :CocCommand svelte.restartLanguageServer<CR>
		autocmd FileType python nmap <A-q> :CocCommand pyright.restartserver<CR>
		autocmd FileType typescript nmap <A-q> :CocCommand tsserver.restart<CR>

		" create a part for server status.
		function! GetServerStatus()
			return get(g:, 'coc_status', '')
		endfunction
		call airline#parts#define_function('coc', 'GetServerStatus')

		function! AirlineInit()
			let g:airline_section_a = airline#section#create(['coc'])

			" use error & warning count of diagnostics form coc.nvim
			let g:airline_section_error .= '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
			let g:airline_section_warning .= '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
		endfunction
		autocmd User AirlineAfterInit call AirlineInit()

		inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
	endif
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

	" I don't understand why this isn't happening automatically
	autocmd BufEnter * :Sleuth

	autocmd DirChanged * call SourceIfExists("./.vimrc.local")
	autocmd DirChanged * call SourceIfExists("./.vim/.vimrc")
	autocmd DirChanged * call SourceIfExists("./.vim/init.vim")
	autocmd DirChanged * call SourceIfExists("./.vim/init.lua")

endif " has("autocmd")

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
	set termguicolors
endif

let g:onedark_terminal_italics=1

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'

let g:enable_bold_font = 1
let g:enable_italic_font = 1

" Helpers to change between light and dark themes
function! DarkTheme()
	colorscheme downpour
	set background=dark
	let g:airline_theme='base16'
	if exists(":AirlineTheme")
		AirlineTheme base16
	endif
	call OverrideHighlights()
endfunction

function! LightTheme()
	colorscheme PaperColor
	set background=light
	let g:airline_theme='papercolor'
	if exists(":AirlineTheme")
		AirlineTheme papercolor
	endif
	call OverrideHighlights()
endfunction

function! OverrideHighlights()
	" trailing whitespace and column; must define AFTER colorscheme, setf, etc!
	hi ColorColumn ctermbg=black guibg=darkgray
	hi WhitespaceEOL ctermbg=red guibg=red
	match WhitespaceEOL /\s\+\%#\@<!$/

	" Fix Conceal (not sure why this is needed honestly)
	hi Conceal guibg=bg

	" Have coc/lsp use undercurls
	hi CocErrorHighlight cterm=undercurl gui=undercurl ctermbg=9 guisp=#ff0000
	hi CocWarningHighlight cterm=undercurl gui=undercurl ctermbg=130 guisp=#ff922b
	hi CocInfoHighlight cterm=undercurl gui=undercurl ctermbg=11 guisp=#fab005
	hi CocHintHighlight cterm=undercurl gui=undercurl ctermbg=12 guisp=#15aabf

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

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last but not least, allow for local overrides
call SourceIfExists("~/.vimrc.local")
call SourceIfExists("./.vimrc.local")
call SourceIfExists("./.vim/.vimrc")
call SourceIfExists("./.vim/init.vim")
call SourceIfExists("./.vim/init.lua")
