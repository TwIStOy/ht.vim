function! ht#collection#lsp#entry_point()
  MyPlug 'neoclide/coc.nvim', {
        \ 'build': 'yarn install',
        \ }

  CategoryName 'g', '+goto/lsp'

  Shortcut 'nmap', 'ga', '<Plug>(coc-codeaction)', 'lsp-codeaction'
  Shortcut 'nmap', 'gd', '<Plug>(coc-definition)', 'lsp-definition'
  Shortcut 'nmap', 'gy', '<Plug>(coc-type-definition)', 'lsp-type-def'
  Shortcut 'nmap', 'gi', '<Plug>(coc-implementation)', 'lsp-implementation'
  Shortcut 'nmap', 'gr', '<Plug>(coc-references)', 'lsp-references'
  Shortcut 'nnoremap', 'gk', ':call ' . <SID> .'show_documentation()<CR>',
        \ 'lsp-doc'
  Shortcut 'nmap', 'gR', '<Plug>(coc-rename)', 'lsp-rename'
  Shortcut 'nmap', 'gf', '<Plug>(coc-fix-current)', 'lsp-fix-current-line'

  CategoryName 'l', '+list/search'
  NShortcut 'ld', ':<C-u>CocList diagnostics<CR>', 'list-diagnostics'
  NShortcut 'lo', ':<C-u>CocList outline<CR>', 'list-outline'
  NShortcut 'ld', ':<C-u>CocList -I symbols<CR>', 'list-symbols'
  NShortcut 'ln', ':<C-u>CocNext<CR>', 'list-next'
  NShortcut 'lp', ':<C-u>CocPrev<CR>', 'list-prev'
  NShortcut 'lr', ':<C-u>CocListResume<CR>', 'list-resume'

  set updatetime=200

  " Close preview window when completion is done
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  let g:UltiSnipsEditSplit = "vertical"
  let g:UltiSnipsExpandTrigger="<c-f>"
  let g:UltiSnipsJumpForwardTrigger="<c-f>"
  let g:UltiSnipsJumpBackwardTrigger="<c-b>"
  let g:coc_snippet_next = "<C-f>"
  let g:coc_snippet_prev = "<C-b>"

  nmap <silent> [c <plug>(coc-diagnostic-prev)
  nmap <silent> ]c <plug>(coc-diagnostic-prev)

  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" : "\<TAB>"

  inoremap <silent><expr> <C-n>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<C-n>" :
        \ coc#refresh()

  " default extensions
  let g:coc_global_extensions = [
        \ 'coc-json',
        \ 'coc-ultisnips',
        \ 'coc-tsserver',
        \ 'coc-tabnine',
        \ 'coc-git',
        \ 'coc-vimlsp',
        \ 'coc-fish',
        \ 'coc-template',
        \ 'coc-highlight',
        \ ]

  " default settings
  let g:coc_user_config = {
        \ 'suggest.triggerAfterInsertEnter': v:false,
        \ 'diagnostic.enable': v:true,
        \ 'diagnostic.virtualText': v:false,
        \ 'diagnostic.messageTarget': 'float',
        \ 'signature.hideOnTextChange': v:true,
        \ 'signature.preferShowAbove': v:false,
				\ 'signature.target': 'float',
        \ 'list.insertMappings': {
        \   '<C-j>': 'normal:j',
        \   '<C-k>': 'normal:k'
        \ },
        \ 'list.normalMappings': {
        \   '<C-j>': 'normal:j',
        \   '<C-k>': 'normal:k'
        \ }
        \ }


  set cmdheight=2
  set shortmess+=c
  set signcolumn=yes
  set hidden
endfunction

function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction


