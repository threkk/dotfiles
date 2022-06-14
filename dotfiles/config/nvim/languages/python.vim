" pip install python-language-server
augroup python_configuration
  au!
  au FileType python setlocal foldmethod=syntax
  au FileType python set shiftwidth=4
  au FileType python set softtabstop=4
  au FileType python set tabstop=4
  autocmd FileType python,yaml BracelessEnable +indent +fold +highlight
augroup END

let g:ale_python_flake8_options = '--max-line-length=88'
