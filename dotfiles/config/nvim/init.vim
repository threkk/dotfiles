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

call plug#begin($BASE.'/plugged')

  " Basic configuration for client specifics
  Plug 'tpope/vim-sensible', Cond(is_vim)             " Basic conf.
  Plug 'wincent/terminus'                             " Improves term sup.
  Plug 'equalsraf/neovim-gui-shim', Cond(is_nvim)     " Shims for UI config.
  Plug 'nvim-lua/plenary.nvim', Cond(is_nvim)         " Supporting library
  Plug 'ryanoasis/vim-devicons'                       " Nerd font viml support
  Plug 'kyazdani42/nvim-web-devicons', Cond(is_nvim)  " Nerd font lua support
  Plug 'vim-scripts/ReplaceWithRegister'              " Replaces the current selection with a register.
  Plug 'roxma/vim-paste-easy'                         " Fixes pasting.

  " File tree menu
  Plug 'scrooloose/nerdtree'                              " File tree.
  Plug 'Xuyuanp/nerdtree-git-plugin'                      " with git support

  " Lightline 
  Plug 'itchyny/lightline.vim'                            " Better statusline.

  " Brackets
  Plug 'tpope/vim-surround'                               " Brackets operations.
  Plug 'luochen1990/rainbow'                              " Brackets color.
  Plug 'cohama/lexima.vim'                                " Closes parenthesis

  " Git  
  Plug 'tpope/vim-fugitive'                               " Git basic commands.
  Plug 'airblade/vim-gitgutter', Cond(is_vim)             " Git diff in vim
  Plug 'lewis6991/gitsigns.nvim', Cond(is_nvim)           " Git diff in neovim

  " Comments
  Plug 'tpope/vim-commentary'

  " Search
  Plug 'nvim-telescope/telescope.nvim', Cond(is_nvim)     " Moving around in nvim
  Plug 'ctrlpvim/ctrlp.vim', Cond(is_vim)                 " Moving around in vim
  Plug 'mileszs/ack.vim'                                  " ACK, AG, RG...

  " Blocks
  Plug 'tweekmonster/braceless.vim', Cond(is_vim)             " Indicates the block line in vim
  Plug 'lukas-reineke/indent-blankline.nvim', Cond(is_nvim)   " Indicates the block line in nvim

  " Language support
  Plug 'nvim-treesitter/nvim-treesitter', Cond(is_nvim)       " Syntax colouring
  Plug 'neovim/nvim-lspconfig', Cond(is_nvim)                 " LSP configuration
  Plug 'glepnir/lspsaga.nvim', Cond(is_nvim)                  " LSP UI
  Plug 'jose-elias-alvarez/null-ls.nvim', Cond(is_nvim)       " LSP for other tools
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils', Cond(is_nvim)  " Improves JS tooling
  Plug 'liuchengxu/vista.vim'                                 " Tags

  " Other
  Plug 'bagrat/vim-workspace'                           " Tab appeareance
  Plug 'easymotion/vim-easymotion'                      " Move around the place
  Plug 'editorconfig/editorconfig-vim'                  " Editorconfig support
  Plug 'folke/twilight.nvim', Cond(is_nvim)             " Dims other blocks of text
  Plug 'godlygeek/tabular'                              " Aligns stuff.
  Plug 'gorodinskiy/vim-coloresque'                     " Colours preview.
  Plug 'lenovsky/nuake'                                 " Floating terminal
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
  lua require('null_ls')
  lua require('telescope')

  " Languages
  lua require('languages.go')
  lua require('languages.javascript')
  lua require('languages.other')
  lua require('languages.perl')
  lua require('languages.python')
else
  source $BASE/only_vim.vim
endif
