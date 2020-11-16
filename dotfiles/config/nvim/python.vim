" pip install python-language-server
augroup python_configuration
  au!
  au FileType python setlocal foldmethod=syntax
  au FileType python set shiftwidth=4
  au FileType python set softtabstop=4
  au FileType python set tabstop=4
  autocmd FileType python,yaml BracelessEnable +indent +fold +highlight

  if executable('pyls')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'whitelist': ['python'],
          \ 'workspace_config': { 'pyls': { 'plugins': {
          \   'pydocstyle': { 'enabled': v:true },
          \   'pyls_mypy': {'enabled': v:true },
          \   'pyls_isort': {'enabled': v:true },
          \   'pyls_black': {'enabled': v:true}
          \ }}}
          \ })
  endif
augroup END

let g:ale_python_flake8_options = '--max-line-length=88'
