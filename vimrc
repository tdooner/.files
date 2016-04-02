filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'benekastah/neomake'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jisaacks/GitGutter'
Plugin 'powerline/powerline'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'trotzig/import-js'
Plugin 'wincent/command-t'

call vundle#end()
filetype plugin indent on

set autoread
set autoindent
set background=dark
set backspace=2
set backupdir=~/.files/vim/tmp//
set colorcolumn=80
set dir=~/.files/vim/tmp//
set expandtab
set hlsearch
set incsearch
set laststatus=2
set list
set listchars=tab:>-
set nocompatible
set number
set scrolloff=5
set softtabstop=2
set shiftround
set shiftwidth=42
set showtabline=2
set sidescrolloff=3
set sw=2
set swapfile
set term=xterm-256color
set ts=2
set wildmenu
set wildmode=longest,list,full
set wildignore+=node_modules/**,vendor/**,env/**,**/bower_components/**,*.pyc,doc/**,tmp/**
syntax on
colorscheme grb256

highlight ColorColumn ctermbg=234

" Highlight extraneous whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" Map :Wq, :WQ, :Q, :W to their appropriately-cased counterparts
command W w
command Q q
command WQ wq
command Wq wq

" Spellcheck, but not very visably. [sic]
" set spell
"highlight SpellBad ctermbg=234
"highlight SpellCap ctermbg=234

" Improve fold colors
highlight Folded ctermbg=234

" Using Vim with a Dvorak keyboard sucks. This tries to make it suck less by
" binding htns to hjkl.
"map t j
"map n k
"map s l

" Navigate tabs with the tab key. It seems to make sense
" and <Tab> isn't used for anything else.
" nmap <tab> :tabnext<CR>
" nmap <S-tab> :tabprevious<CR>

" The ultimate status line.
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

if has('persistent_undo')
  set undodir=~/.vim/tmp/undo// " keep undo files out of the way
  set undofile " actually use undo files
endif

" For CommandT
let mapleader = ','
let g:CommandTMaxHeight=7
let g:CommandTMatchWindowReverse = 1
let g:CommandTMaxDepth=7
let g:CommandTInputDebounce=100

" For GitGutter
let g:gitgutter_eager=0
let g:gitgutter_realtime = 0
map <Leader>[ :GitGutterPrevHunk<CR>
map <Leader>] :GitGutterNextHunk<CR>

" For vim-go
let g:go_fmt_command = "goimports"
nnoremap <Leader>d :GoDef<CR>

" For NERD Tree
nnoremap <Leader><Leader> :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$']

" For syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = "node_modules/.bin/eslint"
let g:syntastic_scss_checkers = ['scss_lint'] " disable 'sass' which fails

if split(getcwd(), "/")[-1] == 'brigade'
  let g:syntastic_ruby_rubocop_exec = '/usr/bin/env'
  let g:syntastic_ruby_rubocop_args = ['BUNDLE_GEMFILE=~/brigade/.overcommit_gems.rb', 'bundle', 'exec', 'rubocop']

  let g:syntastic_scss_scss_lint_exec = '/usr/bin/env'
  let g:syntastic_scss_scss_lint_args = ['BUNDLE_GEMFILE=~/brigade/.overcommit_gems.rb', 'bundle', 'exec', 'scss-lint']
endif

" YouCompleteMe and UltiSnips compatibility, with the helper of supertab
" (via http://stackoverflow.com/a/22253548/1626737)
" https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

function ConvertAttributes()
  %s!\(node\|default\)\.\(\w\+\)\.\(\w\+\)!\1['\2']['\3']!g
endfunction

function GoJavascript()
  let f = split(expand('%'), "/")
  echo f
  execute "e " . join(f[0:-2], "/") . "/index.jsx"
endfunction
nnoremap <Leader>gj :call GoJavascript()<CR>

function GoCSS()
  echo expand('%')
  let f = split(expand('%'), "/")
  execute "e " . join(f[0:-2], "/") . "/index.scss"
endfunction
nnoremap <Leader>gc :call GoCSS()<CR>

function GoTest()
  echo expand('%')
  let f = split(expand('%'), "/")
  execute "e " . join(f[0:-2], "/") . "/index-test.jsx"
endfunction
nnoremap <Leader>gt :call GoTest()<CR>

function GoPreviousTabOrBuffer()
  if tabpagenr('$') == 1
    exec(":bp")
  else
    exec(":tabprevious")
  endif
endfunction
nnoremap gT :call GoPreviousTabOrBuffer()<CR>

function GoNextTabOrBuffer()
  if tabpagenr('$') == 1
    exec(":bn")
  else
    exec(":tabnext")
  endif
endfunction
nnoremap gt :call GoNextTabOrBuffer()<CR>
