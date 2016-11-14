set foldmethod=expr
set foldexpr=GetFoldLevel(v:lnum)

nnoremap <silent> <Leader>gj :call brigade#GoJavascript()<CR>
nnoremap <silent> <Leader>gc :call brigade#GoCSS()<CR>
nnoremap <silent> <Leader>gt :call brigade#GoTest()<CR>
nnoremap <silent> <Leader>gh :call brigade#GoHappo()<CR>

function! GetFoldLevel(lnum)
  if getline(a:lnum) =~? '\v^const.*$'
    return '2'
  elseif getline(a:lnum) =~? '\v^$'
    return '0'
  elseif getline(a:lnum) =~? '\v^  [^ ]+$'
    return '-1'
  endif
endfunction
