# dotfiles

A collection with all the dotfiles and plugins I use. This repository contains
the configuration for:
- Vim
- Atom
- iTerm

If you want to use the same configuration, execute the following commands on
your root directory:

```
mv .vim .vim.old
mv .vimrc .vimrc.old
mv .atom .atom.old
git clone https://github.com/threkk/dotfiles.git
mv dotfiles .dotfiles
ln -s .dotfiles/atom  .atom
ln -s .dotfiles/iterm .iterm
ln -s .dotfiles/vim   .vim
ln -s .dotfiles/vim/vimrc.txt .vimrc
```

## Vim
To install all the plugins and themes, you need to use Plug.

Open vim (it will give an error, press ENTER) and type:
```
:PlugInstall
```

To read the complete [Plug commands](https://github.com/junegunn/vim-plug).

## iTerm
You have to go to preferences, enable ```Load preferences from a custom folder
or url``` and point to ```/Users/<user>/.iterm```

## Atom
Nothing :D

License: MIT
