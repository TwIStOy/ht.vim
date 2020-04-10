function! ht#collection#lsp#entry_point()
  MyPlug 'neoclide/coc.nvim', {
        \  'rev': 'release',
        \ }

  CategoryName 'g', '+goto/lsp'

  Shortcut 'nmap', 'ga', '<Plug>(coc-codeaction)', 'lsp-codeaction'
  Shortcut 'nmap', 'gd', '<Plug>(coc-definition)', 'lsp-definition'
  Shortcut 'nmap', 'gy', '<Plug>(coc-type-definition)', 'lsp-type-def'
  Shortcut 'nmap', 'gi', '<Plug>(coc-implementation)', 'lsp-implementation'
  Shortcut 'nmap', 'gr', '<Plug>(coc-references)', 'lsp-references'
  Shortcut 'nmap', 'gR', '<Plug>(coc-rename)', 'lsp-rename'
  Shortcut 'nmap', 'gf', '<Plug>(coc-fix-current)', 'lsp-fix-current-line'

  NShortcut 'gk', ':call ht#collection#lsp#show_documentation()', 'lsp-doc'

  CategoryName 'l', '+list/search'
  NShortcut 'ld', ':<C-u>CocList diagnostics', 'list-diagnostics'
  NShortcut 'lo', ':<C-u>CocList outline', 'list-outline'
  NShortcut 'ld', ':<C-u>CocList -I symbols', 'list-symbols'
  NShortcut 'ln', ':<C-u>CocNext', 'list-next'
  NShortcut 'lp', ':<C-u>CocPrev', 'list-prev'
  NShortcut 'lr', ':<C-u>CocListResume', 'list-resume'

  call s:context_menu()

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

  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

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

  set nobackup
  set nowritebackup
endfunction

function! ht#collection#lsp#show_documentation()
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

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction

function! s:context_menu() abort
  let content = [
        \   [ "Goto &Definition", 'call feedkeys("\<Plug>(coc-definition)")' ],
        \   [ "Goto T&ype Definition", 'call feedkeys("\<Plug>(coc-type-definition)")' ],
        \   [ "Goto &Implementation", 'call feedkeys("\<Plug>(coc-implementation)")' ],
        \   [ "Goto &References", 'call feedkeys("\<Plug>(coc-references)")' ],
        \   ['-'],
        \   [ "Help &Keyword", 'call ht#collection#lsp#show_documentation()' ],
        \ ]
  call ht#quickui#append_context_menu(content, 'cpp')
endfunction


