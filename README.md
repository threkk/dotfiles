# dotfiles

Personal configuration for several softwares. Described here to have an easy way

Clone the repository in `~/.dotfiles` and link the configuration files.
```
git clone https://github.com/threkk/dotfiles.git ~/.dotfiles
```

### `config` folder
```
ln -s ~/.dotfiles/dotfiles/config ~/.config
```

### ZSH
```
ln -s ~/.dotfiles/dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/dotfiles/alias ~/.alias
ln -s ~/.dotfiles/dotfiles/exports ~/.exports
``` 

### Git
Maybe you need to update your `gpg` binary. 
```
ln -s ~/.dotfiles/dotfiles/gitconfig ~/.gitconfig
```

### TMUX
```
ln -s ~/.dotfiles/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/dotfiles/tmux.d ~/.tmux.d
```

### Scripts
`scripts` is a [little project of mine](https://github.com/threkk/scripts).
I compile useful scripts I find or create. There are several of them that I find
useful to have them in my path, but it implies to keep it updated.

To solve this issue, the configurations loads a folder `~/.bin` in which I
place or link my scripts.

## License
BSD-3 (c) Alberto Martinez de Murga Ramirez
