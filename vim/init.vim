" .vimrc - Alberto Martinez de Murga <alberto@threkk.com>
"
" Requirements:
" - FZF
" - Ack/AG
" - CTags & jsctags.
" - Git
" - Completion engines: jedi, ternjs, GoCode, phpcd.vim
" - Syntax checkers.

" Global variables {{{
let g:is_nvim = has('nvim')
let g:is_vim = !has('nvim')
let g:is_gui = has('gui_macvim') || has('gui_vimr')

let g:has_ack = executable('ack')
let g:has_ag = executable('ag')
let g:has_ctags = executable('ctags')
let g:has_fzf = executable('fzf')
let g:has_git = executable('git')

let g:brew_path = '/usr/local'
if strlen($BREW_PATH) > 0
  let g:brew_path = $BREW_PATH
endif

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
  Plug 'vim-airline/vim-airline'                          " Better statusline.
  Plug 'vim-airline/vim-airline-themes'                   " Themes for statusline.
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

  " Syntax checker {{{
  "
  " NOTE: It requires to have syntax checkers installed.
  Plug 'scrooloose/syntastic'                             " Syntax checker for vim.
  " }}}

  " Autocomplete {{{
  Plug 'roxma/nvim-yarp', Cond(g:is_vim)                 " Package required for vim compatibility.
  Plug 'roxma/vim-hug-neovim-rpc', Cond(g:is_vim)        " Package required for vim compatibility.
  Plug 'Shougo/deoplete.nvim'                            " Completion engine.
  Plug 'Shougo/neco-syntax'                              " Adds the original omnifunc.
  " }}}

  " Outline {{{
  Plug 'majutsushi/tagbar', Cond(g:has_ctags)             " Outline tags.
  " }}}

  " Commentaries {{{
  Plug 'tpope/vim-commentary'
  " }}}

  " FZF {{{
  Plug g:brew_path.'/opt/fzf'
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

  " Vim-Wiki {{{
  Plug 'vimwiki/vimwiki', { 'branch': 'dev' }             " Wiki
  Plug 'mattn/calendar-vim'                               " Calendar
  Plug 'vimwiki/utils'                                    " Utils
  " }}}

  " Other {{{
  Plug 'godlygeek/tabular'                                " Aligns stuff.
  Plug 'skywind3000/asyncrun.vim'                         " Async requests.
  Plug 'terryma/vim-multiple-cursors'                     " Mutiple cursors.
  Plug 'tpope/vim-sleuth'                                 " Detects the indent.
  Plug 'sjl/gundo.vim'                                    " Displays the undo tree.
  Plug 'bagrat/vim-workspace'                             " Tab appeareance
  Plug 'roxma/vim-paste-easy'                             " Fixes pasting.
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
  " }}}

  " Languages {{{
  " Python {{{
  Plug 'davidhalter/jedi-vim',          {'for': 'python'}
  Plug 'zchee/deoplete-jedi',           {'for': 'python'}
  Plug 'tweekmonster/braceless.vim',    {'for': ['python', 'yaml']}
  " }}}

  " JavaScript {{{
  Plug 'pangloss/vim-javascript',             {'for': ['javascript', 'javascript.jsx']}
  Plug 'mxw/vim-jsx',                         {'for': ['javascript.jsx', 'jsx']}
  Plug 'posva/vim-vue',                       {'for': ['javascript.vue', 'vue']}
  Plug 'elzr/vim-json',                       {'for': ['javascript', 'javascript.jsx', 'json']}
  Plug 'ternjs/tern_for_vim',                 {'for': ['javascript', 'javascript.jsx', 'vue']}
  Plug 'carlitux/deoplete-ternjs',            {'for': ['javascript', 'javascript.jsx', 'vue']}
  " }}}

  " TypeScript {{{
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'mhartington/nvim-typescript'
  " }}}

  " Go {{{
  Plug 'fatih/vim-go',                  {'for': 'go'}
  Plug 'zchee/deoplete-go',             {'for': 'go', 'do': 'make'}
  " }}}

  " PHP {{{
  Plug 'lvht/phpcd.vim',                 {'for': 'php', 'do': 'composer install' }
  Plug 'stanangeloff/php.vim',           {'for': 'php'}
  Plug 'rayburgemeestre/phpfolding.vim', {'for': 'php'}
  Plug '2072/PHP-Indenting-for-VIm',     {'for': 'php'}
  Plug 'hhvm/vim-hack',                  {'for': 'hacklang'}
  " }}}

  " Web design {{{
  Plug 'gorodinskiy/vim-coloresque'     " Colours preview.
  Plug 'othree/html5.vim',              {'for': 'html'}
  " }}}

  " Markdown {{{
  Plug 'godlygeek/tabular'
  Plug 'tpope/vim-markdown'
  " Plug 'nelstrom/vim-markdown-folding'
  Plug 'junegunn/goyo.vim'
  " }}}

  " Others {{{
  Plug 'chrisbra/csv.vim',              {'for': 'csv'}
  Plug 'joonty/vdebug',                 {'for': ['php', 'python', 'javascript', 'perl', 'ruby', 'javascript.jsx']}
  Plug 'lervag/vimtex',                 {'for': 'tex'}
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
set noerrorbells                " Doesn't display the error bells.
set encoding=utf8               " Sets the encoding to UTF-8.
set termencoding=utf-8          " Sets the terminal encoding to UTF-8.
set mouse=a                     " Enables the mouse in old terminals.
set backspace=eol,start,indent  " Makes backspace work as expected in old terminals.
set nocompatible                " Disables vi compatibility.
set ttyfast                     " Indicates a fast terminal.

