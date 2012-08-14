set tw=80

" TODO: This doesn't seem to work...
" Fold specs to make them more legible.
function! s:FoldItBlock()
  let start = search('^\s*\(it\|specify\|scenario\|before\).*do\s*$', 'We')
  let end = search('end', 'We')
  let cmd = (start+1).','.(end).'fold'
  if (start > 0) && (start < end)
    execute cmd
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
