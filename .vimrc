" Current config assumes nvim and vim-plug

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
set matchtime=2                 " ms to show the matching paren for showmatch
set number                      " line numbers
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
set softtabstop=4               " one tab = four spaces (tab key)
"set expandtab                   " never use hard tabs
set shiftround                  " only indent to multiples of shiftwidth
set smarttab                    " DTRT when shiftwidth/softtabstop diverge
set fileformats=unix,dos        " unix linebreaks in new files please
set listchars=tab:↹·,extends:⇉,precedes:⇇,nbsp:␠,trail:␠,nbsp:␣
                                " appearance of invisible characters

set formatoptions=crqlj         " wrap comments, never autowrap long lines
" Normally I would say tabstop is always 8, because tabs are 8, by definition.
" However, I have vim-sleuth installed, which forces tabstop to 8 when files
" are NOT indented with tabs -- so this is really only used for files that
" indent with tabs, the only place I actually want to use 4.
set tabstop=4

" wrapping
"set colorcolumn=+1              " highlight 81st column
set linebreak                   " break on what looks like boundaries
set showbreak=↳\                " shown at the start of a wrapped line
"set textwidth=80                " wrap after 80 columns
set virtualedit=block           " allow moving visual block into the void


" gui stuff
" set ttymouse=xterm2             " force mouse support for screen
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
set ttimeoutlen=100             " wait 0.1s for xterm keycodes to finish
set nrformats-=octal            " don't try to auto-increment 'octal'
set grepprg=rg\ --vimgrep

set splitright
set splitbelow


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

""" For plugins
" gundo
noremap ,u :GundoToggle<CR>

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'


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



" Ctrl+backspace delete word
" Doesn't work in gnome-terminal, works in neovim-qt
imap <C-BS> <C-W>

" System clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y

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
nnoremap <silent><S-A-k> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><S-A-j> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-k> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-j> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Move lines
" From http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <C-A> cc

nnoremap <CR> i<CR><Esc>

inoremap <silent><F2> <Esc>v`^me<Esc>gi<C-o>:call Ender()<CR>
function! Ender()
	let endchar = nr2char(getchar())
	execute "normal \<End>a".endchar
	normal `e
endfunction

" Plugins

call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'zefei/vim-wintabs'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/context_filetype.vim'
Plug 'kana/vim-repeat'
Plug 'tyru/caw.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug '/usr/share/vim/vimfiles/plugin/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'severin-lemaignan/vim-minimap'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-sensible'
Plug 'chaoren/vim-wordmotion'
Plug 'kshenoy/vim-signature'
Plug 'ap/vim-css-color'

Plug 'shime/vim-livedown', {'do': 'npm i -g livedown'}

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'danilo-augusto/vim-afterglow'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'jacoborus/tender.vim'
Plug 'dracula/vim'
Plug 'nightsense/carbonized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'liuchengxu/space-vim-dark'

Plug 'ryanoasis/vim-devicons'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim'
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}

call plug#end()

execute pathogen#infect()

let g:deoplete#enable_smart_case = 1
let g:deoplete#sources = {}
let g:deoplete#sources.javascript = ['LanguageClient']
let g:deoplete#sources.css = ['LanguageClient']
call deoplete#custom#option('auto_complete_delay', 100)

set hidden

let g:javascript_plugin_flow = 1

" let g:ale_completion_enabled = 1
let g:ale_linters = {
\	'html': ['eslint']
\}
let g:ale_pattern_options = {
\	'\.min.js$': {'ale_enabled': 0},
\	'node_modules': {'ale_enabled': 0},
\	'build': {'ale_enabled': 0}
\}
let g:ale_lint_delay = 500
" let g:ale_lint_on_text_changed = 'never'

" Language Server providers
" Note: PHP provider installed via helper plugin above
"
" rust: https://github.com/rust-lang-nursery/rls
" php: https://github.com/felixfbecker/php-language-server
" javascript/ts: https://github.com/sourcegraph/javascript-typescript-langserver
" javascript/flow: https://github.com/flowtype/flow-language-server
" css: https://github.com/vscode-langservers/vscode-css-languageserver-bin
" vue: https://github.com/vuejs/vetur/tree/master/server

" Alternatives / others:
" 'javascript.typescript': ['javascript-typescript-stdio'],
" 'css': ['/home/mischka/.npm-global/bin/css-languageserver', '--stdio']
let g:LanguageClient_serverCommands = {
\	'rust': ['rustup', 'run', 'nightly', 'rls'],
\	'javascript': ['/home/mischka/.npm-global/bin/flow-language-server', '--stdio'],
\	'vue': ['/home/mischka/.npm-global/bin/vls']
\}

let g:LanguageClient_autoStart = 1

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and syntax
" in GUI or color console, enable coloring and search highlighting
if &t_Co > 2 || has("gui_running")
  syntax enable
  set background=dark
  set hlsearch
endif

set t_Co=256  " force 256 colors

if has("autocmd")
  " Filetypes and indenting settings
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text,markdown setlocal textwidth=78
  autocmd FileType text,markdown setlocal spell spelllang=en_us


  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set filetypes based on extension

  " I'd like to do html.javascript.css, but for some reason the deoplete
  " provider for css is breaking quoted attribute entry, making it jump to 1:1
  autocmd BufNewFile,BufRead *.html set filetype=html.javascript
  autocmd BufNewFile,BufRead *.cool set filetype=scala

  " Manually sync syntax in Vue files
  " https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
  autocmd FileType vue syntax sync fromstart

  " Enable deoplete in insert mode
  autocmd InsertEnter * call deoplete#enable()
endif " has("autocmd")

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
	set termguicolors
endif

let $FZF_DEFAULT_COMMAND = 'rg --files --follow'

let g:onedark_terminal_italics=1

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'

let g:enable_bold_font = 1
let g:enable_italic_font = 1

" Helpers in case I feel like changing between light and dark themes
function! DarkTheme()
	colorscheme space-vim-dark
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

" molokai's diff coloring is terrible
" highlight DiffAdd    ctermbg=22
" highlight DiffDelete ctermbg=52
" highlight DiffChange ctermbg=17
" highlight DiffText   ctermbg=53

let g:NERDTreeShowHidden = 1
let g:NERDTreeShowIgnoredStatus = 1
let g:NERDSpaceDelims = 1

let g:jsx_ext_required = 0

" Remove escape delay to reenter normal mode
" https://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=1000 ttimeoutlen=0

"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1
map <C-P> :FZF<CR>
map <C-H> <Plug>(wintabs_previous)
map <C-L> <Plug>(wintabs_next)
map <C-T>w <Plug>(wintabs_close)
map <C-T>c <Plug>(wintabs_close)
map <C-T>o <Plug>(wintabs_only)
map <C-W>c <Plug>(wintabs_close_window)
map <C-W>o <Plug>(wintabs_only_window)
map <C-_> gcc
map \ :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab

" nmap <C-M> :LivedownToggle<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last but not least, allow for local overrides
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
if filereadable(expand("./.vimrc.local"))
	source ./.vimrc.local
endif
