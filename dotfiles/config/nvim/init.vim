" .vimrc - Alberto de Murga <alberto@threkk.com>

" Lazy loading
" From https://github.com/junegunn/vim-plug/wiki/faq#conditional-activation
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

let is_vim = !has('nvim')
let is_nvim = has('nvim')
let has_terminal = has('nvim') || has('terminal')

if is_nvim
    let $BASE = stdpath('config')
else
    let $BASE = '$HOME/.vim'
endif

call plug#begin($BASE.'/plugged')

  " Basic configuration for client specifics
  Plug 'tpope/vim-sensible', Cond(is_vim)             " Basic conf.
  Plug 'wincent/terminus'                             " Improves term sup.
  Plug 'tpope/vim-eunuch'                             " Improves unix support 
  Plug 'equalsraf/neovim-gui-shim', Cond(is_nvim)     " Shims for UI config.
  Plug 'nvim-lua/plenary.nvim', Cond(is_nvim)         " Supporting library
  Plug 'nvim-lua/popup.nvim', Cond(is_nvim)           " Supporting library
  Plug 'ryanoasis/vim-devicons'                       " Nerd font viml support
  Plug 'kyazdani42/nvim-web-devicons', Cond(is_nvim)  " Nerd font lua support
  Plug 'roxma/vim-paste-easy'                         " Fixes pasting.
  Plug 'luukvbaal/stabilize.nvim', Cond(is_nvim)      " Stabilises the UI.
  Plug 'wellle/targets.vim'                           " Provides additional text objects 
  Plug 'ojroques/vim-oscyank'                         " Copy-paste

  " File tree menu
  Plug 'preservim/nerdtree'                               " File tree.
  Plug 'Xuyuanp/nerdtree-git-plugin'                      " with git support

  " Lightline 
  Plug 'itchyny/lightline.vim'                            " Better statusline.

  " Brackets
  Plug 'tpope/vim-surround'                               " Brackets operations.
  Plug 'luochen1990/rainbow'                              " Brackets color.
  Plug 'cohama/lexima.vim'                                " Closes parenthesis

  " Git  
  " Plug 'tpope/vim-fugitive'                             " Git basic commands.
  Plug 'airblade/vim-gitgutter', Cond(is_vim)             " Git diff in vim
  Plug 'lewis6991/gitsigns.nvim', Cond(is_nvim)           " Git diff in neovim

  " Comments
  Plug 'tpope/vim-commentary'

  " Search
  Plug 'nvim-telescope/telescope.nvim', Cond(is_nvim)     " Moving around in nvim
  Plug 'ctrlpvim/ctrlp.vim', Cond(is_vim)                 " Moving around in vim
  Plug 'mileszs/ack.vim'                                  " ACK, AG, RG...
  Plug 'LintaoAmons/bookmarks.nvim', Cond(is_nvim)        " Bookmarks

  " Blocks
  " Plug 'tweekmonster/braceless.vim', Cond(is_vim)             " Indicates the block line in vim
  Plug 'lukas-reineke/indent-blankline.nvim', Cond(is_nvim)   " Indicates the block line in nvim

  " Debugger
  Plug 'mfussenegger/nvim-dap', Cond(is_nvim)                 " Debugger
  Plug 'rcarriga/nvim-dap-ui', Cond(is_nvim)                  " Debugger ui

  " Language support
  Plug 'nvim-treesitter/nvim-treesitter', Cond(is_nvim)       " Syntax colouring for neovim
  Plug 'sheerun/vim-polyglot', Cond(is_vim)                   " Syntax colouring for vim 
  Plug 'neovim/nvim-lspconfig', Cond(is_nvim)                 " LSP configuration
  Plug 'hrsh7th/vim-vsnip', Cond(is_nvim)                     " Required by nvim-comp
  Plug 'hrsh7th/cmp-vsnip', Cond(is_nvim)                     " Required by nvim-comp
  Plug 'sigmasd/deno-nvim', Cond(is_nvim)                     " Improves deno support
  Plug 'b0o/schemastore.nvim', Cond(is_nvim)                  " Improves JSONLS support
  Plug 'williamboman/mason.nvim', Cond(is_nvim)               " LSP manager
  Plug 'williamboman/mason-lspconfig.nvim', Cond(is_nvim)     " Supporting package
 
  Plug 'mfussenegger/nvim-lint', Cond(is_nvim)                " Linter
  Plug 'mhartington/formatter.nvim', Cond(is_nvim)            " Formatter

  Plug 'rafamadriz/friendly-snippets', Cond(is_nvim)          " Snippets for autocompletion
  Plug 'liuchengxu/vista.vim'                                 " Tags
  Plug 'jxnblk/vim-mdx-js'                                    " MDX syntax highlight
  Plug 'j-hui/fidget.nvim', Cond(is_nvim)                     " LSP progress info
  Plug 'https://tildegit.org/sloum/gemini-vim-syntax'         " Gemini syntax highlight 

  " Autcomplete
  Plug 'hrsh7th/nvim-cmp', Cond(is_nvim)                      " Autocomplete
  Plug 'hrsh7th/cmp-nvim-lsp', Cond(is_nvim)                  " LSP support
  Plug 'hrsh7th/cmp-buffer', Cond(is_nvim)                    " Buffer support
  Plug 'hrsh7th/cmp-path', Cond(is_nvim)                      " Path support
  Plug 'hrsh7th/cmp-nvim-lua', Cond(is_nvim)                  " Neovim Lua API
  Plug 'onsails/lspkind-nvim', Cond(is_nvim)                  " Meta information
  " Plug 'hrsh7th/cmp-nvim-lsp-signature-help', Cond(is_nvim)  " Signature helper

" Noice
  Plug 'folke/noice.nvim', Cond(is_nvim)                " Noice alerts
  Plug 'MunifTanjim/nui.nvim', Cond(is_nvim)            " Requirement for the noice alerts.
  Plug 'rcarriga/nvim-notify', Cond(is_nvim)            " Makes them appear

  " Other
  Plug 'bagrat/vim-workspace'                           " Tab appeareance
  Plug 'ahmedkhalf/project.nvim', Cond(is_nvim)         " Project management
  Plug 'easymotion/vim-easymotion'                      " Move around the place
  Plug 'editorconfig/editorconfig-vim', Cond(is_vim)    " Editorconfig support
  Plug 'folke/twilight.nvim', Cond(is_nvim)             " Dims other blocks of text
  Plug 'godlygeek/tabular'                              " Aligns stuff.
  Plug 'gorodinskiy/vim-coloresque'                     " Colours preview.
  Plug 'lenovsky/nuake', Cond(has_terminal)             " Floating terminal
  Plug 'terryma/vim-multiple-cursors'                   " Mutiple cursors.
  Plug 'tpope/vim-sleuth'                               " Set tabs and spaces.

  " Themes
  Plug 'arcticicestudio/nord-vim'
  Plug 'chriskempson/base16-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'folke/tokyonight.nvim', Cond(is_nvim)
  Plug 'jacoborus/tender'
  Plug 'rakr/vim-one' 

call plug#end()

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
