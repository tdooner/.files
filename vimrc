call pathogen#infect()

filetype plugin on
filetype plugin indent on   " Is this necessary?

set autoindent
set background=dark
set backspace=2
set colorcolumn=80
set cursorline
set expandtab
set hlsearch
set ignorecase
set incsearch
set list
set listchars=tab:>-
set nocompatible
set number
set scrolloff=3
set shiftwidth=42
set showtabline=2
set sidescrolloff=3
set sw=2
set term=xterm-256color
set ts=2
set wildmenu
set wildmode=longest,list,full
syntax on
colorscheme slate

highlight ColorColumn ctermbg=234

" Highlight extraneous whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" Spellcheck, but not very visably. [sic]
set spell
highlight SpellBad ctermbg=234

" Improve fold colors
highlight Folded ctermbg=234

" Using Vim with a Dvorak keyboard sucks. This tries to make it suck less by
" binding htns to hjkl.
"map t j
"map n k
"map s l

" Navigate tabs with the tab key. It seems to make sense
" and <Tab> isn't used for anything else.
nmap <tab> :tabnext<CR>
nmap <S-tab> :tabprevious<CR>

" The ultimate status line.
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

if has('persistent_undo')
  set undodir=~/.vim/tmp/undo,. " keep undo files out of the way
  set undofile " actually use undo files
endif

" For Ctrl+P
let g:ctrlp_map = '<c-t>'