" Configures Python for NVIM
if g:is_nvim
  let g:python_host_prog = g:brew_path.'/opt/python@2/bin/python2'
  let g:python3_host_prog = g:brew_path.'/bin/python3'
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
set columns=80                  " Maximum amount of columns to display.
set textwidth=80                " Maximum line width.
set colorcolumn=81              " Draws a vertical line at the selected column.

" Characters to fill the statuslines and vertical separators.
set fillchars+=stl:\ ,stlnc:\

" Display the errors in the statusline.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"}}}

" Autocomplete {{{
" Enables autocomplete.
set omnifunc=syntaxcomplete#Complete

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
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Closes the menu once an option has been selected.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}

" Themes and colours {{{
set t_Co=256                    " Number of colours.
set background=dark             " Chooses the dark version of the colourscheme.
colorscheme nord                " Chooses the colour scheme.

" Tender theme
if (has("termguicolors"))
    set termguicolors
endif

" Nord theme
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_comment_brightness = 20
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
  autocmd BufEnter * if &buftype == "terminal" | startinsert | endif
  tnoremap <Esc> <C-\><C-n>
  command Tsplit split term://$SHELL
  command Tvsplit vsplit term://$SHELL
  command Ttabedit tabedit term://$SHELL
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm""	
endif
" }}}

" Vim-Wiki {{{
" Sets the path to the notes, exports and extension.
let g:vimwiki_list = [{'path': '~/Dropbox/Documents/Notes/',
  \ 'path_html': '~/Dropbox/Documents/notes/html/',
  \ 'ext': '.md',
  \ 'syntax': 'markdown',
  \ 'auto_toc': 1,
  \ 'diary_rel_path': 'diary/',
  \ 'nested_syntaxes': {'python':'python','javascript':'javascipt','go':'go','php':'php'}
  \ }]
" Makes sure that it uses markdown. Also, enforce markdown in all markdown files.
autocmd BufEnter,BufRead,BufNewFile *.md set filetype=markdown
" Extension mapping.
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.mkd': 'markdown'}
" Do not create tempory wiki (seems like a chaos).
let g:vimwiki_global_ext = 0
" Fancy icons.
let g:vimwiki_listsyms = '✗○◐●✓'
" Enables mouse.
let g:vimwiki_use_mouse = 1
" Enables folding.
let g:vimwiki_folding='expr'
" }}}

" Tries to set FireCode as font if it is available {{{
silent! set macligatures
silent! set guifont=Fira\ Code:h15
silent! set GuiFont=Fira\ Code:h15
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
" Escape
imap § <ESC>

" Leader
let mapleader='\'

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
nnoremap B ^
nnoremap E $

"Pane navigation {{{
map <leader><Left> <C-w>h
map <leader><Up> <C-w>k
map <leader><Down> <C-w>j
map <leader><Right> <C-w>l
map <leader>\| :vs<CR>
map <leader>- :split<CR>
" }}}

" Plugins {{{
" Toggle gundo.vim
map <leader>u :GundoToggle<CR>

" Toggles the bracket colouring.
map <leader>b :RainbowToggle<CR>

" Searches a file.
map <leader>f :Files<CR>

