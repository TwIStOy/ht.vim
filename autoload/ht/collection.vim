function! ht#collection#source(name) abort
  let p = ht#collection#{a:name}#entry_point()
  " try
  " catch /^Vim\%((\a\+)\)\=:E117/
  "   echo 'failed to source collection: ' . a:name
  " endtry
endfunction

