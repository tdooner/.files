set tw=80

" Fold specs to make them more legible.
function! s:FoldItBlock()
  let start = search('^\s*\(describe\|it\|specify\|scenario\|before\|shared_context\).*do\s*$', 'We')
  let indentlevel = indent(line('.'))
  let end = search('^' . repeat(' ', indentlevel) . 'end$', 'We')
  let cmd = (start).','.(end).'fold'
  if (start > 0) && (start < end)
    if (indentlevel > 0) " Don't fold the outermost 'describe' block
      execute cmd
    endif
    return 1
  else
    return 0
  endif
endfunction

function! FoldAllItBlocks()
  let position = line('.')
  exe cursor(1,1)
  let result = 1

  while result == 1
    let result = s:FoldItBlock()
  endwhile

  call cursor(position, 2)
endfunction

au BufRead,BufNewFile,FileReadPost *_spec.rb call FoldAllItBlocks()
