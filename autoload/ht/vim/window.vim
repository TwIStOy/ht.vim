vim9script

let s:uncountable_type = get(s:, 'uncountable_type', {})

export def ht#vim#window#add_uncountable_type(tps: list<string>)
  for tp in tps
    s:uncountable_type->extend({tp: 1,}, 'keep')
  endfor
enddef

export def ht#vim#window#skip_uncountable_window(id: number): number
  return s:skip_uncountable_window(id)
enddef

export def ht#vim#window#move_to(id: number)
  let new_id = s:skip_uncountable_window(id)
  if new_id
    execute ':' .. new_id .. 'wincmd w'
  endif
enddef

export def ht#vim#window#toggle_quickfix()
  if s:find_quickfix()
    cclose
  else
    copen
  endif
enddef

export def ht#vim#window#enable_auto_close()
  augroup AutoCloseGroup
    au!
    au BufEnter * call s:check_last_window()
  augroup END
enddef

def s:check_last_window()
  let total = winnr('$')
  for i in range(1, winnr('$'))
    if s:is_uncountable(i)
      total -= 1
    endif
  endfor

  if total == 0
    quitall!
  endif
enddef

def s:find_quickfix(): bool
  for i in range(1, bufnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      return true
    endif
  endfor

  return false
enddef

def s:skip_uncountable_window(id: number): number
  let rest = id
  for i in range(1, winnr('$'))
    if s:is_uncountable(i)
      continue
    endif

    rest -= 1
    if rest == 0
      return i
    endif
  endfor
  return 0
enddef

def s:is_uncountable(i: number): bool
  let tp = getbufvar(winbufnr(i), '&buftype')
  if has_key(s:uncountable_type, tp)
    return true
  endif

  tp = getbufvar(winbufnr(i), '&ft')
  if has_key(s:uncountable_type, tp)
    return true
  endif

  return false
enddef

