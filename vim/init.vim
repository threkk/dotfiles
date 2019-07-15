" .vimrc - Alberto Martinez de Murga <alberto@threkk.com>
"
" Requirements:
" - FZF
" - Ack/AG
" - CTags & jsctags.
" - Git

" Global variables {{{
let g:is_nvim = has('nvim')
let g:is_vim = !has('nvim')
let g:is_gui = has('gui_macvim') || has('gui_vimr')

let g:has_ack = executable('ack')
let g:has_ag = executable('ag')
let g:has_ctags = executable('ctags')
let g:has_fzf = executable('fzf')
let g:has_git = executable('git')

let g:python3_path = has('python3') ? exepath('python3') : exepath('python')
let g:python2_path = exepath('python2')

if !g:has_ack && !g:has_ag
    echom 'Neither AG or ACK are installed in the system.'
endif

if !g:has_fzf
    echom 'FZF is not installed in the system.'
endif

if !g:has_git
    echom 'Git is not installed in the system.'
endif

if !g:has_ctags
    echom 'CTags is not installed in the system.'
endif
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

call plug#begin('~/.vim/plugged')

  " Basic configuration for client specifics {{{
  Plug 'tpope/vim-sensible', Cond(g:is_vim)               " Basic conf.
  Plug 'wincent/terminus',   Cond(!g:is_gui)              " Improves term sup.
  Plug 'equalsraf/neovim-gui-shim', Cond(g:is_nvim)       " Shims for UI config.
  " }}}

  " File tree menu {{{
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " File tree.
  Plug 'Xuyuanp/nerdtree-git-plugin'                      " Git support.
  " }}}

  " Airline {{{
  Plug 'itchyny/lightline.vim'                              " Better statusline.
  " }}}

  " Brackets {{{
  Plug 'tpope/vim-surround'                               " Brackets operations.
  Plug 'raimondi/delimitmate'                             " Close parenthesis.
  Plug 'luochen1990/rainbow'                              " Brackets color.
  " }}}

  " Git {{{
  Plug 'tpope/vim-fugitive',     Cond(g:has_git)          " Git basic commands.
  Plug 'airblade/vim-gitgutter', Cond(g:has_git)          " Git Diff.
  " }}}

  " TMUX {{{
  Plug 'benmills/vimux'
  " }}}

  " SLIME {{{
  Plug 'jpalardy/vim-slime'
  " }}}

  " Outline {{{
  Plug 'majutsushi/tagbar', Cond(g:has_ctags)             " Outline tags.
  " }}}

  " Commentaries {{{
  Plug 'tpope/vim-commentary'
  " }}}

  " FZF {{{
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  Plug 'junegunn/fzf.vim', Cond(g:has_fzf)
  " }}}

  " ACK {{{
  let no_ack = g:has_ack || g:has_ag
  Plug 'mileszs/ack.vim', Cond(no_ack)                    " ACK.
  " }}}

  " Text edition {{{
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  " }}}

  " Other {{{
  Plug 'godlygeek/tabular'                                " Aligns stuff.
  Plug 'skywind3000/asyncrun.vim'                         " Async requests.
  Plug 'terryma/vim-multiple-cursors'                     " Mutiple cursors.
  Plug 'sjl/gundo.vim'                                    " Displays the undo tree.
  Plug 'bagrat/vim-workspace'                             " Tab appeareance
  Plug 'roxma/vim-paste-easy'                             " Fixes pasting.
  Plug 'ryanoasis/vim-devicons'                           " Dev icons.
  " }}}

  " Themes {{{
  Plug 'altercation/vim-colors-solarized'
  Plug 'jpo/vim-railscasts-theme'
  Plug '29decibel/codeschool-vim-theme'
  Plug 'endel/vim-github-colorscheme'
  Plug 'trusktr/seti.vim'
  Plug 'blueshirts/darcula'
  Plug 'reedes/vim-colors-pencil'
  Plug 'jacoborus/tender'
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'kkpmw/sacredforest-vim'
  Plug 'ajh17/Spacegray.vim'
  " }}}

  " Languages {{{
  " Language server {{{
  " yarn global add vim-node-rpc if Vim. 
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
  Plug 'sheerun/vim-polyglot'
  " }}}

  " Python {{{
  Plug 'tweekmonster/braceless.vim'
  " }}}

  " Go {{{
  " Plug 'fatih/vim-go',                          {'for': 'go'}
  " Plug 'jodosha/vim-godebug',                   {'for': 'go'}
  " }}}

  " Web design {{{
  Plug 'gorodinskiy/vim-coloresque'     " Colours preview.
  " }}}

  " Markdown {{{
  Plug 'godlygeek/tabular'
  Plug 'junegunn/goyo.vim'
  " }}}

  " Others {{{
  Plug 'chrisbra/csv.vim',              {'for': 'csv'}
  Plug 'm-kat/aws-vim'
  " }}}
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

