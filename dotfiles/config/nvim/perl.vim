" cpanm Perl::Critic Perl::Tidy Perl::LanguageServer
augroup perl_configuration
  au!
  au FileType perl setlocal foldmethod=syntax
  au FileType perl set shiftwidth=4
  au FileType perl set softtabstop=4
  au FileType perl set tabstop=4
augroup END
