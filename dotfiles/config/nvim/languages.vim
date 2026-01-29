" Go
augroup go_configuration
  au!
  autocmd FileType go set noexpandtab
  autocmd FileType go set shiftwidth=4
  autocmd FileType go set softtabstop=4
  autocmd FileType go set tabstop=4
augroup END

" JS
augroup js_configuration
  au!
  autocmd FileType vue syntax sync fromstart
  autocmd BufEnter *.tsx set filetype=typescriptreact
  autocmd BufEnter *.jsx set filetype=javascriptreact
  autocmd FileType json syntax match Comment +\/\/.\+$+
  au FileType javascript,typescript,javascript.jsx,typescript.tsx,javascriptreact,typescriptreact,json,vue setlocal foldmethod=syntax
  au FileType javascript,typescript,javascript.jsx,typescript.tsx,javascriptreact,typescriptreact,json,vue set shiftwidth=2
  au FileType javascript,typescript,javascript.jsx,typescript.tsx,javascriptreact,typescriptreact,json,vue set softtabstop=2
  au FileType javascript,typescript,javascript.jsx,typescript.tsx,javascriptreact,typescriptreact,json,vue set tabstop=2
augroup END

augroup astro_configuration
  au!
  autocmd BufEnter *.astro set filetype=astro
augroup END

" Bash, Dockerfile
autocmd FileType sh,Dockerfile set textwidth=0

" Perl
augroup perl_configuration
  au!
  au FileType perl setlocal foldmethod=syntax
  au FileType perl set shiftwidth=4
  au FileType perl set softtabstop=4
  au FileType perl set tabstop=4
augroup END

" Python
augroup python_configuration
  au!
  au FileType python setlocal foldmethod=syntax
  au FileType python set shiftwidth=4
  au FileType python set softtabstop=4
  au FileType python set tabstop=4
  autocmd FileType python,yaml BracelessEnable +indent +fold +highlight
augroup END