" Configures Python for NVIM
if g:is_nvim
  let g:python_host_prog = g:python2_path
  let g:python3_host_prog = g:python3_path 
  set clipboard+=unnamedplus
  set inccommand=nosplit
endif
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
set columns=80                  " Maximum amount of columns to display.
set textwidth=80                " Maximum line width.
set colorcolumn=81              " Draws a vertical line at the selected column.

" Characters to fill the statuslines and vertical separators.
set fillchars+=stl:\ ,stlnc:\

" Autocomplete {{{
" Enables autocomplete.

" Shows the longest autcomplete.
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone

" Makes ENTER select the pop up menu.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Selects the first options by default.
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Enables tab for selecting the options.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<cr>"

" Closes the menu once an option has been selected.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}

" Themes and colours {{{
set t_Co=256                    " Number of colours.
set background=dark             " Chooses the dark version of the colourscheme.
colorscheme iceberg                " Chooses the colour scheme.

" Tender theme
if (has("termguicolors"))
    set termguicolors
endif

" Nord theme
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_comment_brightness = 20
let g:nord_cursor_line_number_background = 1
" }}}

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
" }}}

" Indent {{{
set ai                          " Copy the indent when starting a new line.
set si                          " Enables smart indent.
set shiftround                  " Round indent to multiple of (auto) indent.
set shiftwidth=4                " Number of spaces to use for each step of (auto)indent.
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

