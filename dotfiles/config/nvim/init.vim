" .vimrc - Alberto Martinez de Murga <alberto@threkk.com>

" Global variables {{{
let g:is_nvim = has('nvim')
let g:is_vim = !has('nvim')

let g:has_ack = executable('ack') || executable('ag')
let g:has_git = executable('git')

let g:python_path = has('python3') ? exepath('python3') : exepath('python')
" }}}

" Plugin installation {{{:
" Lazy loading {{{
"
" From https://github.com/junegunn/vim-plug/wiki/faq#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction
" }}}

if g:is_vim
    let $BASE = '$HOME/.vim'
else
    let $BASE = stdpath('config')
endif

call plug#begin($BASE.'/plugged')

  " Basic configuration for client specifics {{{
  Plug 'tpope/vim-sensible', Cond(g:is_vim)               " Basic conf.
  Plug 'wincent/terminus'                                 " Improves term sup.
  Plug 'equalsraf/neovim-gui-shim', Cond(g:is_nvim)       " Shims for UI config.
  " }}}

  " File tree menu {{{
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " File tree.
  Plug 'Xuyuanp/nerdtree-git-plugin'                      " Git support.
  " }}}

  " Lightline {{{
  Plug 'itchyny/lightline.vim'                            " Better statusline.
  Plug 'maximbaz/lightline-ale'                           " ALE integration
  " }}}

  " Brackets {{{
  Plug 'tpope/vim-surround'                               " Brackets operations.
  Plug 'luochen1990/rainbow'                              " Brackets color.
  Plug 'cohama/lexima.vim'                                " Moving around.
  " }}}

  " Git {{{
  Plug 'tpope/vim-fugitive',     Cond(g:has_git)          " Git basic commands.
  Plug 'airblade/vim-gitgutter', Cond(g:has_git)          " Git Diff.
  " }}}

  " Comments {{{
  Plug 'tpope/vim-commentary'
  " }}}

  " Search {{{
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim', Cond(g:has_ack)                    " ACK.
  " }}}

  " Text edition {{{
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  " }}}

  " Other {{{
  Plug 'godlygeek/tabular'                              " Aligns stuff.
  Plug 'terryma/vim-multiple-cursors'                   " Mutiple cursors.
  Plug 'bagrat/vim-workspace'                           " Tab appeareance
  Plug 'roxma/vim-paste-easy'                           " Fixes pasting.
  Plug 'ryanoasis/vim-devicons'                         " Dev icons.
  Plug 'tpope/vim-sleuth'                               " Set tabs and spaces.
  Plug 'gorodinskiy/vim-coloresque'                     " Colours preview.
  Plug 'vim-scripts/ReplaceWithRegister'                " Replaces the current selection with a register.
  Plug 'easymotion/vim-easymotion'                      " Move around the place
  " }}}

  " Languages {{{
  Plug 'sheerun/vim-polyglot'                           " Syntax colouring
  Plug 'tweekmonster/braceless.vim'                     " Indicates the block line.
  Plug 'prabirshrestha/asyncomplete.vim'                " Autocomplete engine.
  Plug 'prabirshrestha/async.vim'                       " Shim for the LSP.
  Plug 'prabirshrestha/vim-lsp'                         " LSP.
  Plug 'prabirshrestha/asyncomplete-lsp.vim'            " LSP integration.
  Plug 'mattn/vim-lsp-settings'                         " LSP configuration.
  Plug 'prabirshrestha/asyncomplete-file.vim'           " File completion
  Plug 'prettier/vim-prettier', { 'do': 'npm install' } " Prettier plugin.
  Plug 'liuchengxu/vista.vim'                           " Symbols
  Plug 'dense-analysis/ale'                             " Diagnostics.
  " }}}

  " Themes {{{
  Plug 'altercation/vim-colors-solarized'
  Plug '29decibel/codeschool-vim-theme'
  Plug 'trusktr/seti.vim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'reedes/vim-colors-pencil'
  Plug 'jacoborus/tender'
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'kkpmw/sacredforest-vim'
  Plug 'ajh17/Spacegray.vim'
  Plug $BASE.'/unmanaged/night-sky-themer'
  Plug 'chriskempson/base16-vim'  " https://github.com/chriskempson/base16
  " }}}

