set foldmethod=expr
set foldexpr=GetFoldLevel(v:lnum)

function! GetFoldLevel(lnum)
  if getline(a:lnum) =~? '\v^const.*$'
    return '2'
  elseif getline(a:lnum) =~? '\v^$'
    return '0'
  elseif getline(a:lnum) =~? '\v^  [^ ]+$'
    return '-1'
  endif
endfunction
