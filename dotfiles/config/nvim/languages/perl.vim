" cpanm Perl::Critic Perl::Tidy Perl::LanguageServer
augroup perl_configuration
  au!
  au FileType perl setlocal foldmethod=syntax
  au FileType perl set shiftwidth=4
  au FileType perl set softtabstop=4
  au FileType perl set tabstop=4

  if executable('perl')
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'perl-languageserver',
      \ 'cmd': {server_info->['perl', '-MPerl::LanguageServer', '-e', 'Perl::LanguageServer->run']},
      \ 'initialization_options': v:null,
      \ 'whitelist': ['perl'],
      \ })
  endif
augroup END
