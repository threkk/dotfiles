" .vimrc - Alberto de Murga <alberto@threkk.com>

" Lazy loading
" From https://github.com/junegunn/vim-plug/wiki/faq#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

if has('nvim')
    let $BASE = stdpath('config')
else
    let $BASE = '$HOME/.vim'
endif

call plug#begin($BASE.'/plugged')

  " Basic configuration for client specifics {{{
  Plug 'tpope/vim-sensible', Cond(!has('nvim'))           " Basic conf.
  Plug 'wincent/terminus'                                 " Improves term sup.
  Plug 'equalsraf/neovim-gui-shim', Cond(has('nvim'))     " Shims for UI config.
  Plug 'nvim-lua/plenary.nvim', Cond(has('nvim'))         " Supporting library
  Plug 'kyazdani42/nvim-web-devicons'                     " Nerd font support
  " }}}

  " File tree menu {{{
  Plug 'scrooloose/nerdtree'                            " File tree.
  Plug 'Xuyuanp/nerdtree-git-plugin'                      " with git support
  " }}}

  " Lightline {{{
  Plug 'itchyny/lightline.vim'                            " Better statusline.
  Plug 'maximbaz/lightline-ale'                           " ALE integration
  " }}}

  " Brackets {{{
  Plug 'tpope/vim-surround'                               " Brackets operations.
  Plug 'luochen1990/rainbow'                              " Brackets color.
  Plug 'cohama/lexima.vim'                                " Closes parenthesis
  " }}}

  " Git {{{
  Plug 'tpope/vim-fugitive',     Cond(has('git'))         " Git basic commands.
  Plug 'airblade/vim-gitgutter', Cond(has('git'))         " Git Diff.
  " }}}

  " Comments {{{
  Plug 'tpope/vim-commentary'
  " }}}

  " Search {{{
  Plug 'nvim-telescope/telescope.nvim'
  " Plug 'mileszs/ack.vim'                                " ACK, AG, RG...
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
  Plug 'tpope/vim-sleuth'                               " Set tabs and spaces.
  Plug 'gorodinskiy/vim-coloresque'                     " Colours preview.
  Plug 'vim-scripts/ReplaceWithRegister'                " Replaces the current selection with a register.
  Plug 'easymotion/vim-easymotion'                      " Move around the place
  Plug 'lenovsky/nuake'                                 " Floating terminal
  Plug 'editorconfig/editorconfig-vim'                  " Editorconfig support
  " }}}

  " Languages {{{
  Plug 'tweekmonster/braceless.vim'                               " Indicates the block line.
  Plug 'nvim-treesitter/nvim-treesitter', Cond(has('nvim'))       " Syntax colouring
  Plug 'neovim/nvim-lspconfig', Cond(has('nvim'))                 " LSP configuration
  Plug 'glepnir/lspsaga.nvim', Cond(has('nvim'))                  " LSP UI
  Plug 'jose-elias-alvarez/null-ls.nvim', Cond(has('nvim'))       " LSP for other tools
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils', Cond(has('nvim'))  " Improves JS tooling
  Plug 'liuchengxu/vista.vim'                                     " Tags
  " }}}

  " Themes {{{
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'jacoborus/tender'
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'chriskempson/base16-vim'   
" }}}

call plug#end()

source $BASE/common.vim

" Plugins {{{

" NerdTree Git {{{
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
" }}}

" Editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*'] " Make it work with fugitive
"}}}

" Rainbow parenthesis {{{
let g:rainbow_active = 1

autocmd BufNewFile,BufRead :normal RainbowToggle<CR>
" }}}

" vim-sleuth {{{
autocmd BufReadPre,FileReadPre * :Sleuth
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

" Vista does not want to work in Lua.
let g:vista_default_executive = 'nvim_lsp'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#icons = {
      \   "function": "\uf794",
      \   "variable": "\uf71b",
      \  }

" Python
source $BASE/languages/python.vim

" JavaScript/TypeScript
source $BASE/languages/javascript.vim

" Go
source $BASE/languages/golang.vim

" Perl
source $BASE/languages/perl.vim

" Other
source $BASE/languages/other.vim

if has('nvim')
  " General
  lua require('general')
  lua require('tree_sitter')
  lua require('lsp')  
  lua require('null_ls')
  lua require('telescope')

  " Languages
  lua require('languages.go')
  lua require('languages.javascript')
  lua require('languages.other')
  lua require('languages.perl')
  lua require('languages.python')
endif

"vim:foldmethod=marker:foldlevel=0
