" CtrlP for vim
let g:ctrlp_map = '<leader>p'
map <silent> <leader>b :CtrlPBuffer<CR>
map <silent> <leader>f :CtrlPCurWD<CR>

" Terminal
map <silent> <C-G> :tab term<CR>
map! <silent> <C-G> <ESC>:tab term<CR>

autocmd BufReadPre BracelessEnable +indent +fold +highlight
