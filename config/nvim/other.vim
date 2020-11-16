" Bash, Dockerfile {{{
autocmd FileType sh,Dockerfile set textwidth=0
" }}}

" YAML configuration {{{
if executable('yaml-language-server')
  augroup LspYaml
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'yaml-language-server',
          \ 'cmd': {server_info->['yaml-language-server', '--stdio']},
          \ 'whitelist': ['yaml', 'yaml.ansible'],
          \ 'workspace_config': {
          \   'yaml': {
          \     'validate': v:true,
          \     'hover': v:true,
          \     'completion': v:true,
          \     'customTags': [],
          \     'schemas': {},
          \     'schemaStore': { 'enable': v:true },
          \   }
          \ }
          \})
  augroup END
endif

" HTML configuration {{{
" npm install --global vscode-html-languageserver-bin
if executable('html-languageserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'html-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
        \ 'whitelist': ['html'],
        \ })
endif
" }}}

" JSON configuration {{{
" npm install --global vscode-json-languageserver
if executable('vscode-json-languageserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'vscode-json-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'vscode-json-languageserver --stdio']},
        \ 'initialization_options': {'provideFormatter': v:true},
        \ 'workspace_config': {'json': {'format': {'enable': v:true}}},
        \ 'whitelist': ['json'],
        \ })
endif
" }}}

" Docker configuration {{{
" npm install -g dockerfile-language-server-nodejs
if executable('docker-langserver')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'whitelist': ['dockerfile'],
        \ })
endif
" }}}

" vim-markdown {{{
" Adds a TOC
let g:vim_markdown_toc_autofit = 1
" Add syntax highlight.
let g:vim_markdown_fenced_languages = ['python=python', 'go=go', 'javascript=javascript']
" follow anchors
let g:vim_markdown_follow_anchor = 1
" Latex math
let g:vim_markdown_math = 1
" Headers in YAML and JSON.
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1

" Do not autoclose the preview window.
let g:mkdp_auto_close = 1
" }}}