" Backup {{{
set backup
set writebackup
set backupdir=~/.config/vim-tmp,/tmp,/private/tmp   " Directories for backups.
set backupskip=/tmp/*,/private/tmp/*                " Don't create backups for these folders.
set directory=~/.config/vim-tmp,/tmp,/private/tmp   " Directories for swapfiles.
" }}}

" nvim terminal {{{
if g:is_nvim 
  autocmd TermOpen * startinsert
  autocmd TermOpen * set nonumber
  autocmd TermClose * set number
  tnoremap <Esc> <C-\><C-n>
  command Tsplit split term://$SHELL
  command Tvsplit vsplit term://$SHELL
  command Ttabedit tabedit term://$SHELL
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm""	
endif
" }}}

" Tries to set FireCode as font if it is available {{{
" silent! set macligatures
" silent! set guifont=Fura\ Code:h15
" }}}
" }}}

" Functions {{{
" Trim white spaces {{{
function! StripTrailingWS()
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

" Toggle between number and relativenumber {{{
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
" }}}

" Print current date {{{
function! Date()
  put =strftime('%a %d %b %Y')
endfunc
" }}}
" }}}

" Mappings {{{
" Leader
let mapleader=';'

" Turns off the search highlight.
map <leader>/ :nohlsearch<CR>

" Enable folding with the spacebar
nnoremap <space> za

" Trims whitespaces.
map <leader>tt :call StripTrailingWS()<CR>

" Switches between absolute and relative numbers.
map <leader>tn :call ToggleNumber()<CR>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Move to beginning/end of line
nnoremap <C-a> ^
nnoremap <C-e> $

" U to redo. u stays for undo.
nnoremap U <C-r>

map <leader>n :call Date()<CR>

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
" Toggle gundo.vim
map <leader>u :GundoToggle<CR>

" Toggles the bracket colouring.
map <leader>b :RainbowToggle<CR>

" Searches a file.
map <leader>f :Files<CR>

" Searches a command.
map <leader>c :<C-u>CocList commands<CR> 

" Searches a line.
map <leader>p :Lines<CR>

" Searches on Git files.
map <leader>gl :GFiles<CR>

" Searches on the Git Status.
map <leader>gs :GFiles?<CR>

" Opens NERDTree.
map <leader>t :NERDTreeToggle<CR>

" Opens CTags.
" if has_ctags
"   map <leader>o :TagbarToggle<CR>
" endif
map <leader>o :<C-u>CocList outline<CR>

" Opens the silver searcher.
if has_ag
  map <leader>a :Ag<CR>
endif
" }}}

" Tabs {{{

" Press Ctrl-Tab to switch between open tabs (like browser tabs) to
" the right side. Ctrl-Shift-Tab goes the other way.
map <C-Tab> :tabnext<CR>
map <C-S-Tab> :tabprev<CR>

map! <C-Tab> <C-O>:tabnext<CR>
map! <C-S-Tab> <C-O>:tabprev<CR>

if g:is_gui
  " Switch to specific tab numbers with Command-number
  map <D-1> :tabn 1<CR>
  map <D-2> :tabn 2<CR>
  map <D-3> :tabn 3<CR>
  map <D-4> :tabn 4<CR>
  map <D-5> :tabn 5<CR>
  map <D-6> :tabn 6<CR>
  map <D-7> :tabn 7<CR>
  map <D-8> :tabn 8<CR>
  map <D-9> :tabn 9<CR>

  map! <D-1> <C-O>:tabn 1<CR>
  map! <D-2> <C-O>:tabn 2<CR>
  map! <D-3> <C-O>:tabn 3<CR>
  map! <D-4> <C-O>:tabn 4<CR>
  map! <D-5> <C-O>:tabn 5<CR>
  map! <D-6> <C-O>:tabn 6<CR>
  map! <D-7> <C-O>:tabn 7<CR>
  map! <D-8> <C-O>:tabn 8<CR>
  map! <D-9> <C-O>:tabn 9<CR>

  " Command-0 goes to the last tab
  map <D-0> :tablast<CR>
  map! <D-0> <C-O>:tablast<CR>
else
  " Switch to specific tab numbers with number
  nmap 1 :tabn 1<CR>
  nmap 2 :tabn 2<CR>
  nmap 3 :tabn 3<CR>
  nmap 4 :tabn 4<CR>
  nmap 5 :tabn 5<CR>
  nmap 6 :tabn 6<CR>
  nmap 7 :tabn 7<CR>
  nmap 8 :tabn 8<CR>
  nmap 9 :tabn 9<CR>

  " Control-0 goes to the last tab
  map 0 :tablast<CR>

  " Open and close tabs.
  map <C-T> :tabnew<CR>
  map! <C-T> <C-O>:tabnew<CR>

  map <C-W> :tabc<CR>
  map! <C-W> <C-O>:tabc<CR>
endif
"}}}

" GUI/TERM especific configuration {{{
" GUI {{{
if g:is_gui
  " Disables the scrollbars {{{
  set guioptions-=r
  set guioptions-=L
  set guioptions-=T
  set guioptions-=m
  " }}}

  " Movement keys {{{
  let macvim_skip_cmd_opt_movement = 1
  no   <D-Left>       <Home>
  no!  <D-Left>       <Home>
  no   <D-Right>      <End>
  no!  <D-Right>      <End>
  no   <M-Left>       <C-Left>
  no!  <M-Left>       <C-Left>
  no   <M-Right>      <C-Right>
  no!  <M-Right>      <C-Right>
  ino  <M-BS>         <C-w>
  ino  <D-BS>         <C-u>
  no   <D-Up>         <C-Home>
  ino  <D-Up>         <C-Home>
  no   <D-Down>       <C-End>
  ino  <D-Down>       <C-End>
  " }}}

  " Lane swapping {{{
  map <M-Down> :m .+1<CR>==
  map <M-Up> :m .-2<CR>==
  map! <M-Down> <Esc>:m .+1<CR>==gi
  map! <M-Up> <Esc>:m .-2<CR>==gi
  " }}}
" }}}
" TERM {{{
else
  " Lane swapping {{{
  map <C-j> :m .+1<CR>==
  map <C-k> :m .-2<CR>==
  inoremap <C-j> <Esc>:m .+1<CR>==gi
  inoremap <C-k> <Esc>:m .-2<CR>==gi
  vnoremap <C-j> :m '>+1<CR>gv=gv
  vnoremap <C-k> :m '<-2<CR>gv=gv
  " }}}
endif
" }}}
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

" Vimux {{{
" Prompt for a command to run
map <Leader>vs :VimuxPromptCommand<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>
" }}}

" SLIME {{{
if g:is_nvim
  let g:slime_target = "neovim"
else
  let g:slime_target = "vimterminal"
endif
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

" vim-markdown {{{
" Adds a TOC
let g:vim_markdown_toc_autofit = 1
" Add syntax highlight.
let g:vim_markdown_fenced_languages = ['python=python', 'go=go', 'javascript=javascript']
" follow anchors
let g:vim_markdown_follow_anchor = 1
" Latex math
let g:vim_markdown_math = 1
" Headers in YAML and JSON.
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" Do not autoclose the preview window.
let g:mkdp_auto_close = 1
" }}}

" Rainbow parenthesis {{{
let g:rainbow_active = 1

autocmd BufNewFile,BufRead :normal RainbowToggle<CR>
autocmd BufNewFile,BufRead :insert <C-O>:RainbowToggle<CR>i
" }}}

" vim-sleuth {{{
" autocmd BufReadPre,FileReadPre * :Sleuth
" }}}

" ACK.vim {{{
if g:has_ag
  let g:ackprg = 'ag --vimgrep'
endif
" }}}

" vim-paste-easy {{{
let g:paste_easy_message=0
" }}}

" DelimitMate {{{
let delimitMate_expand_cr = 1
" }}}

" GOYO {{{
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" }}}

" vim-go {{{
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_types = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
" let g:go_list_type = "quickfix"
" }}}

" jedi-vim {{{
 " let g:jedi#completions_enabled = 0
 
 " let g:jedi#use_splits_not_buffers = 'right'
 " let g:jedi#show_call_signatures = '2'
" }}}

" vim-javascript {{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

set conceallevel=0
" }}}

" vim-jsx {{{
let g:jsx_ext_required = 0
" }}}

" vim-vue {{{
autocmd FileType vue syntax sync fromstart
" }}}
"}}}

" Configuration per filetype {{{
" Cleans trailing whitespaces in python and javascript files before saving {{{
autocmd BufWritePre *.{py,js,jsx,ts,tsx} call StripTrailingWS()
" }}}

" Language bindings {{{
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Checks the errors
map <leader>ge :<C-u>CocList diagnostics<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)
" Remap for format selected region
vmap <leader>gf  <Plug>(coc-format-selected)
nmap <leader>gf  <Plug>(coc-format-selected)

" Remap for code actions
nmap <leader>ga  <Plug>(coc-codeaction)
nmap <leader>gq  <Plug>(coc-fix-current)

" Python {{{
autocmd FileType python,yaml BracelessEnable +indent +fold +highlight
augroup python_folding
    au!
    au FileType python setlocal foldmethod=syntax
    au FileType python set shiftwidth=4
    au FileType python set softtabstop=4
    au FileType python set tabstop=4
augroup END
" }}}

" JavaScript/TypeScript {{{
autocmd BufEnter *.tsx set filetype=typescript.tsx
autocmd BufEnter *.jsx set filetype=javascript.jsx
autocmd FileType json syntax match Comment +\/\/.\+$+
augroup javascript_folding
    au!
    au FileType javascript,typescript,javascript.jsx,typescript.tsx setlocal foldmethod=syntax
    au FileType javascript,typescript,javascript.jsx,typescript.tsx set shiftwidth=2
    au FileType javascript,typescript,javascript.jsx,typescript.tsx set softtabstop=2
    au FileType javascript,typescript,javascript.jsx,typescript.tsx set tabstop=2
augroup END
" }}}

" Bash, Dockerfile {{{
autocmd FileType sh,Dockerfile set textwidth=0
" }}}

" Go {{{
" autocmd FileType go nmap <leader>gr <Plug>(go-run)
" autocmd FileType go nmap <leader>gb <Plug>(go-build)
" autocmd FileType go nmap <leader>gt <Plug>(go-test)
" autocmd FileType go nmap <leader>gc <Plug>(go-coverage)
" autocmd FileType go nmap <leader>gd <Plug>(go-doc)
" autocmd FileType go nmap <leader>gv <Plug>(go-doc-vertical)
" Go bindings
" autocmd FileType go map <leader>k :GoDoc<CR>
" autocmd FileType go map <leader>r :GoRename<CR>
" autocmd FileType go map <leader>ga :GoDef<CR>
" autocmd FileType go map <leader>gu :GoSameIds<CR>
" Go styleguide
autocmd FileType go set noexpandtab
autocmd FileType go set shiftwidth=4
autocmd FileType go set softtabstop=4
autocmd FileType go set tabstop=4
" Extra higlights.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
" Disable go-def
let g:go_def_mapping_enabled = 0
" }}}
" }}}

command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'cocstatus' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

"vim:foldmethod=marker:foldlevel=0
