" .vimrc - Alberto de Murga <alberto@threkk.com>
 
" Lazy loading
" From https://github.com/junegunn/vim-plug/wiki/faq#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

let is_vim = !has('nvim')
let is_nvim = has('nvim')

if is_nvim
    let $BASE = stdpath('config')
else
    let $BASE = '$HOME/.vim'
endif

if is_nvim
  call plug#begin($BASE.'/plugged')

    " Basic configuration for client specifics
    Plug 'wincent/terminus'                             " Improves term sup.
    Plug 'tpope/vim-eunuch'                             " Improves unix support 
    Plug 'equalsraf/neovim-gui-shim',                   " Shims for UI config.
    Plug 'nvim-lua/plenary.nvim',                       " Supporting library
    Plug 'nvim-lua/popup.nvim',                         " Supporting library
    Plug 'roxma/vim-paste-easy'                         " Fixes pasting.
    Plug 'ojroques/vim-oscyank'                         " Copy-paste
    Plug 'echasnovski/mini.nvim'                        " Multiple general plugins

    " Popups, messages and notifications
    Plug 'MunifTanjim/nui.nvim'                         " Supporting library
    Plug 'rcarriga/nvim-notify'                         " Supporting library
    Plug 'folke/noice.nvim'                             " Better popups

    " Brackets
    Plug 'luochen1990/rainbow'                          " Brackets color.

    " Search
    Plug 'nvim-telescope/telescope.nvim'                " Moving around in nvim

    " Debugger
    Plug 'mfussenegger/nvim-dap'                        " Debugger
    Plug 'rcarriga/nvim-dap-ui'                         " Debugger ui

    " Language support
    Plug 'nvim-treesitter/nvim-treesitter'              " Syntax trees for neovim
    Plug 'neovim/nvim-lspconfig'                        " LSP configuration
    Plug 'williamboman/mason.nvim'                      " LSP manager
    Plug 'williamboman/mason-lspconfig.nvim'            " LSP automatic setup
    Plug 'sigmasd/deno-nvim'                            " Improves deno support
    Plug 'b0o/schemastore.nvim'                         " Improves JSONLS support

    Plug 'mfussenegger/nvim-lint'                       " Linter
    Plug 'mhartington/formatter.nvim'                   " Formatter
    
    " Other
    Plug 'folke/twilight.nvim'                          " Dims other blocks of text
    Plug 'lenovsky/nuake'                               " Floating terminal
    Plug 'terryma/vim-multiple-cursors'                 " Mutiple cursors.
    Plug 'tpope/vim-sleuth'                             " Set tabs and spaces.
    Plug 'OXY2DEV/markview.nvim'                        " Markdown preview
    Plug 'https://tildegit.org/sloum/gemini-vim-syntax' " Gemini syntax highlight 

    " Themes
    Plug 'arcticicestudio/nord-vim'
    Plug 'chriskempson/base16-vim'
    Plug 'cocopon/iceberg.vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'folke/tokyonight.nvim'
    Plug 'jacoborus/tender'
    Plug 'rakr/vim-one' 

  call plug#end()
endif

source $BASE/common.vim
source $BASE/plugins.vim

" Languages
source $BASE/languages/golang.vim
source $BASE/languages/javascript.vim
source $BASE/languages/other.vim
source $BASE/languages/perl.vim
source $BASE/languages/python.vim

if is_nvim
  " General
  lua require('tree_sitter')
  lua require('mini_conf')
  lua require('other')
  lua require('lsp')  
  lua require('linter')
  lua require('telescope_bindings')
else
  source $BASE/only_vim.vim
endif
