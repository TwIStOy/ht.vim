let g:ht_vim_root = $HOME . '/vim_plugin/ht.vim/'

set runtimepath+=$HOME/vim_plugin/ht.vim/

call ht#vim#plug#install_missing_plugin_manager()
call ht#vim#plug#define_command()
call ht#mapping#command()

let g:axring_rings = [
      \   ['true', 'false'],
      \   ['True', 'False'],
      \   ['Debug', 'Info', 'Warn', 'Error', 'Fatal'],
      \   ['first', 'second'],
      \   ['uint8_t', 'uint16_t', 'uint32_t', 'uint64_t'],
      \   ['htonl', 'ntohl'],
      \   ['htons', 'ntohs'],
      \   ['ASSERT_EQ', 'ASSERT_NE'],
      \   ['EXPECT_EQ', 'EXPECT_NE'],
      \ ]

call ht#vim#plug#begin()

call ht#collection#source('default')
call ht#collection#source('better')
call ht#collection#source('cpp')
call ht#collection#source('lsp')

call ht#vim#plug#end()

set background=dark
syntax on
colorscheme candid
let g:lightline.colorscheme = 'candid'

call which_key#register('<Space>', "g:ht_mapping")

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

