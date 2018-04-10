filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'Galooshi/vim-import-js'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'b4b4r07/vim-hcl'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'groenewege/vim-less'
Plugin 'jisaacks/GitGutter'
Plugin 'kchmck/vim-coffee-script'
Plugin 'majutsushi/tagbar'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'mxw/vim-jsx'
Plugin 'neomake/neomake'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'powerline/powerline'
Plugin 'mileszs/ack.vim'
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
Plugin 'wincent/command-t'
Plugin 'wincent/ferret'
Plugin 'wincent/loupe'
Plugin 'wlangstroth/vim-racket'

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
set term=xterm-256color
set ts=2
set wildmenu
set wildmode=longest,list,full
set wildignore+=*/node_modules/*,*/vendor/*,*/env/*,*/bower_components/*,*.pyc,doc/*,tmp/*,target/*,coverage/*
syntax on
colorscheme grb256

highlight ColorColumn ctermbg=234

" Highlight extraneous whitespace.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * redraw!

" Tom slop
" Map :Wq, :WQ, :Q, :W to their appropriately-cased counterparts
command W w
command Q q
command WQ wq
command Wq wq
command Wqa wqa
inoremap [:w <Esc>:w

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
let g:CommandTMaxDepth=15
let g:CommandTInputDebounce=100
let g:CommandTFileScanner='find'

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
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

let g:neomake_list_height = 2     " this doesn't work but hopefully will someday
let g:neomake_open_list = 2
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']
let g:neomake_ruby_rubocop_args = ['--format', 'emacs', '-D']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'

" let g:neomake_verbose = 3 " Debug information

" For vim-rails
let g:rails_projections = {
  \ "app/lib/*.rb": { "alternate": "spec/lib/{}_spec.rb" }
\ }

autocmd! BufWritePost * Neomake
" get out of the the quickfix menu... there must be a discrepancy between
" vim/neovim in how the location lists are created
function SwitchBackIfInQuickfix()
  if &buftype == 'quickfix'
    wincmd p
    exe "norm! 6\<C-Y>"
  endif
endfunction
autocmd! User NeomakeFinished :call SwitchBackIfInQuickfix()

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

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
