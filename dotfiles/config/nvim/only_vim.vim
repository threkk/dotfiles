" CtrlP for vim
let g:ctrlp_map = '<leader>p'
map <silent> <leader>b :CtrlPBuffer<CR>
map <silent> <leader>f :CtrlPCurWD<CR>

autocmd BufReadPre BracelessEnable +indent +fold +highlight
