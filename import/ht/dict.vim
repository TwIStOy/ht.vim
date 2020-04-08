vim9script

export def GenerateDict(args: list<string>): any
  if len(args) == 1
    return args[0]
  endif

  let tmp: list<string> = []
  for i in range(1, len(args) - 1)
    tmp->add(args[i])
  endfor

  return { args[0]: GenerateDict(tmp), }
enddef

export def MergeDict(expr1: any, expr2: any)
  if type(expr1) != v:t_dict || type(expr2) != v:t_dict
    return
  endif

  for key in keys(expr2)
    if !has_key(expr1, key)
      call extend(expr1, {key: get(expr2, key),}, 'force')
    else
       MergeDict(get(expr1, key), get(expr2, key))
    endif
  endfor
enddef

" let tmp = GenerateDict(['a', 'b', 'c', 'd', 'abc'])
" let tmp2 = GenerateDict(['a', 'b', 'c', 'e', 'bcd'])
" MergeDict(tmp, tmp2)

