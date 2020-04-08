vim9script

import { GenerateDict, MergeDict } from 'ht/dict.vim'

let g:ht_mapping = {}

function! ht#mapping#leader(type, key, action, ...) abort
  let l:cmd = a:type .. ' <silent><leader>' .. a:key .. ' ' .. a:action .. '<CR>'
  execute l:cmd

  if a:0 > 0
    let l:keys = split(a:key, '\zs') + [a:1]
    let named_dict = GenerateDict(l:keys)
    MergeDict(g:ht_mapping, named_dict)
  endif
endfunction

export def ht#mapping#category_name(key, name)
  let keys = split(key, '\zs') + ['name', name]
  let named_dict = GenerateDict(keys)
  MergeDict(g:ht_mapping, named_dict)
enddef

export def ht#mapping#command()
  command! -nargs=+ Shortcut     call ht#mapping#leader(<args>)
  command! -nargs=+ CategoryName call ht#mapping#category_name(<args>)
  command! -nargs=+ NShortcut    call ht#mapping#leader('nnoremap', <args>)
enddef


