function! ht#collection#default#entry_point() abort
  call s:config()
  call s:key_map()

  " compatible with some neovim only plugins
  MyPlug 'roxma/nvim-yarp'
  MyPlug 'roxma/vim-hug-neovim-rpc'

  MyPlug 'skywind3000/asyncrun.vim', {
        \   'on_cmd': ['AsyncRun', 'AsynccStop']
        \ }

  MyPlug 'mhinz/vim-startify', {
        \   'on_cmd': ['Startify'],
        \ }

  MyPlug 'Shougo/defx.nvim', {
        \   'on_cmd': ['Defx'],
        \ }

  MyPlug 'liuchengxu/vim-which-key'

  MyPlug 'flrnd/candid.vim'

  MyPlug 'skywind3000/vim-quickui'

  call ht#builtin#defx#entry_point()
  call ht#builtin#startify#entry_point()
endfunction

function! s:config() abort
  let g:mapleader = "\<Space>"
  let g:maplocalleader = ','

  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"

  " used for term color
  set term=xterm-256color
  set t_Co=256

  augroup htStartify
    autocmd!
    autocmd VimEnter *
          \  if !argc()
          \|   call dein#source('vim-startify')
          \|   silent! Startify
          \| endif
  augroup END

  map <Left>  <Nop>
  map <Right> <Nop>
  map <Up>    <Nop>
  map <Down>  <Nop>

  set nocompatible
  set backspace=2
  set title
  set lazyredraw
  set termguicolors

  " nobells
  set noerrorbells
  set novisualbell
  set t_vb=

  set number relativenumber
  augroup relativeNumberToggle
    autocmd!
    autocmd WinEnter,FocusGained,InsertLeave * set relativenumber
    autocmd WinLeave,FocusLost,InsertEnter * set norelativenumber
  augroup END

  set cursorline
  set colorcolumn=80

  set tabstop=2
  set shiftwidth=2
  set expandtab
  set smartindent
  set autoindent

  set exrc

  set scrolloff=5
  set timeoutlen=500

  call ht#vim#window#add_uncountable_type(['defx', 'quickfix'])
  call ht#vim#window#enable_auto_close()

  "#fb7da7 #FB7DA7	red (Tickle me pink)	Statement
 " #a18bd3 #A18BD3	purple (Blue bell)	Identifier, function
 " #ffce5b #FFCE5B	yellow (Mustard)	String
 " #50c6d8 #50C6D8	cyan (Sea serpent)	Constant, Type
 " #2cda9d #2CDA9D	green (Eucalyptus)	Special
 " #4C8273 #4C8273	comment (Viridian)	Comment
 " #1c1c1c #1c1c1c	menublack (Pale black)	Menu
 " #818e8e #818E8E	grey (Mummys tomb)	Punctuation, noise
 " #efeeea #EFEEEA	white (Isabelline)	Foreground
 " #2f343f #2F343F	black (Raisin black)	Background

  let g:quickui_border_style = 2
  " TODO(hawtian): fix color
  hi! QuickBG ctermfg=0 ctermbg=7 guifg=#EFEEEA guibg=#2F343F
  " hi! QuickKey term=bold ctermfg=9 gui=bold guifg=#FFCE5B
  " hi! QuickSel cterm=bold ctermfg=0 ctermbg=2 gui=bold guibg=#50c6d8 guifg=#A18BD3
  " hi! QuickOff ctermfg=59 guifg=#4C8273
  " hi! QuickHelp ctermfg=247 guifg=#959173
endfunction

