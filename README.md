# dotfiles

A collection with all the dotfiles and plugins I use. The branch of this
repository contains the configuration for:

- Vim
- iTerm2
- Tern.js
- Git

If you want to use the same configuration, execute the following commands on
your root directory:

```
mv .vim .vim.old
mv .vimrc .vimrc.old
git clone https://github.com/threkk/dotfiles.git
mv dotfiles .dotfiles
ln -s .dotfiles/vim .config/vim
ln -s .dotfiles/vim .vim
ln -s .dotfiles/vim/init.vim .vimrc
vim +PlugInstall
```

## Vim

To install all the plugins and themes, you need to use Plug.

Open vim (it will give an error, press ENTER) and type:
```
:PlugInstall
```

To read the complete [Plug commands](https://github.com/junegunn/vim-plug).

License: MIT
