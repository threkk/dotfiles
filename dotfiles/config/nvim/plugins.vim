" Nuake
if has('nvim') || has('terminal')
  map <silent> <C-,> :Nuake<CR>
  map! <silent> <C-,> <Esc>:Nuake<CR>
  tmap <silent> <C-,> <C-\><C-n>:Nuake<CR>
endif

" vim-paste-easy
let g:paste_easy_message=0

" vim-sleuth
autocmd BufRead,FileReadPost * :Sleuth

" Rainbow parenthesis
let g:rainbow_active = 1

" vim-one
let g:one_allow_italics = 1

" base 16
let base16colorspace=256

" OSC Yank
set clipboard& clipboard^=unnamed,unnamedplus
let g:oscyank_silent = v:true
vnoremap <silent> <C-c> :OSCYankVisual<CR>