function! s:key_map() abort
  for l:i in range(1, 9)
    NShortcut string(l:i),
          \ ':call ht#vim#window#move_to(' . l:i . ')', 'Window ' . l:i
  endfor

  CategoryName 'f', '+file'
  NShortcut 'fs', ':update', 'save'

  let g:ht_defx_parameters = [
      \ '-split=vertical',
      \ '-winwidth=35',
      \ '-ignored-files=*.d',
      \ '-toggle',
      \ ]
  nnoremap <silent><Plug>(toggle_defx) :call <SID>toggle_defx()<CR>

  NShortcut 'ft', ':call feedkeys("\<Plug>(toggle_defx)")',
        \ 'toggle-file-explorer'

  NShortcut 'q', ':q', 'quit'
  NShortcut 'x', ':wq', 'save-and-quit'
  NShortcut 'Q', ':qa!', 'force-quit'
  NShortcut 'tq', ':call ht#vim#window#toggle_quickfix()', 'toggle-quickfix'

  nnoremap <silent> <F2> :call <SID>fast_forward_to_file()<CR>
  nnoremap <silent> <F3> :call <SID>select_buffer()<CR>

  nnoremap <Plug>(window_w) <C-W>w
  nnoremap <Plug>(window_r) <C-W>r
  nnoremap <Plug>(window_d) <C-W>c
  nnoremap <Plug>(window_q) <C-W>q
  nnoremap <Plug>(window_j) <C-W>j
  nnoremap <Plug>(window_k) <C-W>k
  nnoremap <Plug>(window_h) <C-W>h
  nnoremap <Plug>(window_l) <C-W>l
  nnoremap <Plug>(window_H) <C-W>5<
  nnoremap <Plug>(window_L) <C-W>5>
  nnoremap <Plug>(window_J) :resize +5<CR>
  nnoremap <Plug>(window_K) :resize -5<CR>
  nnoremap <Plug>(window_b) <C-W>=
  nnoremap <Plug>(window_s1) <C-W>s
  nnoremap <Plug>(window_s2) <C-W>s
  nnoremap <Plug>(window_v1) <C-W>v
  nnoremap <Plug>(window_v2) <C-W>v
  nnoremap <Plug>(window_2) <C-W>v
  nnoremap <Plug>(window_x) <C-W>x
  nnoremap <Plug>(window_p) <C-W>p

  CategoryName 'w', '+window'
  NShortcut 'wv', ':call feedkeys("\<Plug>(window_v1)")', 'split-window-right'
  NShortcut "w-", ':call feedkeys("\<Plug>(window_s1)")', 'split-window-below'
  NShortcut 'w=', ':call feedkeys("\<Plug>(window_b)")', 'balance-window'

  NShortcut 'wr', ':call feedkeys("\<Plug>(window_r)")', 'rotate-windows-rightwards'
  NShortcut 'wx', ':call feedkeys("\<Plug>(window_x)")', 'exchange-window-with-next'
  NShortcut 'ww', ':call feedkeys("\<Plug>(window_w)")', 'move-to-next-window'

  NShortcut 'wh', ':call feedkeys("\<Plug>(window_h)")', 'window-left'
  NShortcut 'wj', ':call feedkeys("\<Plug>(window_j)")', 'window-down'
  NShortcut 'wk', ':call feedkeys("\<Plug>(window_k)")', 'window-up'
  NShortcut 'wl', ':call feedkeys("\<Plug>(window_l)")', 'window-right'

  nnoremap <silent><leader> :WhichKey '<Space>'<CR>
  augroup WhichKeyGroup
    autocmd! FileType which_key
    autocmd  FileType which_key set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  augroup END
endfunction

function! s:toggle_defx() abort
  let cmd = join(g:ht_defx_parameters)
  execute 'Defx ' . l:cmd
endfunction

function! s:fast_forward_to_file() abort
  for l:i in range(1, winnr('$'))
    let l:tp = getbufvar(winbufnr(l:i), '&ft')

    if l:tp == 'defx'
      execute ':' . l:i . 'wincmd w'
      return
    endif
  endfor

  call s:toggle_defx()
endfunction

function! s:select_buffer() abort
  let opts = {'title': 'Select Buffers'}
  let info = ht#vim#buffer#all_buffes_info()
  if len(info) == 0
    call add(info, "   <nobuffer>   ")
  endif
  call quickui#listbox#open(info, opts)
endfunction

