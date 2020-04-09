function! ht#collection#cpp#entry_point() abort
  MyPlug 'bfrg/vim-cpp-modern'
  MyPlug 'TwIStOy/leaderf-cppinclude'

  inoremap <silent><c-e><c-i> <C-o>:LeaderfCppInclude<CR>

  let content = [
        \   [ "&Fuzzy Include", 'LeaderfCppInclude' ]
        \ ]
  call ht#quickui#append_context_menu(content, 'cpp')
endfunction