" Searches a command.
map <leader>c :Commands<CR>

" Searches a line.
map <leader>l :Lines<CR>

" Searches on Git files.
map <leader>gl :GFiles<CR>

" Searches on the Git Status.
map <leader>gs :GFiles?<CR>

" Opens NERDTree.
map <leader>t :NERDTreeToggle<CR>

" Opens CTags.
if has_ctags
  map <leader>o :TagbarToggle<CR>
endif

" Opens the silver searcher.
if has_ag
  map <leader>a :Ag<CR>
endif

" Omnifunc
map <C-Space> <C-x><C-o>
map! <C-Space> <CR><C-x><C-o>

" Go to next/previous error
map en :lnext<CR>
map ep :lprevious<CR>

" In terminal mode, sets the normal mode key combination to M-ESC.
if is_nvim
  tnoremap <M-Esc> <C-\><C-n>
endif

" }}}

" GUI/TERM especific configuration {{{
" GUI {{{
if g:is_gui
  " Disables the scrollbars {{{
  set guioptions-=r
  set guioptions-=L
  set guioptions-=T
  set guioptions-=m
  " }}}

  " Tabs {{{
  "
  " Press Ctrl-Tab to switch between open tabs (like browser tabs) to
  " the right side. Ctrl-Shift-Tab goes the other way.
  map <C-Tab> :tabnext<CR>
  map <C-S-Tab> :tabprev<CR>

  map! <C-Tab> <C-O>:tabnext<CR>
  map! <C-S-Tab> <C-O>:tabprev<CR>

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
  "}}}

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
  map [B :m .+1<CR>==
  map [A :m .-2<CR>==
  map! [B <Esc>:m .+1<CR>==gi
  map! [A <Esc>:m .-2<CR>==gi
  " }}}

  " Movement keys {{{
  map ^[f e
  map ^[b b
  map! ^[f <Esc>ea
  map! ^[b <Esc>bi
  " }}}

endif
" }}}
" }}}

" Plugins {{{
" fzf {{{
" Customize fzf colors to match your color scheme
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
let g:vim_markdown_fenced_languages = ['python=python', 'go=go', 'javascript=javascript', 'php=php']
" follow anchors
let g:vim_markdown_follow_anchor = 1
" Latex math
let g:vim_markdown_math = 1
" Headers in YAML and JSON.
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" }}}

" Syntastic {{{
" Requires validators. Read the docs.
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_error_symbol = '✘'
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': [] }
let g:syntastic_warning_symbol = "▲"

let g:syntastic_css_checkers = ['csslint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck', 'go']
let g:syntastic_javascript_checkers = ['standard', 'eslint']
let g:syntastic_php_checkers = ['phpmd', 'php']
let g:syntastic_python_checkers = ['flake8', 'pep8', 'python']
let g:syntastic_vue_checkers = ['eslint']
let g:syntastic_yaml_checkers = ['jsyaml', 'yamllint']

" Finds brew's python.
let g:syntastic_python_python_exec = $BREW_PATH.'/bin/python3'

" Forces to use the local eslint.
let g:syntastic_javascript_eslint_exec = '`npm bin`/eslint'
let g:syntastic_vue_eslint_exec = '`npm bin`/eslint'

" Rainbow parenthesis {{{
let g:rainbow_active = 1

autocmd BufNewFile,BufRead :normal RainbowToggle<CR>
autocmd BufNewFile,BufRead :insert <C-O>:RainbowToggle<CR>i
" }}}

" vim-sleuth {{{
autocmd BufReadPre,FileReadPre * :Sleuth
" }}}

" ACK.vim {{{
if g:has_ag
  let g:ackprg = 'ag --vimgrep'
endif
" }}}

" Vim Airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
  let g:airline_symbols.whitespace = 'Ξ'
endif
" }}}

" deoplete.nvim {{{

" deoplete-ternjs {{{
" Starts automatically
let g:deoplete#enable_at_startup = 1
" Adds the documentation for tern completions.
let g:deoplete#sources#ternjs#docs = 1
" Makes in ternjs the completions not case sensitive.
let g:deoplete#sources#ternjs#case_insensitive = 1
" If completions should be returned when inside a literal.
let g:deoplete#sources#ternjs#in_literal = 0
" Add extra filetypes for javascript.
let g:deoplete#sources#ternjs#filetypes = [
  \ 'javascript',
  \ 'jsx',
  \ 'javascript.jsx',
  \ 'vue'
  \ ]
" }}}

" deoplete go {{{
" GoCode path
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
" Sorts the menu.
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" }}}

" phpcd.vim {{{
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
" }}}

" }}}

" vim-paste-easy {{{
let g:paste_easy_message=0
" }}}

" DelimitMate {{{
let delimitMate_expand_cr = 1
" }}}

" UltiSnips {{{
" From https://github.com/SirVer/ultisnips/issues/376#issuecomment-69033351
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
let g:UltiSnipsExpandTrigger="<nop>"
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
" inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
" }}}

" GOYO {{{
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" }}}

" vim-workspace {{{
let g:workspace_powerline_separators = 1
let g:workspace_tab_icon = "\uf00a"
let g:workspace_left_trunc_icon = "\uf0a8"
let g:workspace_right_trunc_icon = "\uf0a9"
" }}}

" vim-go {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = "quickfix"
" }}}

" jedi-vim {{{
 let g:jedi#completions_enabled = 0
 let g:jedi#use_splits_not_buffers = 'right'
 let g:jedi#show_call_signatures = '2'
" }}}

" vim-javascript {{{
let g:javascript_plugin_jsdoc = 1
" }}}

" vim-jsx {{{
let g:jsx_ext_required = 0
" }}}

" vim-vue {{{
autocmd FileType vue syntax sync fromstart
" autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
" }}}

" Airline {{{
let g:airline_theme = 'tender'
let macvim_skip_colorscheme=1
" }}}
"}}}

" Configuration per filetype {{{
" Cleans trailing whitespaces in python and javascript files before saving {{{
autocmd BufWritePre *.{py,js,jsx} call StripTrailingWS()
" }}}

" Language bindings {{{
" All the languages should have the same bindings so it easy to memorise.
" - <leader>k = Documentation.
" - <leader>r = Rename.
" - <leader>ga = Go to assignment.
" - <leader>gi = Go to implementation.
" - <leader>gu = Go to usages.

" Python bindings {{{
let g:jedi#documentation_command = '<leader>k'
let g:jedi#rename_command = '<leader>r'
let g:jedi#goto_assignments_command = '<leader>ga'
let g:jedi#goto_command = '<leader>gi'
let g:jedi#usages_command = '<leader>gu'
" }}}

" Go bindings {{{
autocmd FileType go map <leader>k :GoDoc<CR>
autocmd FileType go map <leader>r :GoRename<CR>
autocmd FileType go map <leader>ga :GoDef<CR>
autocmd FileType go map <leader>gu :GoSameIds<CR>
" }}}

" Javascript bindings {{{
autocmd FileType javascript,javascript.jsx map <leader>k :TernDoc<CR>
autocmd FileType javascript,javascript.jsx map <leader>r :TernRename<CR>
autocmd FileType javascript,javascript.jsx map <leader>ga :TernDef<CR>
autocmd FileType javascript,javascript.jsx map <leader>gu :TernRefs<CR>
" }}}

" TypeScript bindings {{{
autocmd FileType typescript map <leader>k :TSDoc<CR>
autocmd FileType typescript map <leader>r :TSRename<CR>
autocmd FileType typescript map <leader>ga :TSDef<CR>
autocmd FileType typescript map <leader>gu :TSRefs<CR>
" }}}

" PHP bindings {{{
autocmd FileType php map <leader>ga <C>]
" }}}

" }}}

" Python {{{
autocmd FileType python,yaml BracelessEnable +indent +fold +highlight
" }}}

" TypeScript {{{
autocmd BufEnter *.tsx set filetype=typescript
" }}}

" Bash {{{
autocmd FileType sh set textwidth=0
" }}}

" Go {{{
autocmd FileType go nmap <leader>gr <Plug>(go-run)
autocmd FileType go nmap <leader>gb <Plug>(go-build)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
autocmd FileType go nmap <leader>gc <Plug>(go-coverage)
autocmd FileType go nmap <leader>gd <Plug>(go-doc)
autocmd FileType go nmap <leader>gv <Plug>(go-doc-vertical)
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
" }}}
" }}}

" tern_for_vim {{{
" Use global tern
let g:tern#command = ['tern']
" Make it persistent so it can be reused by deoplete-ternjs.
let g:tern#arguments = ['--persistent']
" }}}

" vim:foldmethod=marker:foldlevel=0
