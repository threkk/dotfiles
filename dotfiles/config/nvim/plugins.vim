" ACK.vim 
if has('rg')
  let g:ackprg = 'rg --vimgrep'
elseif has('ag')
  let g:ackprg = 'ag'
else
  let g:ackprg = 'ack'
endif

" Nuake
map <silent> <C-o> :Nuake<CR>
map! <silent> <C-o> <Esc>:Nuake<CR>
tmap <silent> <C-o> <C-\><C-n>:Nuake<CR>

" NerdTree Git
map <silent> <leader>t :NERDTreeToggle<CR>
let g:NERDTreeGitStatusIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ "Unknown"   : "?"
      \ }

" Vista
let g:vista_default_executive = 'nvim_lsp'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#icons = {
      \   "function": "\uf794",
      \   "variable": "\uf71b",
      \  }

" vim-paste-easy
let g:paste_easy_message=0

" vim-sleuth
autocmd BufReadPre,FileReadPre * :Sleuth

" Rainbow parenthesis
let g:rainbow_active = 1

" Editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" vim-one
let g:one_allow_italics = 1

" base 16
let base16colorspace=256

" Lightline
let g:lightline = {
      \ 'colorscheme': has('nvim') ? 'tokyonight' : 'one',
      \ 'active': {
        \   'left':  [ [ 'mode', 'paste' ],
        \              [ 'gitbranch', 'readonly',  'modified' ],
        \              [ 'filename' ] ],
        \   'right': [ [ 'fileformat', 'fileencoding', 'filetype' ],
        \              [ 'lineinfo', 'percent' ]],
        \ },
        \ 'component_function': {
          \   'gitbranch': 'fugitive#head'
        \ }
     \ }
