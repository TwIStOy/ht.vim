let g:dein_root = get(g:, 'ht_deiin_root', $HOME . '/.cache/ht.vim/dein')
let s:plugins = get(s:, 'plugins', {})

function! ht#vim#plug#install_missing_plugin_manager() abort
  if !isdirectory(g:dein_root . '/repos/github.com/Shougo/dein.vim')
    echo "Installing dein..."
    execute '!curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh'
    execute '!sh /tmp/installer.sh ' . g:dein_root
  endif

  execute 'set runtimepath+=' . g:dein_root . '/repos/github.com/Shougo/dein.vim'
endfunction

function! ht#vim#plug#begin() abort
  call dein#begin(g:dein_root)
endfunction

function! ht#vim#plug#end() abort
  for plug in keys(s:plugins)
    call dein#add(plug, s:plugins[plug])
  endfor

  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif
endfunction

function! ht#vim#plug#reg(plug, ...)
  if has_key(s:plugins, a:plug)
    echom 'plugin ' . a:plug . ' has been registered.'
    return
  endif

  let l:options = {}

  if a:0 > 0
    let l:options = a:1
  endif

  let s:plugins[a:plug] = l:options
endfunction

function! ht#vim#plug#update(plug, options)
  if !has_key(s:plugins, a:plug)
    echom 'plugin ' . a:plug . ' has not been registered.'
    return
  endif

  let s:plugins[a:plug] = a:options
endfunction

function! ht#vim#plug#define_command() abort
  command! -nargs=+ MyPlug  call ht#vim#plug#reg(<args>)
  command! -nargs=+ UMyPlug call ht#vim#plug#update(<args>)
endfunction

