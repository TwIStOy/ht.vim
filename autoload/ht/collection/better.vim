function! ht#collection#better#entry_point() abort
  call s:config()

  MyPlug 'tpope/vim-surround'
  MyPlug 'tpope/vim-repeat'

  MyPlug 'Yggdroot/LeaderF', { 'build': './install.sh', }

  MyPlug 'tenfyzhong/axring.vim'
  MyPlug 'Yggdroot/indentLine', { 'on_ft': ['python'] }
  MyPlug 'godlygeek/tabular', { 'on_cmd': 'Tabularize' }
  MyPlug 'junegunn/vim-easy-align', { 'on_cmd': ['<Plug>(EasyAlign)', 'EsayAlign'] }
  MyPlug 'kristijanhusak/defx-icons', { 'on_source': ['defx.nvim'] }
  MyPlug 'tpope/vim-fugitive'

  MyPlug 'itchyny/lightline.vim'
  MyPlug 'mengelbrecht/lightline-bufferline'
  MyPlug 'matze/vim-move'
  MyPlug 'farmergreg/vim-lastplace'
  MyPlug 'tomtom/tcomment_vim'
  MyPlug 'aperezdc/vim-template'
  MyPlug 'SirVer/ultisnips'

  " TODO(hawtian): maybe lazy load
  MyPlug 'RRethy/vim-illuminate'
  MyPlug 'andymass/vim-matchup'
endfunction

function! s:config() abort
  " enable vim-surround default keybindings {{{
  let g:surround_no_mappings = 0
  let g:surround_no_insert_mappings = 1
  " }}}

  " leaderf settings {{{
  let g:Lf_FollowLinks = 1
  let g:Lf_WildIgnore = {
        \   'dir': [ '.git', '.svn', '.hg' ],
        \   'file': [
        \     '*.exe', '*.o', '*.a', '*.so', '*.py[co]',
        \     '*.sw?', '*.bak', '*.d', '*.idx',
        \   ]
        \ }

  let g:Lf_ShortcutF = '<Leader>ff'
  let g:Lf_ShortcutB = '<Leader>ffb'
  let g:Lf_WindowPosition = 'popup'
  let g:Lf_RecurseSubmodules = 1

  let g:Lf_HideHelp = 1
  let g:Lf_UseVersionControlTool = 0
  let g:Lf_DefaultExternalTool = ''
  let g:Lf_WorkingDirectoryMode = 'ac'
  let g:Lf_PopupPosition = [1, 0]

  let g:Lf_PopupWidth = &columns * 3 / 4
  let g:Lf_PopupHeight = float2nr(&lines * 0.6)
  let g:Lf_PopupShowStatusline = 0
  let g:Lf_PreviewInPopup = 1
  let g:Lf_PopupPreviewPosition = 'bottom'

  let g:Lf_RememberLastSearch = 0
  " }}}

  CategoryName 'b', '+buffer'
  CategoryName 'r', '+rg'

  " key mappings {{{
  NShortcut 'e', ':Leaderf file<CR>', 'edit[ pwd ]'
  NShortcut 'ff', ':Leaderf file ~<CR>', 'edit[ $HOME ]'
  NShortcut 'fr', ':LeaderfMru<CR>', 'edit-recent-file'
  NShortcut 'bb', ':LeaderfBuffer<CR>', 'buffer-list'
  NShortcut 'rg', ':LeaderfRgInteractive<CR>', 'rg'

  NShortcut 'rr', ':LeaderfRgRecall<CR>', 'rr'

  Shortcut 'xmap', 'ta', ':EasyAlign<CR>', 'easy-align'
  Shortcut 'nmap', 'ta', ':EasyAlign<CR>', 'easy-align'
  " }}}

  set showtabline=2
  set guioptions-=e
  set laststatus=2

  " disable --INSERT-- mode show
  set noshowmode

  let g:defx_icons_enable_syntax_highlight = 1
  let g:defx_icons_column_length = 2
  call add(g:ht_defx_parameters, '-columns=icons:indent:filename:type')

  let g:lightline = {
        \ 'active': {
        \   'left':[ [ 'mode', 'paste' ],
        \            ['gitbranch', 'readonly', 'filename', 'modified' ] ],
        \   'right': [ ['lineinfo'], ['filetype', 'fileencoding', 'percent'] ],
        \ },
        \ 'component': {
        \   'lineinfo': ' %3l:%-2v',
        \ },
        \ 'component_function': {
        \   'gitbranch': 'fugitive#head',
        \ }
        \ }
  let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
  let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
  let g:lightline.component_type   = {'buffers': 'tabsel'}
  let g:lightline.separator = { 'left': '', 'right': '' }
  let g:lightline.subseparator = { 'left': '', 'right': '' }
  autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

  let g:move_key_modifier = 'C'

  " vim-illuminate {{{
  let g:Illuminate_delay = 200
  let g:Illuminate_ftblacklist = ['nerdtree', 'defx', 'quickfix']
  " }}}

  " vim-template {{{
  let g:templates_directory = [ $HOME . '/.ht/vim-templates' ]
  let g:templates_no_autocmd = 0
  let g:templates_debug = 0
  let g:templates_no_builtin_templates = 1
  let g:templates_user_variables = [
        \   [ 'GIT_USER',  'ht#collection#better#git_user' ],
        \   [ 'GIT_EMAIL', 'ht#collection#better#git_email' ],
        \ ]
  " }}}

  augroup BetterLeaderf
    autocmd!
    autocmd User LeaderfNeeded if dein#is_sourced('LeaderF')
                            \|   call dein#source('LeaderF')
                            \| endif
  augroup END
endfunction

function! ht#collection#better#git_user() abort
  return trim(system('git config --get user.name'))
endfunction

function! ht#collection#better#git_email() abort
  return trim(system('git config --get user.email'))
endfunction

