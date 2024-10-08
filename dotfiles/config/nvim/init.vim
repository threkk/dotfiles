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
    Plug 'ryanoasis/vim-devicons'                       " Nerd font viml support
    Plug 'kyazdani42/nvim-web-devicons',                " Nerd font lua support
    Plug 'roxma/vim-paste-easy'                         " Fixes pasting.
    Plug 'luukvbaal/stabilize.nvim',                    " Stabilises the UI.
    Plug 'wellle/targets.vim'                           " Provides additional text objects 
    Plug 'ojroques/vim-oscyank'                         " Copy-paste
    Plug 'echasnovski/mini.nvim'                        " Mini

    " File tree menu
    Plug 'preservim/nerdtree'                           " File tree.
    Plug 'Xuyuanp/nerdtree-git-plugin'                  " with git support

    " Lightline 
    Plug 'itchyny/lightline.vim'                        " Better statusline.

    " Brackets
    Plug 'tpope/vim-surround'                           " Brackets operations.
    Plug 'luochen1990/rainbow'                          " Brackets color.
    Plug 'cohama/lexima.vim'                            " Closes parenthesis

    " Git  
    Plug 'lewis6991/gitsigns.nvim'                      " Git diff in neovim

    " Comments
    Plug 'tpope/vim-commentary'

    " Search
    Plug 'nvim-telescope/telescope.nvim'                " Moving around in nvim

    " Blocks
    Plug 'lukas-reineke/indent-blankline.nvim'          " Indicates the block line in nvim

    " Debugger
    Plug 'mfussenegger/nvim-dap'                        " Debugger
    Plug 'rcarriga/nvim-dap-ui'                         " Debugger ui

    " Language support
    Plug 'nvim-treesitter/nvim-treesitter'              " Syntax colouring for neovim
    Plug 'neovim/nvim-lspconfig'                        " LSP configuration
    Plug 'hrsh7th/vim-vsnip'                            " Required by nvim-comp
    Plug 'hrsh7th/cmp-vsnip'                            " Required by nvim-comp
    Plug 'sigmasd/deno-nvim'                            " Improves deno support
    Plug 'b0o/schemastore.nvim'                         " Improves JSONLS support
    Plug 'williamboman/mason.nvim'                      " LSP manager
    Plug 'williamboman/mason-lspconfig.nvim'            " Supporting package

    Plug 'mfussenegger/nvim-lint'                       " Linter
    Plug 'mhartington/formatter.nvim'                   " Formatter

    Plug 'rafamadriz/friendly-snippets'                 " Snippets for autocompletion
    Plug 'liuchengxu/vista.vim'                         " Tags
    Plug 'jxnblk/vim-mdx-js'                            " MDX syntax highlight
    Plug 'j-hui/fidget.nvim'                            " LSP progress info
    Plug 'https://tildegit.org/sloum/gemini-vim-syntax' " Gemini syntax highlight 

    " Autcomplete
    Plug 'hrsh7th/nvim-cmp'                             " Autocomplete
    Plug 'hrsh7th/cmp-nvim-lsp'                         " LSP support
    Plug 'hrsh7th/cmp-buffer'                           " Buffer support
    Plug 'hrsh7th/cmp-path'                             " Path support
    Plug 'hrsh7th/cmp-nvim-lua'                         " Neovim Lua API
    Plug 'onsails/lspkind-nvim'                         " Meta information
    " Plug 'hrsh7th/cmp-nvim-lsp-signature-help'        " Signature helper

    " Noice
    Plug 'folke/noice.nvim'                             " Noice alerts
    Plug 'MunifTanjim/nui.nvim'                         " Requirement for the noice alerts.
    Plug 'rcarriga/nvim-notify'                         " Makes them appear

    " Other
    Plug 'bagrat/vim-workspace'                         " Tab appeareance
    Plug 'ahmedkhalf/project.nvim'                      " Project management
    Plug 'easymotion/vim-easymotion'                    " Move around the place
    Plug 'folke/twilight.nvim'                          " Dims other blocks of text
    Plug 'godlygeek/tabular'                            " Aligns stuff.
    Plug 'gorodinskiy/vim-coloresque'                   " Colours preview.
    Plug 'lenovsky/nuake'                               " Floating terminal
    Plug 'terryma/vim-multiple-cursors'                 " Mutiple cursors.
    Plug 'tpope/vim-sleuth'                             " Set tabs and spaces.

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
  lua require('other')
  lua require('tree_sitter')
  lua require('lsp')  
  lua require('autocomp')
  lua require('linter')
  lua require('telescope_bindings')

  " Languages
  lua require('languages.go')
  lua require('languages.javascript')
  lua require('languages.other')
  lua require('languages.perl')
  lua require('languages.python')
else
  source $BASE/only_vim.vim
endif