call plug#end()
" }}}

" Vim configuration {{{

" General {{{
syntax enable                   " Enables syntax processing.
filetype plugin on              " Enables plugin detection.
filetype plugin indent on       " Load filetype-specific indent files.
set modelines=1                 " Enables custom configurations per file.
set history=700                 " Size of the command history.
set hidden                      " Hides not active buffers.
set noerrorbells                " Doesn't display the error bells.
set encoding=utf8               " Sets the encoding to UTF-8.
set termencoding=utf-8          " Sets the terminal encoding to UTF-8.
set mouse=a                     " Enables the mouse in old terminals.
set backspace=eol,start,indent  " Makes backspace work as expected in old terminals.
set nocompatible                " Disables vi compatibility.
set ttyfast                     " Indicates a fast terminal.
set updatetime=300              " Smaller update times.
set scrolloff=5                 " Show a few lines of context.
set fileformats=unix,mac,dos    " Handle all line endings, but prefer unix.
set inccommand=nosplit          " Preview of the search.
" set clipboard+=unnamedplus    " Use the system clipboard.
" }}}

" UI {{{
set title                       " Sets the title of the window.
set number                      " Show line numbers.
set showcmd                     " Show the executed command in the bottom bar.
set wildmenu                    " Visual autocomplete for command menu
set cursorline                  " Highlights the current line.
set ruler                       " Shows the column and line of the cursor.
set noshowmode                  " Hides the current mode.
set cmdheight=2                 " Command line height.
set shortmess+=c                " Don't give |ins-completion-menu| messages.
set signcolumn=yes              " Always show signcolumns.
set textwidth=80                " Maximum line width.
" Don't set columns, let the terminal do it.
set colorcolumn=81              " Draws a vertical line at the selected column.

" Line wrap {{{
set wrap                        " Lines longer than the width will wrap and continue on the next line.
set linebreak                   " Smart wrapping instead of the last character.
" }}}

" Tabs {{{
set tabstop=4                   " Number of visual spaces per TAB.
set softtabstop=4               " Number of spaces in tab when editing.
set expandtab                   " Tabs are spaces.
set smarttab                    " Inserts as many spaces as needed to tab.
set nolist                      " Hides non visual chars (tabs, break lines...)
set lcs=tab:>.,trail:.          " ...but only tabs and trailing whitespace
" }}}

" Indent {{{
set ai                          " Copy the indent when starting a new line.
set si                          " Enables smart indent.
set shiftround                  " Round indent to multiple of (auto) indent.
set shiftwidth=0                " Number of spaces to use for each step of (auto)indent.
" }}}

" Search {{{
set hlsearch                    " Highlight matches.
set incsearch                   " Search as characters are entered.
set ignorecase                  " Makes the patterns no case-sensitive
set smartcase                   " unless it contains an uppercase.
" }}}

" Folding {{{
set foldenable                  " Enables folding.
set foldlevelstart=4            " Sets the initial level of deepness.
set foldnestmax=10              " Limits the level of deepness.
set foldmethod=syntax           " Folding based on syntax.
" }}}

set fillchars+=stl:\ ,stlnc:\   " Characters to fill the statuslines and vertical separators.

