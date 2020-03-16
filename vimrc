filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'Galooshi/vim-import-js'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'SirVer/ultisnips'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'b4b4r07/vim-hcl'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'groenewege/vim-less'
Plugin 'jaawerth/nrun.vim'
Plugin 'jisaacks/GitGutter'
Plugin 'jremmen/vim-ripgrep'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'pangloss/vim-javascript'
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'plasticboy/vim-markdown'
Plugin 'powerline/powerline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'solarnz/thrift.vim'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
Plugin 'w0rp/ale'
Plugin 'wincent/command-t'
Plugin 'wincent/ferret'
Plugin 'wincent/loupe'
Plugin 'wlangstroth/vim-racket'
Plugin 'ycm-core/YouCompleteMe'

" Typescript
Plugin 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'

call vundle#end()
filetype plugin indent on

set autoread
set autoindent
set background=dark
set backspace=2
set backupdir=~/.files/vim/tmp//
set breakindent          " vim8: indent broken lines to first line's indent level
set breakindentopt=shift:2 " indent broken lines with additional two spaces
set breakindentopt+=sbr    " use the 'showbreak' character
set breakindentopt+=min:80 " ensure the wrapped line has a width of 80
set colorcolumn=80
set completeopt-=preview   " disable preview window for completion menu selections
set completeopt+=noselect  " don't eagerly select first item in autocomplete menu
set dir=~/.files/vim/tmp//
set expandtab
set foldlevelstart=1     " remind myself that folds exist
set foldopen-=block      " allow { and } to not open folds
set hlsearch
set incsearch
set laststatus=2
set list
set listchars=tab:>-
set linebreak            " line-break at word boundaries
set nocompatible
set number
set regexpengine=1       " (magic?) increase vim responsiveness in iTerm significantly
set relativenumber
set scrolloff=5
set softtabstop=2
set shiftround
set shiftwidth=42
set showtabline=2
set showbreak=>>
set sidescrolloff=3
set sw=2
set swapfile
set switchbuf=useopen    " allow re-opening buffer in multiple tabs
set term=xterm-256color
set ts=2
set visualbell t_vb=             " disable bell sound and visual bell
set wildmenu
set wildmode=longest,list,full
<<<<<<< HEAD
set wildignore+=*/node_modules/*,*/vendor/*,*/env/*,*/bower_components/*,*.pyc,*/doc/*,*/tmp/*,*/target/*,*/coverage/*
=======
set wildignore+=*/node_modules/*,*/vendor/*,*/env/*,*/bower_components/*,*.pyc,doc/*,*/tmp/*,target/*,coverage/*
>>>>>>> Update vim experience for Javascript/Typescript
syntax on
colorscheme grb256

highlight ColorColumn ctermbg=234

" customize colors for ALE
highlight ALEError ctermbg=52
highlight ALEWarning ctermbg=58
highlight ALEErrorSign ctermfg=52
highlight ALEWarningSign ctermfg=58

" Highlight extraneous whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" Tom slop
" Map :Wq, :WQ, :Q, :W to their appropriately-cased counterparts
command W w
command Q q
command WQ wq
command Wq wq
command Wqa wqa
inoremap [:w <Esc>:w

" Improve fold colors
highlight Folded ctermbg=234

" Improve auto-complete menu
" https://vim.fandom.com/wiki/Improve_completion_popup_menu
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

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
let g:CommandTMaxDepth=15
let g:CommandTInputDebounce=100
let g:CommandTFileScanner='find'

" For GitGutter
let g:gitgutter_eager=0
let g:gitgutter_realtime=0
map <Leader>[ :GitGutterPrevHunk<CR>
map <Leader>] :GitGutterNextHunk<CR>

" For vim-go
let g:go_fmt_command = "goimports"
nnoremap <Leader>d :GoDef<CR>

" For NERD Tree
nnoremap <Leader><Leader> :NERDTreeFind<CR>
<<<<<<< HEAD
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
=======
let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'node_modules']
>>>>>>> Update vim experience for Javascript/Typescript

" For vim-rails
let g:rails_projections = {
  \ "app/lib/*.rb": { "spec": "spec/lib/{}_spec.rb" }
\ }

<<<<<<< HEAD
=======
" For ale
let g:ale_completion_enabled = 1

>>>>>>> Update vim experience for Javascript/Typescript
" YouCompleteMe and UltiSnips compatibility, with the helper of supertab
" (via http://stackoverflow.com/a/22253548/1626737)
" https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
<<<<<<< HEAD
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
let g:ycm_filetype_blacklist = {
    \ 'gitcommit': 1
    \}

function ConvertAttributes()
  %s!\(node\|default\)\.\(\w\+\)\.\(\w\+\)!\1['\2']['\3']!g
endfunction

function GoPreviousTabOrBuffer()
  if tabpagenr('$') == 1
    exec(":bp")
  else
    exec(":tabprevious")
  endif
endfunction
nnoremap <silent> gT :call GoPreviousTabOrBuffer()<CR>

function GoNextTabOrBuffer()
  if tabpagenr('$') == 1
    exec(":bn")
  else
    exec(":tabnext")
  endif
endfunction
nnoremap <silent> gt :call GoNextTabOrBuffer()<CR>

nnoremap <Leader>r :redraw!<CR>
=======

nnoremap <Leader>r :redraw!<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" load ~/dev/config/[project]/vimrc if it exists
function LoadProjectVimConfig()
  let l:project_name = trim(system("basename $(git rev-parse --show-toplevel 2>/dev/null || pwd)"))
  let l:project_vimscript_file = expand("~/dev/config/" . project_name . "/vimrc")
  if filereadable(l:project_vimscript_file)
    exec "source " . l:project_vimscript_file
  endif
endfunction
call LoadProjectVimConfig()
>>>>>>> Update vim experience for Javascript/Typescript
