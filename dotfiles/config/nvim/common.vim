" General
syntax enable                        " Enables syntax processing.
filetype plugin on                   " Enables plugin detection.
filetype plugin indent on            " Load filetype-specific indent files.
set modelines=1                      " Enables custom configurations per file.
set history=700                      " Size of the command history.
set hidden                           " Hides not active buffers.
set visualbell                       " Uses a visual bell instead of the sound.
set noerrorbells                     " Doesn't display the error bells.
set encoding=utf8                    " Sets the encoding to UTF-8.
set mouse=a                          " Enables the mouse in old terminals.
set backspace=eol,start,indent       " Makes backspace work as expected in old terminals.
set nocompatible                     " Disables vi compatibility.
set ttyfast                          " Indicates a fast terminal.
set updatetime=300                   " Smaller update times.
set scrolloff=5                      " Show a few lines of context.
set fileformats=unix,mac,dos         " Handle all line endings, but prefer unix.
set omnifunc=syntaxcomplete#Complete " Enables autocomplete
" set digraph                        " Enables input of special characters.
" set clipboard+=unnamedplus         " Use the system clipboard.

" UI
set title                       " Sets the title of the window.
set splitkeep=screen            " Keep the same screen lines in all splits
set number                      " Show line numbers.
set showcmd                     " Show the executed command in the bottom bar.
set wildmenu                    " Visual autocomplete for command menu
set list                        " Display whitespaces
set cursorline                  " Highlights the current line.
set ruler                       " Shows the column and line of the cursor.
set noshowmode                  " Hides the current mode.
set cmdheight=2                 " Command line height.
set shortmess+=c                " Don't give |ins-completion-menu| messages.
set signcolumn=yes              " Always show signcolumns.
set textwidth=0                 " Maximum line width (disabled).
set colorcolumn=81              " Draws a vertical line at the selected column.
                                " Don't set columns, let the terminal do it.

" Line wrap
set wrap                        " Lines longer than the width will wrap and continue on the next line.
set linebreak                   " Smart wrapping instead of the last character.
set whichwrap=<,>,[,],b         " When a line finishes, another starts.

" Tabs
set tabstop=4                   " Number of visual spaces per TAB.
set softtabstop=4               " Number of spaces in tab when editing.
set expandtab                   " Tabs are spaces.
set smarttab                    " Inserts as many spaces as needed to tab.
set lcs=tab:>.,trail:.          " ...but only tabs and trailing whitespace

" Indent
set ai                          " Copy the indent when starting a new line.
set si                          " Enables smart indent.
set shiftround                  " Round indent to multiple of (auto) indent.
set shiftwidth=0                " Number of spaces to use for each step of (auto)indent.

" Search
set hlsearch                    " Highlight matches.
set incsearch                   " Search as characters are entered.
set ignorecase                  " Makes the patterns no case-sensitive
set smartcase                   " unless it contains an uppercase.

" Folding
set nofoldenable                " Disables folding

set fillchars+=stl:\ ,stlnc:\   " Characters to fill the statuslines and vertical separators.

" Backup
set backup
set writebackup
set undofile
set backupdir=$HOME/.cache/nvim-tmp/backup,/tmp/nvim-tmp/backup " Directories for backups.
set directory=$HOME/.cache/nvim-tmp/swap,/tmp/nvim-tmp/swap     " Directories for swapfiles.
set undodir=$HOME/.cache/nvim-tmp/undo,/tmp/nvim-tmp/undo       " Directories for undo.
set backupskip=$HOME/.cache/,node_modules,.git,/tmp             " Don't create backups for these folders.

" Themes and colours
set termguicolors
set t_Co=256                    " Number of colours.
set background=dark             " Chooses the dark version of the colourscheme.
colorscheme one                 " Chooses the colour scheme.

" Shows the longest autcomplete.
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" "set completeopt=longest,menuone,preview

" Makes ENTER select the pop up menu.
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Selects the first options by default.
" inoremap <silent> <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <silent> <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Enables tab for selecting the options if the menu is open.
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" Shift tab deletes a tab in insert mode.
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Closes the menu once an option has been selected.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Leader
let mapleader=';'

" Move vertically by visual line
nnoremap <silent> j gj
nnoremap <silent> k gk

" Center VIM searches
noremap n nzz
noremap N Nzz

" Y should behave like D and C
noremap Y y$

" Select all
map <silent> <C-a> <esc>ggVG<CR>

" Save
map <silent> <C-s> <esc>:w<CR>

" Disables ex mode
map Q <Nop>

" I am tired of :W when I want to write.
nnoremap W w


" Make tab in v mode indent code
vmap <tab> >gv
vmap <s-tab> <gv

" Make tab in normal mode indent code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" System copy-paste (from mswin.vim)
vnoremap <silent> <C-x> "+x
vnoremap <silent> <C-c> "+y
map      <silent> <C-v> "+gP
map!     <silent> <C-v> <esc>"+gP<esc>i
inoremap <silent> <C-v> <ESC>"+pa

" Paste does not copy
xnoremap <silent> p "_dP

" Undo and redo mapped to C-z/C-y
map <silent> <C-y> <C-r>
map! <silent> <C-y> <esc><C-r>i
map <silent> <C-z> u
map! <silent> <C-z> <esc>ui

" ctrl+s saves the current buffer
map <C-s> :update<CR>
map! <C-s> <esc>:update<CR><esc>i

" Tabs
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>
map! <C-Tab> <Esc>:tabnext<CR>
map! <C-S-Tab> <Esc>:tabprev<CR>

" Switch to specific tab numbers with number
nmap <silent> <leader>1 :tabn 1<CR>
nmap <silent> <leader>2 :tabn 2<CR>
nmap <silent> <leader>3 :tabn 3<CR>
nmap <silent> <leader>4 :tabn 4<CR>
nmap <silent> <leader>5 :tabn 5<CR>
nmap <silent> <leader>6 :tabn 6<CR>
nmap <silent> <leader>7 :tabn 7<CR>
nmap <silent> <leader>8 :tabn 8<CR>

" Leader-9 goes to the last tab
nmap <leader>9 :tablast<CR>

" Open tabs.
map <silent> <C-t> :tabnew<CR>
map! <silent> <C-t> <Esc>:tabnew<CR>

" Close tabs.
map <C-w> :tabc<CR>
map! <C-w> <Esc>:tabc<CR>

" Terminal
tnoremap <esc>; <C-\><C-n>
command Tsplit split term://$SHELL
command Tvsplit vsplit term://$SHELL
command Ttabedit tabedit term://$SHELL

let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

if has('nvim')
  autocmd TermOpen * startinsert
  autocmd TermOpen * set nonumber
  autocmd TermClose * set number
endif

" Lane swapping
map <A-j> :m .+1<CR>==
map <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

map <A-Down> :m .+1<CR>==
map <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

"Pane navigation
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>l :wincmd l<CR>

" Split screen
map <leader>d :vs<CR>
map <leader>D :split<CR>

" Easier mappings for completion
" Omni
inoremap <C-space> <C-x><C-o>
" Buffers
inoremap <C-b> <C-x><C-p>
" Lines
inoremap <C-h> <C-x><C-l>
" Locations
inoremap <C-l> <C-x><C-f>
