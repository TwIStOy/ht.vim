vim9script

export def ht#vim#buffer#all_buffes_info(): list<any>
  let content = []

  for i in range(1, bufnr('$'))
    let name: string = bufname(i)

    if name != ''
      let fullpath: string = expand('#' .. i .. ':p')

      content->add([name .. "\t" .. fullpath, 'buffer ' .. i])
    endif
  endfor

  let cnt = 1
  if len(content) < 10
    let content2 = []

    for item in content
      content2->add(['[&' .. cnt .. "]\t" .. item[0], item[1]])
      cnt += 1
    endfor

    return content2
  endif

  return content
enddef

