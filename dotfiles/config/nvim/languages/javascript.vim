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
