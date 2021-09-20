" npm install -g typescript typescript-language-server prettier vls
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
