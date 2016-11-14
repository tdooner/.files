function brigade#GoJavascript()
  let f = split(expand('%'), "/")
  execute "e " . join(f[0:-2], "/") . "/index.jsx"
endfunction

function brigade#GoCSS()
  echo expand('%')
  let f = split(expand('%'), "/")
  execute "e " . join(f[0:-2], "/") . "/index.scss"
endfunction

function brigade#GoTest()
  echo expand('%')
  let f = split(expand('%'), "/")
  execute "e " . join(f[0:-2], "/") . "/index-test.jsx"
endfunction

function brigade#GoHappo()
  echo expand('%')
  let f = split(expand('%'), "/")
  execute "e " . join(f[0:-2], "/") . "/index-happo.jsx"
endfunction
