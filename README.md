# dotfiles

A collection with all the dotfiles and plugins I use. The branch of this repository contains the configuration for:
- Atom
- iTerm

The reason of having them separated is because it only makes sense to use them
in a GUI environment.

If you want to use the same configuration, execute the following commands on your root directory:

```
mv .atom .atom.old
git clone https://github.com/threkk/dotfiles.git
git fetch
git checkout gui
mv dotfiles .dotfiles-gui
ln -s .dotfiles-gui/atom  .atom
ln -s .dotfiles-gui/iterm .iterm
```

## iTerm

You have to go to preferences, enable ```Load preferences from a custom folder
or url``` and point to ```/Users/<user>/.iterm```

## Atom

Nothing :D

License: MIT
