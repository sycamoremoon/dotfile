" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible
"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting

set showmatch " show matching braces when text indicator is over them

if has('gui_running')
    set background=light
else
    set background=dark
endif

let g:solarized_termcolors=256
colorscheme solarized

"---------------------
" Basic editing config
"---------------------
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Set up vim history
set history=1000
set viminfo='100,<50,s10,h
if has("persistent_undo")
    set undofile
    set undodir=~/.vim/undodir
endif

" Enhance command-line completion
set wildmenu
set showcmd
set tabstop=4

" Place tab to numbers of space
" set expandtab

set shiftwidth=4
set listchars=tab:>>,nbsp:~,trail:-,eol:$ " set list to see tabs and non-breakable spaces
set scrolloff=5 " show lines above and below cursor (when possible)
set hls "set highligt search

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, if you only have more windows open.
set laststatus=1

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
" set mouse=nvi

"leaderkey
"let leadermap=

" Quick search for selected text in visual mode press "//"
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"Disable searching loop
set nowrapscan

"---------------------
" extend editing tools
"---------------------
set tags=tags
set tags+=$MY_CTAGS_FILE
set cscoperelative

"CtrlP configure
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"jump options
set jumpoptions=stack

"nerdtree configure
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
"
"--------------------
" Misc configurations
"--------------------
" recognize file type
filetype plugin indent on
autocmd BufRead,BufNewFile *.md,*.markdown set filetype=markdown
autocmd BufRead,BufNewFile *.S,*.s,*.asm,*.d set filetype=asm
autocmd BufRead,BufNewFile *.hex,*.bin set filetype=hex

" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
map <C-q> <Nop>
" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" disable audible bell
set noerrorbells visualbell t_vb=

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" markdown
"let g:markdown_fenced_languages = [
    \ 'asm',
    \ 'bash=sh',
    \ 'c',
    \ 'coffee',
    \ 'erb=eruby',
    \ 'javascript',
    \ 'json',
    \ 'perl',
    \ 'python',
    \ 'ruby',
    \ 'yaml',
    \ 'go',
    \ 'racket',
    \ 'haskell',
    \ 'rust',
\]
"let g:markdown_syntax_conceal = 0
"let g:markdown_folding = 1

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" user plugin
call plug#begin()
Plug 'godlygeek/tabular' " for format text

Plug 'brookhong/cscope.vim'

Plug 'preservim/nerdtree' " for file exploring

Plug 'https://github.com/kien/ctrlp.vim.git' " CtrlP for file exploring

Plug 'rust-lang/rust.vim' " for file exploring

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "fzf for fuzzy search
call plug#end()
