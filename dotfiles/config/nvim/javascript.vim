" npm install -g typescript typescript-language-server prettier vls
augroup js_configuration
  au!
  autocmd FileType vue syntax sync fromstart
  autocmd BufEnter *.tsx set filetype=typescript.tsx
  autocmd BufEnter *.jsx set filetype=javascript.jsx
  autocmd FileType json syntax match Comment +\/\/.\+$+
  au FileType javascript,typescript,javascript.jsx,typescript.tsx,json,vue setlocal foldmethod=syntax
  au FileType javascript,typescript,javascript.jsx,typescript.tsx,json,vue set shiftwidth=2
  au FileType javascript,typescript,javascript.jsx,typescript.tsx,json,vue set softtabstop=2
  au FileType javascript,typescript,javascript.jsx,typescript.tsx,json,vue set tabstop=2

  if executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'js-ls',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
          \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
          \ })
  endif

  if executable('vls')
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'vls',
          \ 'cmd': {server_info->['vls']},
          \ 'whitelist': ['vue']
          \ })
  endif

  " Other Prettier.
  if executable('prettier')
    au BufWritePre *.css,*.less,*.scss,*.json,*.graphql,*.md,*.yaml,*.html Prettier
  endif
augroup END

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
set conceallevel=0

if (filereadable(expand('%:p:h').'/node_modules/.bin/eslint'))
  let g:ale_javascript_eslint_executable =  expand('%:p:h').'/node_modules/.bin/eslint'
else
  let g:ale_javascript_eslint_executable = '/home/threkk/.config/eslint/node_modules/.bin/eslint'
endif


if (filereadable(expand('%:p:h').'/eslintrc.json'))
  let g:ale_javascript_eslint_options = '-C '.expand('%:p:h').'/eslintrc.json'
else
  let g:ale_javascript_eslint_options = '-C /home/threkk/.config/eslint/eslintrc.json'
endif
