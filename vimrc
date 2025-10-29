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
set showmatch " show matching braces when text indicator is over them

set spellfile=~/.vim/spell/en.utf-8.add
set spelllang=en
set spelloptions+=camel
set spell

"---------------------
" Basic editing config
"---------------------
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=autoselectplus

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
set tabstop=8

" Place tab to numbers of space
" set expandtab

set shiftwidth=8
set listchars=tab:>>,nbsp:~,trail:-,eol:$ " set list to see tabs and non-breakable spaces
set scrolloff=5 " show lines above and below cursor (when possible)
set hls "set highlight search
set cursorline " Highlight current line

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
set nonumber

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set norelativenumber

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

"Disable searching loop
set nowrapscan

" paste mode
set pastetoggle=<F2> " insert mode

" Auto change directory
set autochdir

"jump options
set jumpoptions=stack

" disable audible bell
set noerrorbells visualbell t_vb=

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
set background=dark

"---------------------
" extend editing tools
"---------------------
set tags=tags
set tags+=$MY_CTAGS_FILE
set cscoperelative

let g:solarized_termcolors=256
colorscheme solarized

syntax on " turn on syntax highlighting
" Spelling check highlight
highlight SpellBad cterm=underline ctermfg=DarkMagenta guifg=DarkMagenta gui=undercurl
highlight SpellCap cterm=underline ctermfg=Yellow guifg=Yellow gui=undercurl
highlight SpellRare cterm=underline ctermfg=Magenta guifg=Magenta gui=undercurl
highlight SpellLocal cterm=underline ctermfg=Cyan guifg=Cyan gui=undercurl

nnoremap <leader>sp :set spell!<CR>:echo "Spell check: " . (&spell ? "ON" : "OFF")<CR>

"Extra whitespace highlight
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+/

" Quick search for selected text in visual mode press "//"
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"--------------------
" Misc configurations
"--------------------
" recognize file type
filetype plugin indent on
autocmd BufRead,BufNewFile *.md,*.markdown set filetype=markdown
autocmd BufRead,BufNewFile *.S,*.s,*.asm,*.d set filetype=asm
autocmd BufRead,BufNewFile *.hex,*.bin set filetype=hex

" unbind keys
map <C-q> <Nop>
" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Limit the width of the text in mutt emails to 72 characters.
au BufRead /tmp/mutt-* set textwidth=72

" user plugin
call plug#begin()
Plug 'preservim/nerdtree' " for file exploring

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "fzf for fuzzy search
Plug 'junegunn/fzf.vim'

Plug 'embear/vim-localvimrc' " source local .lvimrc file in current dir
call plug#end()

"embear/vim-localvimrc config
let localvimrc_ask = 0

"nerdtree configure
nnoremap <C-n> :NERDTreeFind<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
