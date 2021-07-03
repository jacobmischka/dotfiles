" Current config assumes nvim and vim-plug

" Disable this to disable heavier config options for lightweight environments
let g:full_config = 1

" Use built-in nvim lsp instead of coc.nvim
let g:use_nvim_lsp = 0

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
set listchars=tab:↹·,extends:⇉,precedes:⇇,nbsp:␠,trail:␠,nbsp:␣
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
let mapleader = ','
let g:mapleader = ','
let maplocalleader = ',,'
let g:maplocalleader = ',,'

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

nmap <silent> ]g :cn<CR>
nmap <silent> [g :cp<CR>

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
Plug 'tpope/vim-sleuth'
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
		Plug 'hrsh7th/nvim-compe'
		Plug 'kyazdani42/nvim-web-devicons'
		Plug 'kyazdani42/nvim-tree.lua'
		Plug 'ray-x/lsp_signature.nvim'
	else
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
	endif

	Plug 'alvan/vim-closetag'
	Plug 'kana/vim-repeat'
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'kshenoy/vim-signature'
	Plug 'Valloric/MatchTagAlways'
	Plug 'justinmk/vim-gtfo'
	Plug 'arthurxavierx/vim-caser'
	Plug 'DougBeney/pickachu'
	Plug 'gcmt/taboo.vim'
	Plug 'xolox/vim-misc'
	Plug 'xolox/vim-session'
	Plug 'luochen1990/rainbow'

	Plug '/usr/share/vim/vimfiles/plugin/fzf.vim'
	Plug 'junegunn/fzf.vim'
	Plug 'mcchrish/nnn.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'severin-lemaignan/vim-minimap', {'do': ':!cargo install --locked code-minimap'}
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-abolish'
	Plug 'ap/vim-css-color'
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
	Plug 'prettier/vim-prettier', {
		\ 'do': 'yarn install',
		\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'html', 'yaml', 'svelte']
	\ }
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

" let g:NERDTreeShowHidden = 1
" let g:NERDTreeShowIgnoredStatus = 1
" let g:NERDSpaceDelims = 1
" let g:NERDTreeMinimalUI = 1

" let g:webdevicons_conceal_nerdtree_brackets = 1
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

" Customize fzf colors to match your color scheme
let $FZF_DEFAULT_COMMAND = 'rg --files --follow'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
\ }


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

	" Language Server providers
	" Note: PHP provider installed via helper plugin above
	"
	" rust: https://github.com/rust-lang-nursery/rls
	" php: https://github.com/felixfbecker/php-language-server
	" javascript/ts: https://github.com/sourcegraph/javascript-typescript-langserver
	" javascript/flow: https://github.com/flowtype/flow-language-server
	" svelte: https://github.com/UnwrittenFun/svelte-language-server
	" css: https://github.com/vscode-langservers/vscode-css-languageserver-bin
	" vue: https://github.com/vuejs/vetur/tree/master/server
	" pyre: https://github.com/facebook/pyre-check
	" dart: https://github.com/natebosch/dart_language_server
	" reason: https://github.com/jaredly/reason-language-server

	" Alternatives / others:
	" 'javascript.typescript': ['javascript-typescript-stdio'],
	" 'css': ['/home/mischka/.npm-global/bin/css-languageserver', '--stdio']

	let g:EclimFileTypeValidate = 0
	let g:EclimCValidate = 0
	let g:EclimHtmlValidate = 0
	let g:EclimJavaValidate = 0
	let g:EclimJavascriptValidate = 0
	let g:EclimPhpValidate = 0
	let g:EclimPythonValidate = 0

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

	let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.njk,*.svelte,*.js,*.jsx,*.vue,*.blade.php'
	let g:closetag_filetypes = 'xml,html,xhtml,htmldjango,svelte,jsx,javascript.jsx,vue,blade'

	let g:pickachu_default_date_format = "%Y-%m-%d"

	let g:yoinkIncludeDeleteOperations = 1

	let g:nremap = {'[e': '', ']e': ''}

	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	let g:airline_symbols.maxlinenr = ''

	call jspretmpl#register_tag('css', 'css')
	" call jspretmpl#register_tag('gql', 'graphql')

	let g:rainbow_active = 1

	let g:prettier#autoformat_config_present = 1
	let g:prettier#autoformat_require_pragma = 0
	let g:prettier#autoformat_config_files = [".prettierrc.json"]

	let g:svelte_preprocessors = ['typescript']
endif

" Keymaps
map <C-P> :FZF<CR>
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
	" map \ :NERDTreeToggle<CR>
	" map \| :NERDTreeFind<CR>
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

	" nmap <C-M> :LivedownToggle<CR>


	if get(g:, 'use_nvim_lsp')
lua << EOF
		local on_attach = function(client, bufnr)
			local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
			local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
			local opts = { noremap=true, silent=true }

			require'lsp_signature'.on_attach()
		end

		local nvim_lsp = require('lspconfig')

		local lsp_servers = {
			'html',
			'intelephense',
			'pyls',
			'rust_analyzer',
			'svelte',
		}

		for _, lsp in ipairs(lsp_servers) do
			nvim_lsp[lsp].setup{
				on_attach = on_attach,
				flags = {
					debounce_text_changes = 150,
				}
			}
		end

		require'compe'.setup {
			enabled = true;
			autocomplete = true;
			debug = false;
			min_length = 1;
			preselect = 'disable';
			throttle_time = 80;
			source_timeout = 200;
			resolve_timeout = 800;
			incomplete_delay = 400;
			max_abbr_width = 100;
			max_kind_width = 100;
			max_menu_width = 100;
			documentation = {
				border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
				winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
				max_width = 120,
				min_width = 60,
				max_height = math.floor(vim.o.lines * 0.3),
				min_height = 1,
			};

			source = {
				path = true;
				buffer = true;
				calc = true;
				nvim_lsp = true;
				nvim_lua = true;
				vsnip = true;
				ultisnips = true;
				luasnip = true;
			};
		}
EOF

		" tab-complete
		inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
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
		nmap <silent> <A-x> :CocCommand rust-analyzer.explainError<CR>

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
	autocmd FileType text,markdown,tex setlocal spell spelllang=en_us


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

	" autocmd FileType javascript,javascript.jsx JsPreTmpl html

	autocmd DirChanged * call SourceIfExists("./.vimrc.local")
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
	colorscheme patriot
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

	" Have coc use undercurls
	hi CocErrorHighlight cterm=undercurl gui=undercurl ctermbg=9 guisp=#ff0000
	hi CocWarningHighlight cterm=undercurl gui=undercurl ctermbg=130 guisp=#ff922b
	hi CocInfoHighlight cterm=undercurl gui=undercurl ctermbg=11 guisp=#fab005
	hi CocHintHighlight cterm=undercurl gui=undercurl ctermbg=12 guisp=#15aabf

	" Add line highlight
	hi LineHighlight ctermbg=darkgray guibg=darkgray
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

