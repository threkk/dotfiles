" CtrlP for vim
map <silent> <leader>b :CtrlPBuffer<CR>
map <silent> <leader>f :CtrlPCurWD<CR>
map <silent> <leader>p :CtrlP<CR>

map <silent> <C-o> :CtrlPCurWD<CR>
map! <silent> <C-o> <ESC>:CtrlPCurWD<CR>

" Terminal
if has('terminal')
  map <silent> <C-G> :tab term<CR>
  map! <silent> <C-G> <ESC>:tab term<CR>
endif

" Different backup folders
set backupdir=$HOME/.config/vim-tmp,/tmp/vim-tmp,/private/tmp/vim-tmp    " Directories for backups.
set backupskip=/tmp/vim-tmp/*,/private/tmp/vim-tmp/*                     " Don't create backups for these folders.
set directory=$HOME/.config/vim-tmp,/tmp/vim-tmp,/private/tmp/vim-tmp    " Directories for swapfiles.
set undodir=$HOME/.config/vim-undo,/tmp/vim-undo,/private/tmp/vim-undo   " Directories for undo.

autocmd BufReadPre BracelessEnable +indent +fold +highlight
