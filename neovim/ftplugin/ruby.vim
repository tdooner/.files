" These options are from: `:help ruby.vim`
" let ruby_fold=1
" let ruby_foldable_groups = 'class module def'
" set foldlevel=1
set foldmethod=expr
set foldexpr=v:lua.vim.treesitter.foldexpr()
set foldlevel=3
set foldminlines=10

" These options are from: https://github.com/vim-ruby/vim-ruby/blob/master/doc/ft-ruby-indent.txt
let g:ruby_indent_hanging_elements = 0
