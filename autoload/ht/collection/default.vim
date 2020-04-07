function! ht#collection#default#entry_point() abort
  call s:config()

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

  MyPlug 'liuchengxu/vim-which-key', {
        \   'on_cmd': ['WhichKey', 'WhichKey!'],
        \ }



endfunction

function! s:config() abort
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

  set scrolloff 5
  set timeoutlen=500

endfunction