" Backup {{{
set backup
set writebackup
set backupdir=$HOME/.config/vim-tmp,/tmp,/private/tmp   " Directories for backups.
set backupskip=/tmp/*,/private/tmp/*                    " Don't create backups for these folders.
set directory=$HOME/.config/vim-tmp,/tmp,/private/tmp   " Directories for swapfiles.
" }}}

" Undo {{{
set undodir=$HOME/.config/vim-undo,/tmp,/private/tmp    " Directories for undo.
set undofile
"}}}

" Autocomplete {{{
" Enables autocomplete.

" Shows the longest autcomplete.
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone
set completeopt+=preview

" Makes ENTER select the pop up menu.
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Selects the first options by default.
inoremap <silent> <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <silent> <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Enables tab for selecting the options.
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-y>" : "\<cr>"

" Closes the menu once an option has been selected.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}

" nvim terminal {{{
if g:is_nvim
  autocmd TermOpen * startinsert
  autocmd TermEnter * set nonumber
  autocmd TermLeave * set number
  tnoremap <Esc> <C-\><C-n>
  " Fix for FZF https://old.reddit.com/r/neovim/comments/gkd86x/fzf_behavior_in_neovim_vs_vim/fqqfk9l/
  autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
  command Tsplit split term://$SHELL
  command Tvsplit vsplit term://$SHELL
  command Ttabedit tabedit term://$SHELL
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
endif
" }}}

" Themes and colours {{{
set t_Co=256                    " Number of colours.
set background=dark             " Chooses the dark version of the colourscheme.
set termguicolors
let base16colorspace=256
colorscheme base16-outrun-dark  " Chooses the colour scheme.
" }}}

" Functions {{{
" Trim white spaces {{{
function! RemoveWS()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Clear trailing whitespace
    %s/\s\+$//e
    "Restore saved cursor & search.
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
" }}}

" Mappings {{{
" Leader
let mapleader=';'

" Turns off the search highlight.
map <leader>/ :nohlsearch<CR>

" Enable folding with the spacebar
nnoremap <space> za

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Move to beginning/end of line
nnoremap <C-a> ^
nnoremap <C-e> $
" Makes yanking consistent.
nnoremap Y y$
" Disables ex mode
map Q <Nop>

" Make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" Make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" System copy-paste
vnoremap <C-x> "+d
vnoremap <C-c> "+y
inoremap <C-v> <ESC>"+pa

" Undo and redo mapped to C-Z.
nnoremap <C-y> <C-r>
nnoremap <C-z> u

" Tabs {{{
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>

map! <C-Tab> <C-O>:tabnext<CR>
map! <C-S-Tab> <C-O>:tabprev<CR>

" Switch to specific tab numbers with number
nmap <leader>1 :tabn 1<CR>
nmap <leader>2 :tabn 2<CR>
nmap <leader>3 :tabn 3<CR>
nmap <leader>4 :tabn 4<CR>
nmap <leader>5 :tabn 5<CR>
nmap <leader>6 :tabn 6<CR>
nmap <leader>7 :tabn 7<CR>
nmap <leader>8 :tabn 8<CR>
nmap <leader>9 :tabn 9<CR>
" Control-0 goes to the last tab
nmap <leader>0 :tablast<CR>

" Open and close tabs.
map <C-T> :tabnew<CR>
map! <C-T> <C-O>:tabnew<CR>

map <C-W> :tabc<CR>
map! <C-W> <C-O>:tabc<CR>
"}}}

" Lane swapping {{{
map <C-j> :m .+1<CR>==
map <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
" }}}

"Pane navigation {{{
nmap <silent> <leader><Up> :wincmd k<CR>
nmap <silent> <leader><Down> :wincmd j<CR>
nmap <silent> <leader><Left> :wincmd h<CR>
nmap <silent> <leader><Right> :wincmd l<CR>

nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>l :wincmd l<CR>

map <leader>d :vs<CR>
map <leader>D :split<CR>
" }}}

" Plugins {{{

" Searches a file.
map <leader>f :Files<CR>
" Searches a buffer
map <leader>F :Buffers<CR>

" Searches a line.
map <leader>p :Lines<CR>
" Opens the silver searcher.
map <leader>P :Ag<CR>

" Searches on the Git files.
map <leader>s :GFiles<CR>
" Searches on the Git Status.
map <leader>S :GFiles?<CR>

" Opens NERDTree.
map <leader>t :NERDTreeToggle<CR>

" Outline
" map <leader>o <Plug>(lsp-document-symbol)
map <silent> <leader>o :Vista!!<CR>
map <silent> <leader>O :Vista finder fzf:vim_lsp<CR>
" }}}

" Plugins {{{
" fzf {{{
" Customize fzf colors to match the color scheme.
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Adds preview to the Files and Ag commands.
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

let g:fzf_colors =
      \ { 'fg':    ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
" }}}

" NerdTree Git {{{
let g:NERDTreeIndicatorMapCustom = {
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
" }}}

" Rainbow parenthesis {{{
let g:rainbow_active = 1

autocmd BufNewFile,BufRead :normal RainbowToggle<CR>
autocmd BufNewFile,BufRead :insert <C-O>:RainbowToggle<CR>i
" }}}

" vim-sleuth {{{
autocmd BufReadPre,FileReadPre * :Sleuth
" }}}

" ACK.vim {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" }}}

" vim-paste-easy {{{
let g:paste_easy_message=0
" }}}

" GOYO {{{
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" }}}
"}}}

" Lightline {{{
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ],
      \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \   'component_expand': {
      \     'linter_checking': 'lightline#ale#checking',
      \     'linter_infos': 'lightline#ale#infos',
      \     'linter_warnings': 'lightline#ale#warnings',
      \     'linter_errors': 'lightline#ale#errors',
      \     'linter_ok': 'lightline#ale#ok',
      \   },
      \   'component_type': {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \   },
      \ }

" asynccomplete-lsp {{{
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'whitelist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
endfunction

let g:lsp_highlight_references_enabled = 1  " Highlight references.
let g:lsp_virtual_text_enabled = 0          " Disabled linter on the same line.
let g:lsp_signs_enabled = 1                 " Enable signs.
let g:lsp_diagnostics_echo_cursor = 1       " Enable echo under cursor when in normal mode
let g:lsp_preview_autoclose = 1
let g:vista_default_executive = 'vim_lsp'   " Set Vista to use vim-lsp
let g:lsp_diagnostics_enabled = 0           " Disable diagnostics support

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" }}}

" ALE {{{
" We need to keep it enabled for the TS Server linter.
" let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'go': ['gofmt', 'goimports'],
\   'javascript': ['prettier'],
\   'perl': ['perltidy'],
\   'python': ['black'],
\   'typescript': ['prettier'],
\   'vue': ['prettier'],
\}

let g:ale_linters = {
\   'go': ['gopls', 'gofmt' ,'golint', 'govet'],
\   'javascript': ['eslint','tsserver'],
\   'perl': ['perl', 'perlcritic'],
\   'python': ['pyls','flake8', 'mypy', 'pylint'],
\   'typescript': ['eslint','tsserver'],
\   'vue': ['eslint', 'vls'],
\}

" }}}
" Language bindings {{{
imap <c-space> <Plug>(asyncomplete_force_refresh)

" Remap keys for gotos
nmap <silent> <leader>gd <Plug>(lsp-definition)
nmap <silent> <leader>gt <Plug>(lsp-type-definition)
nmap <silent> <leader>gi <Plug>(lsp-implementation)
nmap <silent> <leader>gr <Plug>(lsp-references)

" Checks the errors
nmap <silent> <leader>ge <Plug>(ale_lint)
nmap <silent> <leader>gf <Plug>(ale_fix)
nmap <silent> <leader>gk <Plug>(ale_previous_wrap)
nmap <silent> <leader>gj <Plug>(ale_next_wrap)

" Other actions.
nmap <silent> K <Plug>(lsp-hover)
nmap <leader>r <Plug>(lsp-rename)
nmap <leader>ga  <Plug>(lsp-codeaction)

" Python {{{
source $BASE/python.vim
" }}}

" JavaScript/TypeScript {{{
source $BASE/javascript.vim
" }}}

" Go {{{
source $BASE/golang.vim
" }}}

" Perl {{{
source $BASE/perl.vim
" }}}

" Other {{{
source $BASE/other.vim
" }}}

"vim:foldmethod=marker:foldlevel=0
