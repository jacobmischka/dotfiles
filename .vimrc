" Current config assumes nvim and vim-plug

" Disable this to disable heavier config options for lightweight environments
let g:full_config = 1

" vim mode preferred!
set nocompatible

" set xterm title, and inform vim of screen/tmux's syntax for doing the same
set titlestring=vim\ %{expand(\"%t\")}
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
set foldmethod=indent           " auto-fold based on indentation.  (py-friendly)
set foldlevel=99
set timeoutlen=1000             " wait 1s for mappings to finish
set ttimeoutlen=0             " wait 0.1s for xterm keycodes to finish
set nrformats-=octal            " don't try to auto-increment 'octal'
set grepprg=rg\ --vimgrep

set splitright
set splitbelow
set diffopt+=vertical
set hidden
set wildmode=longest,list,full
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings

" Stuff that clobbers default bindings
" Force ^U and ^W in insert mode to start a new undo group
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Leader
let mapleader = ","
let g:mapleader = ","

" Swaps selection with buffer
vnoremap <C-X> <Esc>`.``gvP``P

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'

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

" Stamping (replace word with yanked text)
nnoremap <leader>S "_diwP
vnoremap <leader>S "_d"0P

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

nnoremap <CR> i<CR><Esc>

nmap <silent> ]g :cn<CR>
nmap <silent> [g :cp<CR>

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
nnoremap <Up>    :resize +1<CR>
nnoremap <Down>  :resize -1<CR>
nnoremap <Left>  :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>


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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
call plug#begin('~/.vim/plugged')

" Essentials
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'zefei/vim-wintabs'
Plug 'jiangmiao/auto-pairs'
Plug 'tyru/caw.vim'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'chaoren/vim-wordmotion'
Plug 'tmilloff/vim-address-bar'

" File types and syntaxes
Plug 'jxnblk/vim-mdx-js'
Plug 'rust-lang/rust.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'reasonml-editor/vim-reason-plus'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'danilo-augusto/vim-afterglow'
Plug 'joshdick/onedark.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'chriskempson/base16-vim'
Plug 'jacoborus/tender.vim'
Plug 'dracula/vim'
Plug 'nightsense/carbonized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'liuchengxu/space-vim-dark'
Plug 'cormacrelf/vim-colors-github'

" Heavier
if get(g:, 'full_config')
	Plug 'alvan/vim-closetag'
	Plug 'Shougo/context_filetype.vim'
	Plug 'kana/vim-repeat'
	Plug 'nathanaelkane/vim-indent-guides'
	Plug 'kshenoy/vim-signature'
	Plug 'Valloric/MatchTagAlways'
	Plug 'justinmk/vim-gtfo'
	Plug 'arthurxavierx/vim-caser'
	Plug 'KabbAmine/vCoolor.vim'

	Plug 'w0rp/ale'
	Plug '/usr/share/vim/vimfiles/plugin/fzf.vim'
	Plug 'junegunn/fzf.vim'
	Plug 'scrooloose/nerdtree'
	Plug 'mcchrish/nnn.vim'
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'airblade/vim-gitgutter'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'severin-lemaignan/vim-minimap'
	Plug 'tpope/vim-sensible'
	Plug 'ap/vim-css-color'
	Plug 'Quramy/vim-js-pretty-template'
	Plug 'godlygeek/tabular'
	Plug 'wesQ3/vim-windowswap'
	Plug 'moll/vim-node'
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
	Plug 'majutsushi/tagbar'
	Plug 'vim-php/tagbar-phpctags.vim', {'do': 'make'}
	Plug 'shime/vim-livedown', {'do': 'npm i -g livedown'}
	Plug 'ryanoasis/vim-devicons'

	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'autozimu/LanguageClient-neovim'
	Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}

	" Formatters
	Plug 'prettier/vim-prettier', {
	\ 'do': 'yarn install',
	\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'html', 'yaml'] }

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

let g:wordmotion_prefix = '<Leader>'

let g:NERDTreeShowHidden = 1
let g:NERDTreeShowIgnoredStatus = 1
let g:NERDSpaceDelims = 1
let g:NERDTreeMinimalUI = 1

let g:jsx_ext_required = 0

let g:rustfmt_autosave = 1

let g:AutoPairsCenterLine = 0

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
	let g:LanguageClient_serverCommands = {
	\	'rust': ['rls', '+stable'],
	\	'javascript': ['/home/mischka/.npm-global/bin/flow-language-server', '--stdio'],
	\	'vue': ['/home/mischka/.npm-global/bin/vls'],
	\	'python': ['/home/mischka/.local/bin/pyre', 'persistent'],
	\	'dart': ['/home/mischka/.pub-cache/bin/dart_language_server'],
	\	'reason': ['/home/mischka/.local/bin/reason-language-server.exe']
	\}

	let g:LanguageClient_autoStart = 1
	let g:LanguageClient_diagnosticsEnable = 0

	let g:deoplete#enable_smart_case = 1
	let g:deoplete#sources = {}
	let g:deoplete#sources.rust = ['LanguageClient']
	let g:deoplete#sources.javascript = ['LanguageClient']
	let g:deoplete#sources.svelte = ['LanguageClient']
	let g:deoplete#sources.css = ['LanguageClient']
	let g:deoplete#sources.vue = ['LanguageClient']
	let g:deoplete#sources.python = ['LanguageClient']
	let g:deoplete#sources.php = ['LanguageClient']
	let g:deoplete#sources.dart = ['LanguageClient']
	call deoplete#custom#option('auto_complete_delay', 100)

	command! DeopleteDisableBuffer call deoplete#custom#buffer_option('auto_complete', v:false)
	command! DeopleteEnableBuffer call deoplete#custom#buffer_option('auto_complete', v:true)

	" deoplete tab-complete
	inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

	let g:javascript_plugin_flow = 1

	let g:EclimFileTypeValidate = 0
	let g:EclimCValidate = 0
	let g:EclimHtmlValidate = 0
	let g:EclimJavaValidate = 0
	let g:EclimJavascriptValidate = 0
	let g:EclimPhpValidate = 0
	let g:EclimPythonValidate = 0

	let g:ale_linters = {
	\	'javascript': ['eslint', 'flow-language-server'],
	\	'html': ['eslint'],
	\	'python': ['pyre', 'pylint'],
	\	'rust': ['rls'],
	\	'markdown': ['alex', 'proselint', 'writegood']
	\}

	let g:ale_pattern_options = {
	\	'\.min.js$': {'ale_enabled': 0},
	\	'\.html$': {'ale_linters': ['eslint']},
	\	'node_modules': {'ale_enabled': 0},
	\	'build': {'ale_enabled': 0}
	\}
	let g:ale_sign_error = '✖'
	let g:ale_sign_warning = '⚠'
	let g:ale_lint_delay = 100

	let g:ale_rust_rustc_options = '-o /tmp/rust_out'
	let g:ale_rust_rls_toolchain = 'stable'

	let g:mta_filetypes = {
	\	'html': 1,
	\	'xhtml': 1,
	\	'xml': 1,
	\	'svelte': 1,
	\	'jsx': 1,
	\	'javascript.jsx': 1,
	\	'vue': 1
	\}

	let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.svelte,*.js,*.jsx,*.vue,*.blade.php'
	let g:closetag_filetypes = 'xml,html,xhtml,svelte,jsx,javascript.jsx,vue,blade'

	let g:vcoolor_lowercase = 1

	call jspretmpl#register_tag('css', 'css')
	" call jspretmpl#register_tag('gql', 'graphql')
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


if get(g:, 'full_config')
	map \ :NERDTreeToggle<CR>
	map \| :NERDTreeFind<CR>
	nmap <F8> :TagbarToggle<CR>
	command! Tabc WintabsCloseVimtab
	command! Tabo WintabsOnlyVimtab
	command! Tags TagbarToggle

	nmap <silent> ]e <Plug>(ale_next)
	nmap <silent> [e <Plug>(ale_previous)

	nmap <Leader>= <Plug>(PrettierAsync)

	" nmap <C-M> :LivedownToggle<CR>
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
	autocmd FileType text,markdown setlocal spell spelllang=en_us


	" I'd like to do html.svelte.javascript.css, but for some reason the deoplete
	" provider for css is breaking quoted attribute entry, making it jump to 1:1
	autocmd BufNewFile,BufRead *.html set filetype=html.svelte.javascript
	autocmd BufNewFile,BufRead *.cool set filetype=scala

	" Manually sync syntax in Vue files
	" https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
	autocmd FileType vue syntax sync fromstart

	" autocmd FileType javascript,javascript.jsx JsPreTmpl html

	" Enable deoplete in insert mode
	if get(g:, 'full_config')
		autocmd InsertEnter * call deoplete#enable()
	endif

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
	colorscheme base16-dracula
	set background=dark
	if exists(":AirlineTheme")
		AirlineTheme dark
	endif
endfunction

function! LightTheme()
	colorscheme PaperColor
	set background=light
endfunction

" Default to dark theme
call DarkTheme()

" trailing whitespace and column; must define AFTER colorscheme, setf, etc!
hi ColorColumn ctermbg=black guibg=darkgray
hi WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+\%#\@<!$/

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last but not least, allow for local overrides
call SourceIfExists("~/.vimrc.local")

