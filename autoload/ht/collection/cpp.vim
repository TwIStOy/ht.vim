function! ht#collection#cpp#entry_point() abort
  MyPlug 'bfrg/vim-cpp-modern'
  MyPlug 'TwIStOy/leaderf-cppinclude'

  MyPlug 'derekwyatt/vim-fswitch', {
        \ 'on_ft': ['cpp', 'c']
        \ }

  MyPlug 'rhysd/vim-clang-format', {
        \ 'on_cmd': ['ClangFormat']
        \ }

  inoremap <silent><c-e><c-i> <C-o>:LeaderfCppInclude<CR>

  let content = [
        \   [ "&Fuzzy Include", 'LeaderfCppInclude' ],
        \   [ "&ClangFormat", 'ClangFormat' ],
        \ ]
  call ht#quickui#append_context_menu(content, 'cpp')

  let g:cpp_simple_highlight = 1

  NShortcut 'fc', ':<C-u>ClangFormat', 'clang-format'
  NShortcut 'fa', ':FSHere', 'h/cpp-switch-here'
  NShortcut 'fv', ':FSSplitRight', 'h/cpp-switch-split-right'
endfunction


