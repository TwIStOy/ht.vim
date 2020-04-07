function! ht#collection#source(name) abort
  try
    let p = ht#collection#{a:name}#entry_point()
  catch /^Vim\%((\a\+)\)\=:E117/
    echo 'failed to source collection: ' . a:name
  endtry
endfunction

